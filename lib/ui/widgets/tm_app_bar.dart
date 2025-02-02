import 'package:flutter/material.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

import '../utils/app_colors.dart';

class TmAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TmAppBar({
    super.key,
    this.fromUpdateProfileScreen = false,
  });
  final bool fromUpdateProfileScreen;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
        backgroundColor: AppColors.themeColor,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (fromUpdateProfileScreen == false) {
                    Navigator.pushNamed(context, UpdateProfileScreen.name);
                  } return;

                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AuthController.userModel?.fullName ?? '',
                      style: textTheme.titleSmall?.copyWith(color: Colors.white),
                    ),
                    Text(
                      AuthController.userModel?.email ?? '',
                      style: textTheme.bodySmall?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              style: IconButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: () async{
                await AuthController.clearUserData();
                Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate) => false );
              },
              icon: const Icon(Icons.logout_outlined),
            ),
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
