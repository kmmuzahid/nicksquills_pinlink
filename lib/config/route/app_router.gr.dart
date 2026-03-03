// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;
import 'package:pinlink/coreFeature/about_us/about_us_screen.dart' as _i1;
import 'package:pinlink/coreFeature/auth/screens/change_password_screen.dart'
    as _i3;
import 'package:pinlink/coreFeature/auth/screens/login_screen.dart' as _i6;
import 'package:pinlink/coreFeature/auth/screens/reset_password_screen.dart'
    as _i12;
import 'package:pinlink/coreFeature/auth/screens/send_otp_screen.dart' as _i13;
import 'package:pinlink/coreFeature/faq/screens/faq_screen.dart' as _i5;
import 'package:pinlink/coreFeature/navigation/screens/navigation_screen.dart'
    as _i7;
import 'package:pinlink/coreFeature/notification/notification_screen.dart'
    as _i8;
import 'package:pinlink/coreFeature/onboarding/onboarding_screen.dart' as _i9;
import 'package:pinlink/coreFeature/profile/screens/personal_information_screen.dart'
    as _i10;
import 'package:pinlink/coreFeature/splash/splash_screen.dart' as _i14;
import 'package:pinlink/coreFeature/terms/privacy_policy_screen.dart' as _i11;
import 'package:pinlink/coreFeature/terms/terms_of_use_screen.dart' as _i16;
import 'package:pinlink/features/course_comparision/cubit/add_course_cubit.dart'
    as _i19;
import 'package:pinlink/features/course_comparision/screens/add_course_screen.dart'
    as _i2;
import 'package:pinlink/features/course_comparision/screens/comparison_screen.dart'
    as _i4;
import 'package:pinlink/features/subscription/screens/subscriptions_screen.dart'
    as _i15;

/// generated route for
/// [_i1.AboutUsScreen]
class AboutUsRoute extends _i17.PageRouteInfo<void> {
  const AboutUsRoute({List<_i17.PageRouteInfo>? children})
    : super(AboutUsRoute.name, initialChildren: children);

  static const String name = 'AboutUsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutUsScreen();
    },
  );
}

/// generated route for
/// [_i2.AddCourseScreen]
class AddCourseRoute extends _i17.PageRouteInfo<AddCourseRouteArgs> {
  AddCourseRoute({
    _i18.Key? key,
    bool enableSafeArea = true,
    bool isInNavigation = false,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         AddCourseRoute.name,
         args: AddCourseRouteArgs(
           key: key,
           enableSafeArea: enableSafeArea,
           isInNavigation: isInNavigation,
         ),
         initialChildren: children,
       );

  static const String name = 'AddCourseRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddCourseRouteArgs>(
        orElse: () => const AddCourseRouteArgs(),
      );
      return _i2.AddCourseScreen(
        key: args.key,
        enableSafeArea: args.enableSafeArea,
        isInNavigation: args.isInNavigation,
      );
    },
  );
}

class AddCourseRouteArgs {
  const AddCourseRouteArgs({
    this.key,
    this.enableSafeArea = true,
    this.isInNavigation = false,
  });

  final _i18.Key? key;

  final bool enableSafeArea;

  final bool isInNavigation;

  @override
  String toString() {
    return 'AddCourseRouteArgs{key: $key, enableSafeArea: $enableSafeArea, isInNavigation: $isInNavigation}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddCourseRouteArgs) return false;
    return key == other.key &&
        enableSafeArea == other.enableSafeArea &&
        isInNavigation == other.isInNavigation;
  }

  @override
  int get hashCode =>
      key.hashCode ^ enableSafeArea.hashCode ^ isInNavigation.hashCode;
}

/// generated route for
/// [_i3.ChangePasswordScreen]
class ChangePasswordRoute extends _i17.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i17.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i3.ChangePasswordScreen();
    },
  );
}

/// generated route for
/// [_i4.ComparisonScreen]
class ComparisonRoute extends _i17.PageRouteInfo<ComparisonRouteArgs> {
  ComparisonRoute({
    _i18.Key? key,
    required _i19.AddCourseCubit cubit,
    required int questinIndex,
    bool isQuestionRanking = true,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         ComparisonRoute.name,
         args: ComparisonRouteArgs(
           key: key,
           cubit: cubit,
           questinIndex: questinIndex,
           isQuestionRanking: isQuestionRanking,
         ),
         initialChildren: children,
       );

  static const String name = 'ComparisonRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ComparisonRouteArgs>();
      return _i4.ComparisonScreen(
        key: args.key,
        cubit: args.cubit,
        questinIndex: args.questinIndex,
        isQuestionRanking: args.isQuestionRanking,
      );
    },
  );
}

class ComparisonRouteArgs {
  const ComparisonRouteArgs({
    this.key,
    required this.cubit,
    required this.questinIndex,
    this.isQuestionRanking = true,
  });

  final _i18.Key? key;

  final _i19.AddCourseCubit cubit;

  final int questinIndex;

  final bool isQuestionRanking;

