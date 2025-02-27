import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_count_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/ui/controller/new_task_list_controller.dart';
import 'package:task_manager/ui/controller/task_count_controller.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/background.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_massege.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/task_summary_counter_widget.dart';
import '../widgets/tm_app_bar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TaskCountController _taskCountController =
      Get.find<TaskCountController>();
  final NewTaskListController _newTaskListController =
      Get.find<NewTaskListController>();

  @override
  void initState() {
    super.initState();
    _getTaskCountByStatus();
    _getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppBar(onRefresh: () {
        _getTaskCountByStatus();
        _getNewTaskList();
      }),
      body: Background(
        child: SingleChildScrollView(
          child: Column(children: [
            _buildTaskSummaryByStatus(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GetBuilder<NewTaskListController>(builder: (controller) {
                return Visibility(
                    visible: controller.inProgress == false,
                    replacement: const CenteredCircularProgressBar(),
                    child: _buildTaskListView(controller.taskList));
              }),
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, AddNewTaskScreen.name);
          Get.toNamed(AddNewTaskScreen.name);
        },
        child: const Icon(Icons.add),
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

  Widget _buildTaskSummaryByStatus() {
    return GetBuilder<TaskCountController>(builder: (controller) {
      return Visibility(
        visible: controller.inProgress == false,
        replacement: const CenteredCircularProgressBar(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.taskByStatusList.length,
                itemBuilder: (context, index) {
                  final TaskCountModel model = controller.taskByStatusList[index];

                  return TaskStatusSummaryCounterWidget(
                    title: model.sId ?? "",
                    count: model.sum.toString(),
                  );
                }),
          ),
        ),
      );
    });
  }

  Future<void> _getTaskCountByStatus() async {
    final bool isSuccess = await _taskCountController.getTaskCountByStatus();

    if (!isSuccess) {
      showSnackBarMassage(context, _taskCountController.errorMassage!);
    }
  }

  Future<void> _getNewTaskList() async {
    final bool isSuccess = await _newTaskListController.getNewTaskList();

    if (!isSuccess) {
      showSnackBarMassage(context, _newTaskListController.errorMassage!);
    }
  }
}
