/*
 * @Author: Km Muzahid
 * @Date: 2026-02-07 11:20:49
 * @Email: km.muzahid@gmail.com
 */

import 'package:core_kit/app_bar/common_app_bar.dart';
import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';

CommonAppBar AppBarSimple({
  required String title,
  AlignmentGeometry? titleAlignment,
  Function()? onBackPress,
  bool hideBack = false,
  bool disableBack = false,
  Widget? titleWidget,
  List<Widget> actions = const [],
}) {
  final fAction = [...actions, if (actions.isNotEmpty) 10.width];
  return CommonAppBar(
    disableBack: hideBack,
    title: title,
    hideBack: hideBack,
    titleWidget: titleWidget,
    actions: fAction,
    // linearGradientBackground: LinearGradient(
    //   begin: Alignment.topLeft,
    //   end: Alignment.bottomRight,
    //   colors: [AppColor.secondary, AppColor.primary],
    // ),
    // leadingAlignment: Alignment.topLeft,
    // titleAlignment: Alignment.bottomCenter,
    // titleWidget: CommonImage(src: Assets.images.appIcon.path, width: 215, height: 86),
  );
}
