/*
 * @Author: Km Muzahid
 * @Date: 2026-02-23 09:07:28
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/gen/assets.gen.dart';

class SimpleBackground extends StatelessWidget {
  const SimpleBackground({super.key, required this.body, this.appBar, this.bottomNavigationBar});
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: CoreScreenUtils.deviceSize.width,
        height: CoreScreenUtils.deviceSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.simpleBackground.path),
            fit: BoxFit.cover,
          ),
        ),
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
