import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/utils/global_string.dart';

class ForgetPasswordVerifyOtpController extends GetxController {

  bool _inProgress = false;
  String? _errorMassage;
  String? _failMassage;

  bool get inProgress => _inProgress;
  String? get errorMassage => _errorMassage;
  String? get failMassage => _failMassage;

  Future<bool> otpVerify(String otp) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    GlobalString.otp = otp;

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoverVerifyOTPUrl(
        GlobalString.email,
        GlobalString.otp,
      ),
    );

    if(response.responseData!["status"] == "success"){
      isSuccess = true;
      _failMassage = null;
      _errorMassage = null;
    }

    else if (response.responseData!["status"] == "fail"){
      _failMassage = "Invalid OTP Code";
      _errorMassage = null;

    } else {
      _errorMassage = response.errorMassage;
      _failMassage = null;
    }

    _inProgress = false;
    update();
    return isSuccess;



  }

}