import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: context.colors.bACKGROUND_darkCardBoarder, thickness: 1);
  }
}
