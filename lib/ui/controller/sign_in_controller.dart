import 'package:get/get.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;

  bool get inProgress => _inProgress;
  String? get errorMassage => _errorMassage;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String,dynamic> requestBody = {
      "email": email,
      "password": password,
    };
    final NetworkResponse response =
    await NetworkCaller.postRequest(url: Urls.logIn, body: requestBody);
    if (response.isSuccess){
      String token = response.responseData!['token'];
      UserModel userModel = UserModel.fromJson(response.responseData!['data']);
      await AuthController.saveUserData(token, userModel);
      isSuccess = true;
      _errorMassage = null;
    } else {
      if(response.statusCode == 401){
        _errorMassage = "Email or Password not Match";

      } else {
        _errorMassage = response.errorMassage;

      }
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}