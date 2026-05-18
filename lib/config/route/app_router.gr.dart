// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i25;
import 'package:flutter/material.dart' as _i26;
import 'package:pinlink/constant/enums.dart' as _i28;
import 'package:pinlink/coreFeature/about_us/about_us_screen.dart' as _i1;
import 'package:pinlink/coreFeature/auth/screens/change_password_screen.dart'
    as _i4;
import 'package:pinlink/coreFeature/auth/screens/login_screen.dart' as _i11;
import 'package:pinlink/coreFeature/auth/screens/reset_password_screen.dart'
    as _i17;
import 'package:pinlink/coreFeature/auth/screens/send_otp_screen.dart' as _i18;
import 'package:pinlink/coreFeature/custom_google_map/screen/custom_map_screen.dart'
    as _i7;
import 'package:pinlink/coreFeature/faq/screens/faq_screen.dart' as _i9;
import 'package:pinlink/coreFeature/navigation/screens/navigation_screen.dart'
    as _i12;
import 'package:pinlink/coreFeature/notification/notification_screen.dart'
    as _i13;
import 'package:pinlink/coreFeature/onboarding/onboarding_screen.dart' as _i14;
import 'package:pinlink/coreFeature/setting/screens/edit_profile_screen.dart'
    as _i8;
import 'package:pinlink/coreFeature/setting/screens/setting_screen.dart'
    as _i19;
import 'package:pinlink/coreFeature/splash/splash_screen.dart' as _i20;
import 'package:pinlink/coreFeature/terms/privacy_policy_screen.dart' as _i16;
import 'package:pinlink/coreFeature/terms/terms_of_use_screen.dart' as _i23;
import 'package:pinlink/features/course_comparision/cubit/add_course_cubit.dart'
    as _i27;
import 'package:pinlink/features/course_comparision/model/course_model.dart'
    as _i29;
import 'package:pinlink/features/course_comparision/screens/add_course_screen.dart'
    as _i2;
import 'package:pinlink/features/course_comparision/screens/comparison_screen.dart'
    as _i5;
import 'package:pinlink/features/leaderboard/screens/build_tournament_screen.dart'
    as _i3;
import 'package:pinlink/features/leaderboard/screens/friend_screen.dart'
    as _i10;
import 'package:pinlink/features/social/model/post_model.dart' as _i30;
import 'package:pinlink/features/social/screens/create_post_screen.dart' as _i6;
import 'package:pinlink/features/social/screens/post_details_screen.dart'
    as _i15;
import 'package:pinlink/features/subscription/screens/subscriptions_screen.dart'
    as _i21;
import 'package:pinlink/features/support/screens/support_screen.dart' as _i22;
import 'package:pinlink/features/tournament/screens/tournament_list_screen.dart'
    as _i24;

/// generated route for
/// [_i1.AboutUsScreen]
class AboutUsRoute extends _i25.PageRouteInfo<void> {
  const AboutUsRoute({List<_i25.PageRouteInfo>? children})
    : super(AboutUsRoute.name, initialChildren: children);

  static const String name = 'AboutUsRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutUsScreen();
    },
  );
}

/// generated route for
/// [_i2.AddCourseScreen]
class AddCourseRoute extends _i25.PageRouteInfo<AddCourseRouteArgs> {
  AddCourseRoute({
    _i26.Key? key,
    bool enableSafeArea = true,
    bool isInNavigation = false,
    List<_i25.PageRouteInfo>? children,
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

  static _i25.PageInfo page = _i25.PageInfo(
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

  final _i26.Key? key;

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
/// [_i3.BuildTournamentScreen]
class BuildTournamentRoute extends _i25.PageRouteInfo<void> {
  const BuildTournamentRoute({List<_i25.PageRouteInfo>? children})
    : super(BuildTournamentRoute.name, initialChildren: children);

  static const String name = 'BuildTournamentRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i3.BuildTournamentScreen();
    },
  );
}

/// generated route for
/// [_i4.ChangePasswordScreen]
class ChangePasswordRoute extends _i25.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i25.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i4.ChangePasswordScreen();
    },
  );
}

