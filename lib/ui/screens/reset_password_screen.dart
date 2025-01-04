import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static const String name = '/forget_password/verify_OTP/reset_password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    controller: _newPassword,
                    decoration: const InputDecoration(
                      hintText: "New Password"
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _confirmNewPassword,
                    decoration: const InputDecoration(
                      hintText: "Confirm New Password"
                    ),
                  ),

                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Confirm"),
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

  @override
  void dispose() {
    _newPassword.dispose();
    _confirmNewPassword.dispose();
    super.dispose();
  }
}
