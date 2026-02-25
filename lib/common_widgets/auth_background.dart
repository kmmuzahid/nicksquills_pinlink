/*
 * @Author: Km Muzahid
 * @Date: 2026-02-23 09:07:28
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.body, this.appBar, this.bottomNavigationBar});
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: SizedBox(
        width: CoreScreenUtils.deviceSize.width,
        height: CoreScreenUtils.deviceSize.height,
      
        child: background(
          context: context,
          width: CoreScreenUtils.deviceSize.width,
          height: CoreScreenUtils.deviceSize.height,
          circleColor1: AppColor.pRIMARY_priLight,
          circleColor2: AppColor.pRIMARY_priMedium,
          // child: const SizedBox.shrink(),
          child: Column(
            children: [
              appBar ?? const SizedBox.shrink(),
              Expanded(child: body),
              bottomNavigationBar ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget background({
    required BuildContext context,
    required double width,
    required double height,
    required Widget child,
    required Color circleColor1,
    required Color circleColor2,
  }) {
    final background1 = AppColor.background;
    return Container(
      color: background1, // top and bottom dark base
      width: width,
      height: height,
      child: Stack(
        children: [
          _circle(
            width: width,
            height: height,
            leftFactor: 0.55,
            topFactor: 0.80,
            sizeFactor: 0.70,
            color1: circleColor1,
            color2: circleColor2,
          ),
          _circle(
            width: width,
            height: height,
            leftFactor: 0.22,
            topFactor: 0.93,
            sizeFactor: 0.60,
            color1: circleColor1,
            color2: circleColor2,
          ),
          _circle(
            width: width,
            height: height,
            leftFactor: 0.72,
            topFactor: 0.87,
            sizeFactor: 0.58,
            color1: circleColor1,
            color2: circleColor2,
          ),
          Positioned(child: child),
        ],
      ),
    );
  }

  Widget _circle({
    required double width,
    required double height,
    required double leftFactor,
    required double topFactor,
    required double sizeFactor,
    required Color color1,
    required Color color2,
  }) {
    final size = width * sizeFactor;

    return Positioned(
      left: width * leftFactor,
      top: height * topFactor,
      child: Container(
        width: size,
        height: size,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color1, color2],
          ),
          shape: const OvalBorder(),
        ),
      ),
    );
  }
}