/// generated route for
/// [_i5.ComparisonScreen]
class ComparisonRoute extends _i25.PageRouteInfo<ComparisonRouteArgs> {
  ComparisonRoute({
    _i26.Key? key,
    required _i27.AddCourseCubit cubit,
    required int questinIndex,
    required _i28.RankingType rankingType,
    bool isNaviagtion = false,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         ComparisonRoute.name,
         args: ComparisonRouteArgs(
           key: key,
           cubit: cubit,
           questinIndex: questinIndex,
           rankingType: rankingType,
           isNaviagtion: isNaviagtion,
         ),
         initialChildren: children,
       );

  static const String name = 'ComparisonRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ComparisonRouteArgs>();
      return _i5.ComparisonScreen(
        key: args.key,
        cubit: args.cubit,
        questinIndex: args.questinIndex,
        rankingType: args.rankingType,
        isNaviagtion: args.isNaviagtion,
      );
    },
  );
}

class ComparisonRouteArgs {
  const ComparisonRouteArgs({
    this.key,
    required this.cubit,
    required this.questinIndex,
    required this.rankingType,
    this.isNaviagtion = false,
  });

  final _i26.Key? key;

  final _i27.AddCourseCubit cubit;

  final int questinIndex;

  final _i28.RankingType rankingType;

  final bool isNaviagtion;

  @override
  String toString() {
    return 'ComparisonRouteArgs{key: $key, cubit: $cubit, questinIndex: $questinIndex, rankingType: $rankingType, isNaviagtion: $isNaviagtion}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ComparisonRouteArgs) return false;
    return key == other.key &&
        cubit == other.cubit &&
        questinIndex == other.questinIndex &&
        rankingType == other.rankingType &&
        isNaviagtion == other.isNaviagtion;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      cubit.hashCode ^
      questinIndex.hashCode ^
      rankingType.hashCode ^
      isNaviagtion.hashCode;
}

/// generated route for
/// [_i6.CreatePostScreen]
class CreatePostRoute extends _i25.PageRouteInfo<CreatePostRouteArgs> {
  CreatePostRoute({
    _i26.Key? key,
    _i29.CourseModel? courseModel,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         CreatePostRoute.name,
         args: CreatePostRouteArgs(key: key, courseModel: courseModel),
         initialChildren: children,
       );

  static const String name = 'CreatePostRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreatePostRouteArgs>(
        orElse: () => const CreatePostRouteArgs(),
      );
      return _i6.CreatePostScreen(key: args.key, courseModel: args.courseModel);
    },
  );
}

class CreatePostRouteArgs {
  const CreatePostRouteArgs({this.key, this.courseModel});

  final _i26.Key? key;

  final _i29.CourseModel? courseModel;

  @override
  String toString() {
    return 'CreatePostRouteArgs{key: $key, courseModel: $courseModel}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreatePostRouteArgs) return false;
    return key == other.key && courseModel == other.courseModel;
  }

  @override
  int get hashCode => key.hashCode ^ courseModel.hashCode;
}

/// generated route for
/// [_i7.CustomMapScreen]
class CustomMapRoute extends _i25.PageRouteInfo<CustomMapRouteArgs> {
  CustomMapRoute({
    _i26.Key? key,
    _i28.MapFilters? mapFilters,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         CustomMapRoute.name,
         args: CustomMapRouteArgs(key: key, mapFilters: mapFilters),
         initialChildren: children,
       );

  static const String name = 'CustomMapRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomMapRouteArgs>(
        orElse: () => const CustomMapRouteArgs(),
      );
      return _i7.CustomMapScreen(key: args.key, mapFilters: args.mapFilters);
    },
  );
}

class CustomMapRouteArgs {
  const CustomMapRouteArgs({this.key, this.mapFilters});

  final _i26.Key? key;

  final _i28.MapFilters? mapFilters;

  @override
  String toString() {
    return 'CustomMapRouteArgs{key: $key, mapFilters: $mapFilters}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomMapRouteArgs) return false;
    return key == other.key && mapFilters == other.mapFilters;
  }

  @override
  int get hashCode => key.hashCode ^ mapFilters.hashCode;
}

/// generated route for
/// [_i8.EditProfileScreen]
class EditProfileRoute extends _i25.PageRouteInfo<void> {
  const EditProfileRoute({List<_i25.PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i8.EditProfileScreen();
    },
  );
}

