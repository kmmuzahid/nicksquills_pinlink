import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.child, this.padding});
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.bACKGROUND_darkCardBoarder),
      ),
      padding: padding ?? const EdgeInsets.all(10),
      child: child,
    );
  }
}
