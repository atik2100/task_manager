import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/utils/global_string.dart';
import 'package:task_manager/ui/widgets/background.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_massege.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static const String name = '/forget_password/verify_OTP/reset_password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEController = TextEditingController();
  final TextEditingController _confirmNewPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _resetPasswordInProgress = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    "Set Password",
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Minimum length password 8 character with letter and number combination",
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(height: 24),

                  TextFormField(
                    controller: _newPasswordTEController,
                    decoration: const InputDecoration(
                      hintText: "New Password"
                    ),
                    validator: (String? value){
                      if (value?.trim().isEmpty ?? true){
                        return "Enter New Password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _confirmNewPasswordTEController,
                    decoration: const InputDecoration(
                      hintText: "Confirm New Password"
                    ),
                    validator: (String? value){
                      if (value?.trim().isEmpty ?? true){
                        return "Enter Confirm Password";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),
                  Visibility(
                    visible: _resetPasswordInProgress == false,
                    replacement: const CenteredCircularProgressBar(),
                    child: ElevatedButton(
                      onPressed: () {
                        if(_newPasswordTEController.text.trim() == _confirmNewPasswordTEController.text.trim()){
                          _resetPassword();
                        } else {
                          showSnackBarMassage(context, "New Password and Confirm Password Not Match");
                        }

                      },
                      child: const Text("Confirm"),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Center(
                    child: _buildSignInSection(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildSignInSection() {
    return RichText(
      text: TextSpan(
          text: "Have account? ",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          children: [
            TextSpan(
              text: "Sign in",
              style: const TextStyle(
                color: AppColors.themeColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, SignInScreen.name, (value) => false);
                },
            ),
          ]),
    );
  }

  Future<void> _resetPassword() async{
    if(_formKey.currentState!.validate()){
      _resetPasswordInProgress = true;
      setState(() { });
      Map<String, dynamic> requestBody = {
        "email":GlobalString.email,
        "OTP":GlobalString.otp,
        "password":_confirmNewPasswordTEController.text.trim(),
      };

      final NetworkResponse response = await NetworkCaller.postRequest(url: Urls.recoverResetPassUrl,body: requestBody);
      if(response.responseData!["status"] == "success"){
        Navigator.pushReplacementNamed(context, SignInScreen.name);
        
      } else if(response.responseData!["status"] == "fail"){
        showSnackBarMassage(context, "Invalid Request!!!!");
      } else{
        showSnackBarMassage(context, response.errorMassage);
      }

      _resetPasswordInProgress = false;
      setState(() { });

    }
  }

  @override
  void dispose() {
    _newPasswordTEController.dispose();
    _confirmNewPasswordTEController.dispose();
    super.dispose();
  }
}