/// generated route for
/// [_i9.FaqScreen]
class FaqRoute extends _i25.PageRouteInfo<void> {
  const FaqRoute({List<_i25.PageRouteInfo>? children})
    : super(FaqRoute.name, initialChildren: children);

  static const String name = 'FaqRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i9.FaqScreen();
    },
  );
}

/// generated route for
/// [_i10.FriendsScreen]
class FriendsRoute extends _i25.PageRouteInfo<void> {
  const FriendsRoute({List<_i25.PageRouteInfo>? children})
    : super(FriendsRoute.name, initialChildren: children);

  static const String name = 'FriendsRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i10.FriendsScreen();
    },
  );
}

/// generated route for
/// [_i11.LoginScreen]
class LoginRoute extends _i25.PageRouteInfo<void> {
  const LoginRoute({List<_i25.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i11.LoginScreen();
    },
  );
}

/// generated route for
/// [_i12.NavigationScreen]
class NavigationRoute extends _i25.PageRouteInfo<void> {
  const NavigationRoute({List<_i25.PageRouteInfo>? children})
    : super(NavigationRoute.name, initialChildren: children);

  static const String name = 'NavigationRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i12.NavigationScreen();
    },
  );
}

/// generated route for
/// [_i13.NotificationScreen]
class NotificationRoute extends _i25.PageRouteInfo<void> {
  const NotificationRoute({List<_i25.PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i13.NotificationScreen();
    },
  );
}

/// generated route for
/// [_i14.OnboardingScreen]
class OnboardingRoute extends _i25.PageRouteInfo<void> {
  const OnboardingRoute({List<_i25.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i14.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i15.PostDetailsScreen]
class PostDetailsRoute extends _i25.PageRouteInfo<PostDetailsRouteArgs> {
  PostDetailsRoute({
    _i26.Key? key,
    required String? postId,
    required void Function() reportPost,
    required void Function(_i30.PostModel) onChanged,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         PostDetailsRoute.name,
         args: PostDetailsRouteArgs(
           key: key,
           postId: postId,
           reportPost: reportPost,
           onChanged: onChanged,
         ),
         initialChildren: children,
       );

  static const String name = 'PostDetailsRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostDetailsRouteArgs>();
      return _i15.PostDetailsScreen(
        key: args.key,
        postId: args.postId,
        reportPost: args.reportPost,
        onChanged: args.onChanged,
      );
    },
  );
}

class PostDetailsRouteArgs {
  const PostDetailsRouteArgs({
    this.key,
    required this.postId,
    required this.reportPost,
    required this.onChanged,
  });

  final _i26.Key? key;

  final String? postId;

  final void Function() reportPost;

  final void Function(_i30.PostModel) onChanged;

  @override
  String toString() {
    return 'PostDetailsRouteArgs{key: $key, postId: $postId, reportPost: $reportPost, onChanged: $onChanged}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PostDetailsRouteArgs) return false;
    return key == other.key && postId == other.postId;
  }

  @override
  int get hashCode => key.hashCode ^ postId.hashCode;
}

/// generated route for
/// [_i16.PrivacyPolicyScreen]
class PrivacyPolicyRoute extends _i25.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i25.PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i16.PrivacyPolicyScreen();
    },
  );
}

/// generated route for
/// [_i17.ResetPasswordScreen]
class ResetPasswordRoute extends _i25.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i26.Key? key,
    required String verificationToken,
    required String email,
    List<_i25.PageRouteInfo>? children,
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

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>();
      return _i17.ResetPasswordScreen(
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

  final _i26.Key? key;

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
/// [_i18.SendOtpScreen]
class SendOtpRoute extends _i25.PageRouteInfo<SendOtpRouteArgs> {
  SendOtpRoute({
    _i26.Key? key,
    required dynamic Function({required String email, required String token})
    onSuccess,
    required String username,
    bool showSendToField = false,
    String? token,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         SendOtpRoute.name,
         args: SendOtpRouteArgs(
           key: key,
           onSuccess: onSuccess,
           username: username,
           showSendToField: showSendToField,
           token: token,
         ),
         initialChildren: children,
       );

  static const String name = 'SendOtpRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SendOtpRouteArgs>();
      return _i18.SendOtpScreen(
        key: args.key,
        onSuccess: args.onSuccess,
        username: args.username,
        showSendToField: args.showSendToField,
        token: args.token,
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
    this.token,
  });

  final _i26.Key? key;

  final dynamic Function({required String email, required String token})
  onSuccess;

  final String username;

  final bool showSendToField;

  final String? token;

  @override
  String toString() {
    return 'SendOtpRouteArgs{key: $key, onSuccess: $onSuccess, username: $username, showSendToField: $showSendToField, token: $token}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SendOtpRouteArgs) return false;
    return key == other.key &&
        username == other.username &&
        showSendToField == other.showSendToField &&
        token == other.token;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      username.hashCode ^
      showSendToField.hashCode ^
      token.hashCode;
}

/// generated route for
/// [_i19.SettingScreen]
class SettingRoute extends _i25.PageRouteInfo<void> {
  const SettingRoute({List<_i25.PageRouteInfo>? children})
    : super(SettingRoute.name, initialChildren: children);

  static const String name = 'SettingRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i19.SettingScreen();
    },
  );
}

