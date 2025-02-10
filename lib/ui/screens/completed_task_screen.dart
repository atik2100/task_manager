import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_by_status_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
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
  TaskListByStatusModel? completedTaskListModel;
  bool _getCompletedTaskListInProgress = false;

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
              child: Visibility(
                  visible: _getCompletedTaskListInProgress == false,
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
      itemCount: completedTaskListModel?.taskList?.length ?? 0,
      itemBuilder: (context, index) {
        return TaskItemWidget(
            taskModel: completedTaskListModel!.taskList![index],

        );
      },
    );
  }

  Future<void> _getCompletedTaskList() async {
    _getCompletedTaskListInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskListByStatusUrl("Completed"));
    if (response.isSuccess) {
      completedTaskListModel =
          TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMassage(context, response.errorMassage);
    }

    _getCompletedTaskListInProgress = false;
    setState(() {});
  }
}
