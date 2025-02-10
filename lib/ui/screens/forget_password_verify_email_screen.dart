import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/forget_password_verify_otp_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/utils/global_string.dart';
import 'package:task_manager/ui/widgets/background.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_massege.dart';

class ForgetPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgetPasswordVerifyEmailScreen({super.key});

  static const String name = '/forget_password/verify_email';


  @override
  State<ForgetPasswordVerifyEmailScreen> createState() => _ForgetPasswordVerifyEmailScreenState();
}

class _ForgetPasswordVerifyEmailScreenState extends State<ForgetPasswordVerifyEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _forgetPasswordVerifyEmailInProgress = false;

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
                    "Your Email Address",
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "A 6 digit verification will send to your email address",
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: "Email"),
                    validator: (String? value){
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your Email Address";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),
                  Visibility(
                    visible: _forgetPasswordVerifyEmailInProgress == false,
                    replacement: const CenteredCircularProgressBar(),
                    child: ElevatedButton(
                      onPressed: () {



                        _verifyEmail();

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
                Navigator.pop(context);
              },
            ),
          ]),
    );
  }

  Future<void> _verifyEmail() async {
    if(_formKey.currentState!.validate()){
      _forgetPasswordVerifyEmailInProgress = true;
      setState(() { });

      GlobalString.email = _emailTEController.text;

      final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.recoverVerifyEmailUrl(GlobalString.email));
      if(response.responseData!["status"] == "success"){
        showSnackBarMassage(context, "Please Check Your Email!");
        Navigator.pushNamed(
            context, ForgetPasswordVerifyOTPScreen.name);
      } else if (response.responseData!["status"] == "fail"){
        showSnackBarMassage(context, "No User Found");

      } else{
        showSnackBarMassage(context, response.errorMassage);
      }

      _forgetPasswordVerifyEmailInProgress = false;
      setState(() { });

    }

  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
