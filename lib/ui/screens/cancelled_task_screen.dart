import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/ui/controller/cancelled_task_list_controller.dart';
import 'package:task_manager/ui/widgets/background.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_massege.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/tm_app_bar.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final CancelledTaskListController _cancelledTaskListController =
      Get.find<CancelledTaskListController>();

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppBar(
        onRefresh: () {
          _getCancelledTaskList();
        },
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GetBuilder<CancelledTaskListController>(
                  builder: (controller) {
                return Visibility(
                    visible: controller.inProgress == false,
                    replacement: const CenteredCircularProgressBar(),
                    child: _buildTaskListView(controller.taskList));
              }),
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

  Future<void> _getCancelledTaskList() async {
    bool isSuccess = await _cancelledTaskListController.getCancelledTaskList();

    if (!isSuccess) {
      showSnackBarMassage(context, _cancelledTaskListController.errorMassage!);
    }
  }
}
