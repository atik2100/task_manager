import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_by_status_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class NewTaskListController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;
  TaskListByStatusModel? _taskListByStatusModel;

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;

  List<TaskModel> get taskList => _taskListByStatusModel?.taskList ?? [];

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskListByStatusUrl("New"));

    if (response.isSuccess) {
      _taskListByStatusModel =
          TaskListByStatusModel.fromJson(response.responseData!);
      isSuccess = true;
      _errorMassage = null;
    } else {
      _errorMassage = response.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
