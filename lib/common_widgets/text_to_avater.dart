import 'package:flutter/material.dart';

class TextToAvatar extends StatelessWidget {
  const TextToAvatar({
    super.key,
    required this.text,
    this.gradient,
    this.size,
    this.color,
    this.fontSize,
    this.limit = 2,
  });
  final String text;
  final Gradient? gradient;
  final double? size;
  final Color? color;
  final double? fontSize;
  final int limit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 60,
      width: size ?? 60,
      decoration: BoxDecoration(
        gradient: gradient,
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text.length > 2
              ? text.substring(0, limit).toUpperCase()
              : text.toUpperCase(),
          style: TextStyle(
            fontSize: fontSize ?? 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
