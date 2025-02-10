import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final bool isSuccess;
  final String errorMassage;

  NetworkResponse(
      {required this.isSuccess,
      required this.statusCode,
      this.responseData,
      this.errorMassage = "Something went wrong!"});
}

class NetworkCaller {
  static bool _isLogOut = false;
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint("URL => $url");
      Response response = await get(uri, headers: {
        "token" : AuthController.accessToken ?? ""
      });
      debugPrint("response code => ${response.statusCode}");
      debugPrint("response data => ${response.body}");

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedResponse);
      } else if (response.statusCode == 401){
        if (!_isLogOut) {
          _logout();
        }
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);

      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMassage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint("URL => $url");
      Response response = await post(uri,
          headers: {
            "content-type": "application/json",
            "token": AuthController.accessToken ?? ""
          },
          body: jsonEncode(body));
      debugPrint("response code => ${response.statusCode}");
      debugPrint("response data => ${response.body}");

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedResponse);
      } else if (response.statusCode == 401){
        if (!_isLogOut) {
          _logout();
        }
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);

      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMassage: e.toString(),
      );
    }
  }

  static Future<void> _logout() async{
    if(_isLogOut) return;

    _isLogOut = true;
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(TaskManager.navigatorKey.currentContext!, SignInScreen.name, (predicate)=>false);
  }
}
