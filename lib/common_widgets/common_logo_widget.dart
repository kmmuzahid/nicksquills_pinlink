/*
 * @Author: Km Muzahid
 * @Date: 2026-01-11 11:55:02
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/gen/assets.gen.dart';

class CommonLogo extends StatelessWidget {
  const CommonLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonImage(src: Assets.images.appIcon.path, size: 80);
  }
}
