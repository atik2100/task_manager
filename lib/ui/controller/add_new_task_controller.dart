import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class AddNewTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;
  String? _successMassage;

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;

  String? get successMassage => _successMassage;

  Future<bool> createNewTask(
      String title, String description, String status) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": status,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createNewTaskUrl, body: requestBody);

    _inProgress = false;
    update();

    if (response.isSuccess) {
      _successMassage = "New Task Added Successful";
      isSuccess = true;
      _errorMassage = null;
    } else {
      _errorMassage = response.errorMassage;
      _successMassage = null;
    }

    return isSuccess;

  }
}
