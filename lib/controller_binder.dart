import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:task_manager/ui/controller/add_new_task_controller.dart';
import 'package:task_manager/ui/controller/cancelled_task_list_controller.dart';
import 'package:task_manager/ui/controller/complete_task_list_controller.dart';
import 'package:task_manager/ui/controller/forget_password_verify_email_controller.dart';
import 'package:task_manager/ui/controller/forget_password_verify_otp_controller.dart';
import 'package:task_manager/ui/controller/new_task_list_controller.dart';
import 'package:task_manager/ui/controller/progress_task_controller.dart';
import 'package:task_manager/ui/controller/reset_password_controller.dart';
import 'package:task_manager/ui/controller/sign_in_controller.dart';
import 'package:task_manager/ui/controller/sign_up_controller.dart';
import 'package:task_manager/ui/controller/update_profile_controller.dart';

import 'ui/controller/task_count_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => UpdateProfileController());
    Get.lazyPut(() => ResetPasswordController());
    Get.put(NewTaskListController());
    Get.put(TaskCountController());
    Get.lazyPut(() => ProgressTaskController());
    Get.lazyPut(() => ForgetPasswordVerifyOtpController());
    Get.lazyPut(() => ForgetPasswordVerifyEmailController());
    Get.lazyPut(() => CompleteTaskListController());
    Get.lazyPut(() => CancelledTaskListController());
    Get.lazyPut(() => AddNewTaskController());
  }

}