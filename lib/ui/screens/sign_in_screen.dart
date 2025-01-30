import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/forget_password_verify_email_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/background.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_massege.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign_in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signInProgress = false;

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
                    "Get Started With",
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: "Email"),
                    validator: (String? value){
                      if(value?.trim().isEmpty?? true){
                        return "Enter Your Email";
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: "Password"),
                    validator: (String? value){
                      if(value?.trim().isEmpty?? true){
                        return "Enter Your Password";
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  Visibility(
                    visible: _signInProgress == false,
                    replacement: const CenteredCircularProgressBar(),
                    child: ElevatedButton(
                      onPressed: () {
                        _onTapSignInButton();
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, ForgetPasswordVerifyEmailScreen.name);
                          },
                          child: const Text("Forget Password",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        _buildSignUpSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn() async {
    _signInProgress = true;
    setState(() {});
    Map<String,dynamic> requestBody = {
      "email":_emailTEController.text.trim(),
      "password":_passwordTEController.text
    };
    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.logIn, body: requestBody);
    if (response.isSuccess){
      Navigator.pushReplacementNamed(context, MainBottomNavScreen.name);
    } else {
      _signInProgress = false;
      setState(() {

      });
      if(response.statusCode == 401){
        showSnackBarMassage(context, "Email or Password not Match");
      } else {
        showSnackBarMassage(context, response.errorMassage);
      }
    }
  }

  Widget _buildSignUpSection() {
    return RichText(
      text: TextSpan(
          text: "Don't have an account? ",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          children: [
            TextSpan(
              text: "Sign up",
              style: const TextStyle(
                color: AppColors.themeColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {
                Navigator.pushNamed(context, SignUpScreen.name);
              },
            ),
          ]),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
