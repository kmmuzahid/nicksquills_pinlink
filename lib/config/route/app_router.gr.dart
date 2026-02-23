// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;
import 'package:pinlink/coreFeature/about_us/about_us_screen.dart' as _i1;
import 'package:pinlink/coreFeature/auth/screens/change_password_screen.dart'
    as _i2;
import 'package:pinlink/coreFeature/auth/screens/login_screen.dart' as _i4;
import 'package:pinlink/coreFeature/auth/screens/reset_password_screen.dart'
    as _i10;
import 'package:pinlink/coreFeature/auth/screens/send_otp_screen.dart' as _i11;
import 'package:pinlink/coreFeature/faq/screens/faq_screen.dart' as _i3;
import 'package:pinlink/coreFeature/navigation/screens/navigation_screen.dart'
    as _i5;
import 'package:pinlink/coreFeature/notification/notification_screen.dart'
    as _i6;
import 'package:pinlink/coreFeature/onboarding/onboarding_screen.dart' as _i7;
import 'package:pinlink/coreFeature/profile/screens/personal_information_screen.dart'
    as _i8;
import 'package:pinlink/coreFeature/splash/splash_screen.dart' as _i12;
import 'package:pinlink/coreFeature/terms/privacy_policy_screen.dart' as _i9;
import 'package:pinlink/coreFeature/terms/terms_of_use_screen.dart' as _i13;

/// generated route for
/// [_i1.AboutUsScreen]
class AboutUsRoute extends _i14.PageRouteInfo<void> {
  const AboutUsRoute({List<_i14.PageRouteInfo>? children})
    : super(AboutUsRoute.name, initialChildren: children);

  static const String name = 'AboutUsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutUsScreen();
    },
  );
}

/// generated route for
/// [_i2.ChangePasswordScreen]
class ChangePasswordRoute extends _i14.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i14.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i2.ChangePasswordScreen();
    },
  );
}

/// generated route for
/// [_i3.FaqScreen]
class FaqRoute extends _i14.PageRouteInfo<void> {
  const FaqRoute({List<_i14.PageRouteInfo>? children})
    : super(FaqRoute.name, initialChildren: children);

  static const String name = 'FaqRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i3.FaqScreen();
    },
  );
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i14.PageRouteInfo<void> {
  const LoginRoute({List<_i14.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i4.LoginScreen();
    },
  );
}

/// generated route for
/// [_i5.NavigationScreen]
class NavigationRoute extends _i14.PageRouteInfo<void> {
  const NavigationRoute({List<_i14.PageRouteInfo>? children})
    : super(NavigationRoute.name, initialChildren: children);

  static const String name = 'NavigationRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i5.NavigationScreen();
    },
  );
}

/// generated route for
/// [_i6.NotificationScreen]
class NotificationRoute extends _i14.PageRouteInfo<void> {
  const NotificationRoute({List<_i14.PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i6.NotificationScreen();
    },
  );
}

/// generated route for
/// [_i7.OnboardingScreen]
class OnboardingRoute extends _i14.PageRouteInfo<void> {
  const OnboardingRoute({List<_i14.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i7.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i8.PersonalInformationScreen]
class PersonalInformationRoute extends _i14.PageRouteInfo<void> {
  const PersonalInformationRoute({List<_i14.PageRouteInfo>? children})
    : super(PersonalInformationRoute.name, initialChildren: children);

  static const String name = 'PersonalInformationRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i8.PersonalInformationScreen();
    },
  );
}

/// generated route for
/// [_i9.PrivacyPolicyScreen]
class PrivacyPolicyRoute extends _i14.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i14.PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i9.PrivacyPolicyScreen();
    },
  );
}

/// generated route for
/// [_i10.ResetPasswordScreen]
class ResetPasswordRoute extends _i14.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i15.Key? key,
    required String verificationToken,
    required String email,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         ResetPasswordRoute.name,
         args: ResetPasswordRouteArgs(
           key: key,
           verificationToken: verificationToken,
           email: email,
         ),
         initialChildren: children,
       );

  static const String name = 'ResetPasswordRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>();
      return _i10.ResetPasswordScreen(
        key: args.key,
        verificationToken: args.verificationToken,
        email: args.email,
      );
    },
  );
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    this.key,
    required this.verificationToken,
    required this.email,
  });

  final _i15.Key? key;

  final String verificationToken;

  final String email;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, verificationToken: $verificationToken, email: $email}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ResetPasswordRouteArgs) return false;
    return key == other.key &&
        verificationToken == other.verificationToken &&
        email == other.email;
  }

  @override
  int get hashCode =>
      key.hashCode ^ verificationToken.hashCode ^ email.hashCode;
}

/// generated route for
/// [_i11.SendOtpScreen]
class SendOtpRoute extends _i14.PageRouteInfo<SendOtpRouteArgs> {
  SendOtpRoute({
    _i15.Key? key,
    required dynamic Function({required String email, required String token})
    onSuccess,
    required String username,
    bool showSendToField = false,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         SendOtpRoute.name,
         args: SendOtpRouteArgs(
           key: key,
           onSuccess: onSuccess,
           username: username,
           showSendToField: showSendToField,
         ),
         initialChildren: children,
       );

  static const String name = 'SendOtpRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SendOtpRouteArgs>();
      return _i11.SendOtpScreen(
        key: args.key,
        onSuccess: args.onSuccess,
        username: args.username,
        showSendToField: args.showSendToField,
      );
    },
  );
}

class SendOtpRouteArgs {
  const SendOtpRouteArgs({
    this.key,
    required this.onSuccess,
    required this.username,
    this.showSendToField = false,
  });

  final _i15.Key? key;

  final dynamic Function({required String email, required String token})
  onSuccess;

  final String username;

  final bool showSendToField;

  @override
  String toString() {
    return 'SendOtpRouteArgs{key: $key, onSuccess: $onSuccess, username: $username, showSendToField: $showSendToField}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SendOtpRouteArgs) return false;
    return key == other.key &&
        username == other.username &&
        showSendToField == other.showSendToField;
  }

  @override
  int get hashCode =>
      key.hashCode ^ username.hashCode ^ showSendToField.hashCode;
}

/// generated route for
/// [_i12.SplashScreen]
class SplashRoute extends _i14.PageRouteInfo<void> {
  const SplashRoute({List<_i14.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i12.SplashScreen();
    },
  );
}

/// generated route for
/// [_i13.TermsOfUseScreen]
class TermsOfUseRoute extends _i14.PageRouteInfo<void> {
  const TermsOfUseRoute({List<_i14.PageRouteInfo>? children})
    : super(TermsOfUseRoute.name, initialChildren: children);

  static const String name = 'TermsOfUseRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i13.TermsOfUseScreen();
    },
  );
}
