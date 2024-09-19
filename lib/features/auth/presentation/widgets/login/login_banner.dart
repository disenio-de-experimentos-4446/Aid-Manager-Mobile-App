import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LoginBanner extends StatelessWidget {
  final double containerHeight;
  final double deviceWidth;
  final Image logoImage;

  const LoginBanner(
      {super.key,
      required this.containerHeight,
      required this.deviceWidth,
      required this.logoImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: containerHeight,
          decoration: const BoxDecoration(
            color: CustomColors.darkGreen,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(999),
              bottomRight: Radius.circular(999),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: (deviceWidth / 2) - 70,
          child: Transform.translate(
            offset: const Offset(0, 70),
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: CustomColors.white,
                shape: BoxShape.circle,
                border: Border.all(width: 0.5, color: CustomColors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: logoImage,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
