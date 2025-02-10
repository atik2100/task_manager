import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_by_status_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
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
  TaskListByStatusModel? progressTaskListModel;
  bool _getProgressTaskListInProgress = false;

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
              child: Visibility(
                  visible: _getProgressTaskListInProgress == false,
                  replacement: const CenteredCircularProgressBar(),
                  child: _buildTaskListView()),
            )
          ]),
        ),
      ),
    );
  }

  ListView _buildTaskListView() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: progressTaskListModel?.taskList?.length ?? 0,
      itemBuilder: (context, index) {
        return TaskItemWidget(
          taskModel: progressTaskListModel!.taskList![index],

        );
      },
    );
  }

  Future<void> _getProgressTaskList() async {
    _getProgressTaskListInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskListByStatusUrl("Progress"));

    if (response.isSuccess) {
      progressTaskListModel =
          TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMassage(context, response.errorMassage);
    }

    _getProgressTaskListInProgress = false;
    setState(() {});
  }
}
