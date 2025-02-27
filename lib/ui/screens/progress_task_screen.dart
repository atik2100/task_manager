import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/ui/controller/progress_task_controller.dart';
import 'package:task_manager/ui/widgets/background.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_massege.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/tm_app_bar.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final ProgressTaskController _progressTaskController =
      Get.find<ProgressTaskController>();

  @override
  void initState() {
    super.initState();
    _getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppBar(
        onRefresh: () {
          _getProgressTaskList();
        },
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GetBuilder<ProgressTaskController>(
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

  Future<void> _getProgressTaskList() async {

    bool isSuccess = await _progressTaskController.getProgressTaskList();

    if (!isSuccess) {
      showSnackBarMassage(context, _progressTaskController.errorMassage!);
    }
  }
}
