import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/utils/global_string.dart';

class ForgetPasswordVerifyEmailController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;
  String? _successMassage;
  String? _failMassage;

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;

  String? get successMassage => _successMassage;

  String? get failMassage => _failMassage;

  Future<bool> verifyEmail(String email) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    GlobalString.email = email;

    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.recoverVerifyEmailUrl(GlobalString.email));
    if (response.responseData!["status"] == "success") {
      isSuccess = true;
      _successMassage = "Please Check Your Email!";
      _failMassage = null;
      _errorMassage = null;
    } else if (response.responseData!["status"] == "fail") {
      _failMassage = "No User Found";
      _successMassage = null;
      _errorMassage = null;
    } else {
      _errorMassage = response.errorMassage;
      _successMassage = null;
      _errorMassage = null;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
