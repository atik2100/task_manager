import 'package:flutter/material.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/widgets/background.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_massege.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static String name = "/add_new_task_screen";

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _createNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const TmAppBar(),
      body: Background(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text("Add New Task",style: textTheme.titleLarge),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: const InputDecoration(
                      hintText: "Title",
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty?? true ){
                        return "Enter Your Title Here";
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      hintText: "Description",
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty?? true ){
                        return "Enter Your Description Here";
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: _createNewTaskInProgress == false,
                    replacement: const CenteredCircularProgressBar(),
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          _createNewTask();
                          //print("token => ${AuthController.accessToken}");
                        }
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Future<void> _createNewTask() async {
    _createNewTaskInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "title":_titleTEController.text.trim(),
      "description":_descriptionTEController.text.trim(),
      "status":"New"
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createNewTaskUrl, body: requestBody);
    _createNewTaskInProgress = false;
    setState(() {});

    if(response.isSuccess){
      _clearTextFields();
      showSnackBarMassage(context, 'New Task Added Successful');
    } else{
      showSnackBarMassage(context, response.errorMassage);
    }
  }

  void _clearTextFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
