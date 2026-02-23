// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/icon.png
  AssetGenImage get icon => const AssetGenImage('assets/icon/icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [icon];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_icon.png
  AssetGenImage get appIcon =>
      const AssetGenImage('assets/images/app_icon.png');

  /// File path: assets/images/apple.png
  AssetGenImage get apple => const AssetGenImage('assets/images/apple.png');

  /// File path: assets/images/auth_background.png
  AssetGenImage get authBackground =>
      const AssetGenImage('assets/images/auth_background.png');

  /// File path: assets/images/globe.png
  AssetGenImage get globe => const AssetGenImage('assets/images/globe.png');

  /// File path: assets/images/google.svg
  String get google => 'assets/images/google.svg';

  /// File path: assets/images/oboarding_1.png
  AssetGenImage get oboarding1 =>
      const AssetGenImage('assets/images/oboarding_1.png');

  /// File path: assets/images/oboarding_2.png
  AssetGenImage get oboarding2 =>
      const AssetGenImage('assets/images/oboarding_2.png');

  /// File path: assets/images/onBoardingNextButtonPrefix.svg
  String get onBoardingNextButtonPrefix =>
      'assets/images/onBoardingNextButtonPrefix.svg';

  /// File path: assets/images/onboarding_3.png
  AssetGenImage get onboarding3 =>
      const AssetGenImage('assets/images/onboarding_3.png');

  /// File path: assets/images/onboarding_4.png
  AssetGenImage get onboarding4 =>
      const AssetGenImage('assets/images/onboarding_4.png');

  /// File path: assets/images/simple_background.png
  AssetGenImage get simpleBackground =>
      const AssetGenImage('assets/images/simple_background.png');

  /// File path: assets/images/sp_image_1.png
  AssetGenImage get spImage1 =>
      const AssetGenImage('assets/images/sp_image_1.png');

  /// File path: assets/images/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/images/splash.png');

  /// List of all assets
  List<dynamic> get values => [
    appIcon,
    apple,
    authBackground,
    globe,
    google,
    oboarding1,
    oboarding2,
    onBoardingNextButtonPrefix,
    onboarding3,
    onboarding4,
    simpleBackground,
    spImage1,
    splash,
  ];
}

class $AssetsNavigatorsGen {
  const $AssetsNavigatorsGen();

  /// File path: assets/navigators/add_course.svg
  String get addCourse => 'assets/navigators/add_course.svg';

  /// File path: assets/navigators/leaderboard.svg
  String get leaderboard => 'assets/navigators/leaderboard.svg';

  /// File path: assets/navigators/map.svg
  String get map => 'assets/navigators/map.svg';

  /// File path: assets/navigators/profile.svg
  String get profile => 'assets/navigators/profile.svg';

  /// File path: assets/navigators/social.svg
  String get social => 'assets/navigators/social.svg';

  /// List of all assets
  List<String> get values => [addCourse, leaderboard, map, profile, social];
}

class Assets {
  const Assets._();

  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsNavigatorsGen navigators = $AssetsNavigatorsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
