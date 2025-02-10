import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_by_status_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
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
  TaskListByStatusModel? cancelledTaskList;
  bool _getCancelledTaskListInProgress = false;

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
              child: Visibility(
                  visible: _getCancelledTaskListInProgress == false,
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
      itemCount: cancelledTaskList?.taskList?.length ?? 0,
      itemBuilder: (context, index) {
        return TaskItemWidget(taskModel: cancelledTaskList!.taskList![index],

        );
      },
    );
  }

  Future<void> _getCancelledTaskList() async {
    _getCancelledTaskListInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskListByStatusUrl("Cancelled"));

    if (response.isSuccess) {
      cancelledTaskList =
          TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMassage(context, response.errorMassage);
    }

    _getCancelledTaskListInProgress = false;
    setState(() {});
  }
}
