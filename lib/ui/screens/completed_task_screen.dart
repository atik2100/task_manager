import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/ui/controller/complete_task_list_controller.dart';
import 'package:task_manager/ui/widgets/background.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_massege.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/tm_app_bar.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompleteTaskListController _completeTaskListController = Get.find<CompleteTaskListController>();

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppBar(
        onRefresh: () {
          _getCompletedTaskList();
        },
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GetBuilder<CompleteTaskListController>(
                builder: (controller) {
                  return Visibility(
                      visible: controller.inProgress == false,
                      replacement: const CenteredCircularProgressBar(),
                      child: _buildTaskListView(controller.taskList));
                }
              ),
            )
          ]),
        ),
      ),
    );
  }

  ListView _buildTaskListView(List<TaskModel> taskList) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return TaskItemWidget(
            taskModel: taskList[index],

        );
      },
    );
  }

  Future<void> _getCompletedTaskList() async {
    bool isSuccess = await _completeTaskListController.getCompletedTaskList();
    if (!isSuccess) {
      showSnackBarMassage(context, _completeTaskListController.errorMassage!);
    }
  }
}
