import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/forget_password_verify_email_screen.dart';
import 'package:task_manager/ui/screens/reset_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/utils/global_string.dart';
import 'package:task_manager/ui/widgets/background.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_massege.dart';

class ForgetPasswordVerifyOTPScreen extends StatefulWidget {
  const ForgetPasswordVerifyOTPScreen({super.key});

  static const String name = '/forget_password/verify_OTP';

  @override
  State<ForgetPasswordVerifyOTPScreen> createState() =>
      _ForgetPasswordVerifyOTPScreenState();
}

class _ForgetPasswordVerifyOTPScreenState
    extends State<ForgetPasswordVerifyOTPScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _forgetPasswordVerifyOtpInProgress = false;

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
                    "PIN Verification",
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "A 6 digit verification Pin will send to your email address",
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(height: 24),
                  buildPinCodeTextField(),
                  const SizedBox(height: 24),
                  Visibility(
                    visible: _forgetPasswordVerifyOtpInProgress == false,
                    replacement: const CenteredCircularProgressBar(),
                    child: ElevatedButton(
                      onPressed: () {
                        _otpVerify();
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined),
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

  Widget buildPinCodeTextField() {
    return PinCodeTextField(
      length: 6,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveColor: Colors.grey,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: _otpTEController,
      appContext: context,
        validator: (String? value) {
          if (value == null || value.trim().isEmpty) {
            return "Enter OTP!";
          } else if (value.length != 6) {
            return "OTP must be 6 digits!";
          }
          return null;
        }
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
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  /*Navigator.pushNamedAndRemoveUntil(
                      context, SignInScreen.name, (value) => false);*/
                  Get.offAllNamed(SignInScreen.name);
                },
            ),
          ]),
    );
  }

  Future<void> _otpVerify() async {
    if(_formKey.currentState!.validate()){
      _forgetPasswordVerifyOtpInProgress = true;
      setState(() { });

      GlobalString.otp = _otpTEController.text.trim();

      final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.recoverVerifyOTPUrl(
          GlobalString.email,
          GlobalString.otp,
        ),
      );

      if(response.responseData!["status"] == "success"){
        // Navigator.pushNamed(context, ResetPasswordScreen.name);
        Get.toNamed(ResetPasswordScreen.name);
      }

      else if (response.responseData!["status"] == "fail"){
        showSnackBarMassage(context, "Invalid OTP Code");

      } else {
        showSnackBarMassage(context, response.errorMassage);
      }

      _forgetPasswordVerifyOtpInProgress = false;
      setState(() { });

    }

  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
