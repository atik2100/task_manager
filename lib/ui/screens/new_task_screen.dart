import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_count_by_status_model.dart';
import 'package:task_manager/data/models/task_count_model.dart';
import 'package:task_manager/data/models/task_list_by_status_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
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
  bool _getTaskCountByStatusInProgress = false;
  bool _getNewTaskListInProgress = false;

  TaskCountByStatusModel? taskCountByStatusModel;
  TaskListByStatusModel? newTaskListModel;

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
              child: Visibility(
                  visible: _getNewTaskListInProgress == false,
                  replacement: const CenteredCircularProgressBar(),
                  child: _buildTaskListView()),
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewTaskScreen.name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView _buildTaskListView() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: newTaskListModel?.taskList?.length ?? 0,
      itemBuilder: (context, index) {
        return TaskItemWidget(
          taskModel: newTaskListModel!.taskList![index],

        );
      },
    );
  }

  Widget _buildTaskSummaryByStatus() {
    return Visibility(
      visible: _getTaskCountByStatusInProgress == false,
      replacement: const CenteredCircularProgressBar(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: taskCountByStatusModel?.taskByStatusList?.length ?? 0,
              itemBuilder: (context, index) {
                final TaskCountModel model =
                    taskCountByStatusModel!.taskByStatusList![index];

                return TaskStatusSummaryCounterWidget(
                  title: model.sId ?? "",
                  count: model.sum.toString(),
                );
              }),
        ),
      ),
    );
  }

  Future<void> _getTaskCountByStatus() async {
    _getTaskCountByStatusInProgress = true;
    setState(() {});

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskStatusCountUrl);

    if (response.isSuccess) {
      taskCountByStatusModel =
          TaskCountByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMassage(context, response.errorMassage);
    }
    _getTaskCountByStatusInProgress = false;
    setState(() {});
  }

  Future<void> _getNewTaskList() async {

    _getNewTaskListInProgress = true;
    setState(() {});

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskListByStatusUrl("New"));

    if (response.isSuccess) {
      newTaskListModel = TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMassage(context, response.errorMassage);
    }
    _getNewTaskListInProgress = false;
    setState(() {});

  }
}
