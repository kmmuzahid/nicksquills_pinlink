import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.height,
    this.width,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
  });
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,

      width: width,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colors.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
        border: Border.all(color: borderColor ?? context.colors.bACKGROUND_darkCardBoarder),
      ),
      padding: padding ?? const EdgeInsets.all(10),
      child: child,
    );
  }
}
