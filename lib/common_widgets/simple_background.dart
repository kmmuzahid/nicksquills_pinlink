/*
 * @Author: Km Muzahid
 * @Date: 2026-02-23 09:07:28
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';

 
class SimpleBackground extends StatelessWidget {
  const SimpleBackground({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.buildContext,
  });
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final BuildContext? buildContext;

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SizedBox(
        width: CoreScreenUtils.deviceSize.width,
        height: CoreScreenUtils.deviceSize.height,
        child: Column(
          children: [
            appBar ?? const SizedBox.shrink(),
            Expanded(child: body),
            bottomNavigationBar ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
