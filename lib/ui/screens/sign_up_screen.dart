import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/sign_up_controller.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/background.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_massege.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign_up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignUpController _signUpController = Get.find<SignUpController>();

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
                    "Join With Us",
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: "Email"),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your Email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _firstNameTEController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(hintText: "First Name"),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your First Name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _lastNameTEController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(hintText: "Last Name"),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your Last Name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _mobileTEController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(hintText: "Mobile"),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your Mobile Number";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: "Password"),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your Password";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  GetBuilder<SignUpController>(builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress == false,
                      replacement: const CenteredCircularProgressBar(),
                      child: ElevatedButton(
                        onPressed: _onTapSignUpButton,
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    );
                  }),
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

  void _onTapSignUpButton() {
    if (_formKey.currentState!.validate()) {
      _registerUser();
    }
  }

  Future<void> _registerUser() async {
    bool isSuccess = await _signUpController.registerUser(
      _emailTEController.text.trim(),
      _firstNameTEController.text.trim(),
      _lastNameTEController.text.trim(),
      _mobileTEController.text.trim(),
      _passwordTEController.text.trim(),
      "",
    );

    if (isSuccess) {
      _clearTextFields();
      showSnackBarMassage(context, _signUpController.successMassage!);
      Get.back();
    } else {
      showSnackBarMassage(context, _signUpController.errorMassage!);
    }
  }

  void _clearTextFields() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
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
                  // Navigator.pop(context);
                  Get.back();
                },
            ),
          ]),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _mobileTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    super.dispose();
  }
}
