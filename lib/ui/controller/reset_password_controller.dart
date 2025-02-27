import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class ResetPasswordController extends GetxController{

  bool _inProgress = false;
  String? _errorMassage;
  String? _statusFailErrorMassage;
  bool _isStatusSuccess = false;
  bool _isStatusFail = false;


  bool get inProgress => _inProgress;
  bool get isStatusSuccess => _isStatusSuccess;
  bool get isStatusFail => _isStatusFail;
  String? get errorMassage => _errorMassage;
  String? get statusFailErrorMassage => _statusFailErrorMassage;

  Future<bool> resetPassword(String email, String otp, String confirmPassword,) async{
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email":email,
      "OTP": otp,
      "password": confirmPassword,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(url: Urls.recoverResetPassUrl,body: requestBody);
    if(response.responseData!["status"] == "success"){
      _isStatusSuccess = true;
      isSuccess = true;
      _isStatusFail = false;
      _errorMassage = null;
      _statusFailErrorMassage = null;

    } else if(response.responseData!["status"] == "fail"){
      _isStatusFail = true;
      _isStatusSuccess = false;
      _statusFailErrorMassage = "Invalid Request!!!!";
    } else{
      _errorMassage = response.errorMassage;
    }

    _inProgress = false;
    update();
    return isSuccess;

  }

}