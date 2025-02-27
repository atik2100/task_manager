import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class UpdateProfileController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;
  String? _successMassage;

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;

  String? get successMassage => _successMassage;

  Future<bool> updateProfile(
    String email,
    String firstName,
    String lastName,
    String mobile,
    String? password,
    XFile? pickedImage,
  ) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (pickedImage != null) {
      List<int> imageBytes = await pickedImage.readAsBytes();
      requestBody["photo"] = base64Encode(imageBytes);
    }

    if (password != null && password.isNotEmpty) {
      requestBody["password"] = password;
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.updateProfileUrl, body: requestBody);

    if (response.isSuccess) {
      _successMassage = "Your Profile Is Updated Successfully";
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