  @override
  String toString() {
    return 'ComparisonRouteArgs{key: $key, cubit: $cubit, questinIndex: $questinIndex, isQuestionRanking: $isQuestionRanking}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ComparisonRouteArgs) return false;
    return key == other.key &&
        cubit == other.cubit &&
        questinIndex == other.questinIndex &&
        isQuestionRanking == other.isQuestionRanking;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      cubit.hashCode ^
      questinIndex.hashCode ^
      isQuestionRanking.hashCode;
}

/// generated route for
/// [_i5.FaqScreen]
class FaqRoute extends _i17.PageRouteInfo<void> {
  const FaqRoute({List<_i17.PageRouteInfo>? children})
    : super(FaqRoute.name, initialChildren: children);

  static const String name = 'FaqRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i5.FaqScreen();
    },
  );
}

/// generated route for
/// [_i6.LoginScreen]
class LoginRoute extends _i17.PageRouteInfo<void> {
  const LoginRoute({List<_i17.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i6.LoginScreen();
    },
  );
}

/// generated route for
/// [_i7.NavigationScreen]
class NavigationRoute extends _i17.PageRouteInfo<void> {
  const NavigationRoute({List<_i17.PageRouteInfo>? children})
    : super(NavigationRoute.name, initialChildren: children);

  static const String name = 'NavigationRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i7.NavigationScreen();
    },
  );
}

/// generated route for
/// [_i8.NotificationScreen]
class NotificationRoute extends _i17.PageRouteInfo<void> {
  const NotificationRoute({List<_i17.PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i8.NotificationScreen();
    },
  );
}

/// generated route for
/// [_i9.OnboardingScreen]
class OnboardingRoute extends _i17.PageRouteInfo<void> {
  const OnboardingRoute({List<_i17.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i9.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i10.PersonalInformationScreen]
class PersonalInformationRoute extends _i17.PageRouteInfo<void> {
  const PersonalInformationRoute({List<_i17.PageRouteInfo>? children})
    : super(PersonalInformationRoute.name, initialChildren: children);

  static const String name = 'PersonalInformationRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i10.PersonalInformationScreen();
    },
  );
}

/// generated route for
/// [_i11.PrivacyPolicyScreen]
class PrivacyPolicyRoute extends _i17.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i17.PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i11.PrivacyPolicyScreen();
    },
  );
}

/// generated route for
/// [_i12.ResetPasswordScreen]
class ResetPasswordRoute extends _i17.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i18.Key? key,
    required String verificationToken,
    required String email,
    List<_i17.PageRouteInfo>? children,
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

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>();
      return _i12.ResetPasswordScreen(
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

  final _i18.Key? key;

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
/// [_i13.SendOtpScreen]
class SendOtpRoute extends _i17.PageRouteInfo<SendOtpRouteArgs> {
  SendOtpRoute({
    _i18.Key? key,
    required dynamic Function({required String email, required String token})
    onSuccess,
    required String username,
    bool showSendToField = false,
    List<_i17.PageRouteInfo>? children,
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

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SendOtpRouteArgs>();
      return _i13.SendOtpScreen(
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

  final _i18.Key? key;

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
/// [_i14.SplashScreen]
class SplashRoute extends _i17.PageRouteInfo<void> {
  const SplashRoute({List<_i17.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i14.SplashScreen();
    },
  );
}

/// generated route for
/// [_i15.SubscriptionsScreen]
class SubscriptionsRoute extends _i17.PageRouteInfo<SubscriptionsRouteArgs> {
  SubscriptionsRoute({
    _i18.Key? key,
    bool isBackDisabled = false,
    bool isNavPage = false,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         SubscriptionsRoute.name,
         args: SubscriptionsRouteArgs(
           key: key,
           isBackDisabled: isBackDisabled,
           isNavPage: isNavPage,
         ),
         initialChildren: children,
       );

  static const String name = 'SubscriptionsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SubscriptionsRouteArgs>(
        orElse: () => const SubscriptionsRouteArgs(),
      );
      return _i15.SubscriptionsScreen(
        key: args.key,
        isBackDisabled: args.isBackDisabled,
        isNavPage: args.isNavPage,
      );
    },
  );
}

class SubscriptionsRouteArgs {
  const SubscriptionsRouteArgs({
    this.key,
    this.isBackDisabled = false,
    this.isNavPage = false,
  });

  final _i18.Key? key;

  final bool isBackDisabled;

  final bool isNavPage;

  @override
  String toString() {
    return 'SubscriptionsRouteArgs{key: $key, isBackDisabled: $isBackDisabled, isNavPage: $isNavPage}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SubscriptionsRouteArgs) return false;
    return key == other.key &&
        isBackDisabled == other.isBackDisabled &&
        isNavPage == other.isNavPage;
  }

  @override
  int get hashCode =>
      key.hashCode ^ isBackDisabled.hashCode ^ isNavPage.hashCode;
}

/// generated route for
/// [_i16.TermsOfUseScreen]
class TermsOfUseRoute extends _i17.PageRouteInfo<void> {
  const TermsOfUseRoute({List<_i17.PageRouteInfo>? children})
    : super(TermsOfUseRoute.name, initialChildren: children);

  static const String name = 'TermsOfUseRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i16.TermsOfUseScreen();
    },
  );
}
