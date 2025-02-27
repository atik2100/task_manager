import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/add_new_task_controller.dart';
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
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddNewTaskController _addNewTaskController =
      Get.find<AddNewTaskController>();

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
                  Text("Add New Task", style: textTheme.titleLarge),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: const InputDecoration(
                      hintText: "Title",
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
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
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your Description Here";
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  GetBuilder<AddNewTaskController>(builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress == false,
                      replacement: const CenteredCircularProgressBar(),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _createNewTask();
                            //print("token => ${AuthController.accessToken}");
                          }
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createNewTask() async {
    bool isSuccess = await _addNewTaskController.createNewTask(
      _titleTEController.text.trim(),
      _descriptionTEController.text.trim(),
      "New",
    );

    if (isSuccess) {
      _clearTextFields();
      showSnackBarMassage(context, _addNewTaskController.successMassage!);
    } else {
      showSnackBarMassage(context, _addNewTaskController.errorMassage!);
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
