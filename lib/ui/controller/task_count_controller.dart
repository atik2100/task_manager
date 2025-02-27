import 'package:get/get.dart';
import 'package:task_manager/data/models/task_count_by_status_model.dart';
import 'package:task_manager/data/models/task_count_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class TaskCountController extends GetxController{

  bool _inProgress = false;
  String? _errorMassage;
  TaskCountByStatusModel? _taskCountByStatusModel;

  bool get inProgress => _inProgress;
  String? get errorMassage => _errorMassage;
  List<TaskCountModel> get taskByStatusList => _taskCountByStatusModel?.taskByStatusList?? [];


  Future<bool> getTaskCountByStatus() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskStatusCountUrl);

    if (response.isSuccess) {
      _taskCountByStatusModel =
          TaskCountByStatusModel.fromJson(response.responseData!);
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