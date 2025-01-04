import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class TmAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TmAppBar({
    super.key,
  });

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Atik Shahriar",
                    style: textTheme.titleSmall?.copyWith(color: Colors.white),
                  ),
                  Text(
                    "atikbd240@gmail.com",
                    style: textTheme.bodySmall?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            IconButton(
              style: IconButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: () {},
              icon: const Icon(Icons.logout_outlined),
            ),
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
