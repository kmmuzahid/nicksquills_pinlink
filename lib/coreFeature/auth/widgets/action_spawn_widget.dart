/*
 * @Author: Km Muzahid
 * @Date: 2026-02-01 09:37:24
 * @Email: km.muzahid@gmail.com
 */
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';

class ActionSpawnWidget extends StatelessWidget {
  const ActionSpawnWidget({
    super.key,
    required this.title,
    required this.actionTitle,
    required this.onTap,
  });
  final String title;
  final String actionTitle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: AppColor.textGray, fontSize: 14),
        children: [
          TextSpan(
            text: title,
            style: TextStyle(color: AppColor.textGray, fontSize: 14),
          ),
          TextSpan(
            text: ' $actionTitle',
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
              decorationThickness: 2,
              decorationColor: Colors.blue,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