/// generated route for
/// [_i20.SplashScreen]
class SplashRoute extends _i25.PageRouteInfo<void> {
  const SplashRoute({List<_i25.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i20.SplashScreen();
    },
  );
}

/// generated route for
/// [_i21.SubscriptionsScreen]
class SubscriptionsRoute extends _i25.PageRouteInfo<SubscriptionsRouteArgs> {
  SubscriptionsRoute({
    _i26.Key? key,
    bool isBackDisabled = false,
    bool isNavPage = false,
    bool isSubscriptionMangement = false,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         SubscriptionsRoute.name,
         args: SubscriptionsRouteArgs(
           key: key,
           isBackDisabled: isBackDisabled,
           isNavPage: isNavPage,
           isSubscriptionMangement: isSubscriptionMangement,
         ),
         initialChildren: children,
       );

  static const String name = 'SubscriptionsRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SubscriptionsRouteArgs>(
        orElse: () => const SubscriptionsRouteArgs(),
      );
      return _i21.SubscriptionsScreen(
        key: args.key,
        isBackDisabled: args.isBackDisabled,
        isNavPage: args.isNavPage,
        isSubscriptionMangement: args.isSubscriptionMangement,
      );
    },
  );
}

class SubscriptionsRouteArgs {
  const SubscriptionsRouteArgs({
    this.key,
    this.isBackDisabled = false,
    this.isNavPage = false,
    this.isSubscriptionMangement = false,
  });

  final _i26.Key? key;

  final bool isBackDisabled;

  final bool isNavPage;

  final bool isSubscriptionMangement;

  @override
  String toString() {
    return 'SubscriptionsRouteArgs{key: $key, isBackDisabled: $isBackDisabled, isNavPage: $isNavPage, isSubscriptionMangement: $isSubscriptionMangement}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SubscriptionsRouteArgs) return false;
    return key == other.key &&
        isBackDisabled == other.isBackDisabled &&
        isNavPage == other.isNavPage &&
        isSubscriptionMangement == other.isSubscriptionMangement;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      isBackDisabled.hashCode ^
      isNavPage.hashCode ^
      isSubscriptionMangement.hashCode;
}

/// generated route for
/// [_i22.SupportScreen]
class SupportRoute extends _i25.PageRouteInfo<void> {
  const SupportRoute({List<_i25.PageRouteInfo>? children})
    : super(SupportRoute.name, initialChildren: children);

  static const String name = 'SupportRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i22.SupportScreen();
    },
  );
}

/// generated route for
/// [_i23.TermsOfUseScreen]
class TermsOfUseRoute extends _i25.PageRouteInfo<void> {
  const TermsOfUseRoute({List<_i25.PageRouteInfo>? children})
    : super(TermsOfUseRoute.name, initialChildren: children);

  static const String name = 'TermsOfUseRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i23.TermsOfUseScreen();
    },
  );
}

/// generated route for
/// [_i24.TournamentListScreen]
class TournamentListRoute extends _i25.PageRouteInfo<void> {
  const TournamentListRoute({List<_i25.PageRouteInfo>? children})
    : super(TournamentListRoute.name, initialChildren: children);

  static const String name = 'TournamentListRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i24.TournamentListScreen();
    },
  );
}
