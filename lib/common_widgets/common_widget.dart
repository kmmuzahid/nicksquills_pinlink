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
        text: label, textColor: AppColor.textGray, fontSize: 14),
    );
  }
}
