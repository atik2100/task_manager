import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/assets_path.dart';

class Background extends StatelessWidget {
  const Background({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetsPath.backgroundSvg,
          fit: BoxFit.cover,
          height: double.maxFinite,
          width: double.maxFinite,
        ),
        SafeArea(child: child),
      ],
    );
  }
}
