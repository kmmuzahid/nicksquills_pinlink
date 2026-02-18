/*
 * @Author: Km Muzahid
 * @Date: 2026-02-02 18:51:31
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/app_bar/common_app_bar.dart';
import 'package:core_kit/image/common_image.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/gen/assets.gen.dart';

CommonAppBar AppBarGradientExpanded({
  bool hideBack = false,
  AlignmentGeometry? titleAlignment,
  Widget? titleWidget,
  List<Widget>? actions,
}) {
  return CommonAppBar(
    disableBack: hideBack,
    hideBack: hideBack,
    // linearGradientBackground: LinearGradient(
    //   begin: Alignment.topLeft,
    //   end: Alignment.bottomRight,
    //   colors: [AppColor.secondary, AppColor.primary],
    // ),
    leadingAlignment: Alignment.topLeft,
    titleAlignment: Alignment.bottomCenter,
    titleWidget:
        titleWidget ?? CommonImage(src: Assets.images.appIcon.path, width: 215, height: 86),
    actions: actions,
  );
}
