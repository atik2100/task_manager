import 'package:get/get.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;
  String? _successMassage;

  bool get inProgress => _inProgress;
  String? get errorMassage => _errorMassage;
  String? get successMassage => _successMassage;

  Future<bool> registerUser(
    String email,
    String firstName,
    String lastName,
    String mobile,
    String password,
    String photo,
  ) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String,dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": photo,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registration, body: requestBody);

    if(response.isSuccess){
      _successMassage = "New User Registration Successful";
      isSuccess = true;
      _errorMassage = null;
    } else {
      _errorMassage = response.errorMassage;
      _successMassage = null;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

}