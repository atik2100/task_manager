import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller_binder.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/forget_password_verify_email_screen.dart';
import 'package:task_manager/ui/screens/forget_password_verify_otp_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screens/reset_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Task Manager",
      initialRoute: '/',
      initialBinding: ControllerBinder(),
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        textTheme:  const TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            fixedSize: const Size.fromWidth(double.maxFinite),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == SplashScreen.name) {
          widget = const SplashScreen();
        } else if (settings.name == SignInScreen.name) {
          widget = const SignInScreen();
        } else if (settings.name == SignUpScreen.name){
          widget = const SignUpScreen();
        } else if (settings.name == ForgetPasswordVerifyEmailScreen.name){
          widget = const ForgetPasswordVerifyEmailScreen();
        } else if (settings.name == ForgetPasswordVerifyOTPScreen.name) {
          widget = const ForgetPasswordVerifyOTPScreen();
        } else if (settings.name == ResetPasswordScreen.name) {
          widget = const ResetPasswordScreen();
        } else if (settings.name == MainBottomNavScreen.name){
          widget = const MainBottomNavScreen();
        } else if (settings.name == AddNewTaskScreen.name) {
          widget = const AddNewTaskScreen();
        } else if (settings.name == UpdateProfileScreen.name) {
          widget = const UpdateProfileScreen();
        }
        return MaterialPageRoute(builder: (context) => widget);
      },
    );
  }
}
