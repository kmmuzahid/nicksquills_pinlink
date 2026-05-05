/*
 * @Author: Km Muzahid
 * @Date: 2026-02-18 09:39:56
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';

class BuildLabel extends StatelessWidget {
  const BuildLabel(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: CommonText(
        left: 10,
        text: label,
        textColor: context.colors.tEXT_subDark,
        fontSize: 14,
      ),
    );
  }
}
