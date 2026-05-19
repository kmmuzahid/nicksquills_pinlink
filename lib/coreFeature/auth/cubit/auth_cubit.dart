/*
 * @Author: Km Muzahid
 * @Date: 2026-01-07 14:10:08
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart'
    show LoginRoute, SubscriptionsRoute, OnboardingRoute;
import 'package:pinlink/config/storage/storage_key.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/constant/subscriptions.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_state.dart';
import 'package:pinlink/coreFeature/auth/repository/auth_repository.dart';
import 'package:pinlink/coreFeature/navigation/cubit/navigation_cubit.dart';

class AuthCubit extends SafeCubit<AuthState> {
  AuthCubit() : super(AuthState(subscriptionPlan: creatorPlan));
  final _delaySplash = const Duration(seconds: 3);
  final AuthRepository _authRepository = AuthRepository();

  Future<void> init() async {
    // await StorageService.instance.clearDb();
    await Future.delayed(_delaySplash);

    final token = await StorageService.instance.accessToken;
    if (token != null && token.isNotEmpty) {
      await getProfile();
      appRouter.replaceAll([SubscriptionsRoute(isBackDisabled: true)]);
      return;
    }

    appRouter.replace(const OnboardingRoute());
  }

  Future<void> changeUserSettings(UserSettings userSettings) async {
    emit(
      state.copyWith(
        profile: state.profile?.copyWith(
          isHandicap: userSettings == UserSettings.isHandicap
              ? !(state.profile?.isHandicap ?? false)
              : null,
          isFriendRequest: userSettings == UserSettings.isFriendRequest
              ? !(state.profile?.isFriendRequest ?? false)
              : null,
          isLeaderBoardUpdate: userSettings == UserSettings.isLeaderBoardUpdate
              ? !(state.profile?.isLeaderBoardUpdate ?? false)
              : null,
          isTournamentInvite: userSettings == UserSettings.isTournamentInvite
              ? !(state.profile?.isTournamentInvite ?? false)
              : null,
          isScoreUpdate: userSettings == UserSettings.isScoreUpdate
              ? !(state.profile?.isScoreUpdate ?? false)
              : null,
          isPlayCourse: userSettings == UserSettings.isPlayCourse
              ? !(state.profile?.isPlayCourse ?? false)
              : null,
        ),
      ),
    );

    final result = await DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.settingsOnOff,
        method: .POST,
        jsonBody: {'type': userSettings.name},
      ),
      responseBuilder: (json) => json,
    );

    if (result.isSuccess) {
      getProfile();
    }
  }

  Future<void> deleteAccount({required String password}) async {
    final result = await DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.deleteAccount,
        method: .DELETE,
        jsonBody: {'password': password},
      ),
      responseBuilder: (json) => json,
    );

    if (result.isSuccess) {
      logout();
    }
  }

  Future<void> updateTokens(String accessToken, String refreshToken) async {
    emit(
      AuthState(
        accessToken: accessToken,
        refreshToken: refreshToken,
        subscriptionPlan: state.subscriptionPlan,
      ),
    );
    StorageService.instance.accessToken = accessToken;
    StorageService.instance.refreshToken = refreshToken.startsWith('Bearer ')
        ? refreshToken
        : 'Bearer $refreshToken';
  }

  Future<void> logout() async {
    // final result = await _authRepository.logout(
    //   refreshToken: state.refreshToken,
    //   accessToken: state.accessToken,
    // );
    // if (result.isSuccess) {
    clearTokens();
    // }
  }

  Future<void> updateSubscriptionPlan(Plan plan) async {
    emit(state.copyWith(subscriptionPlan: plan));
  }

  Future<void> clearTokens() async {
    await StorageService.instance.clearDb();
    emit(AuthState(subscriptionPlan: freePlan));
    appRouter.replaceAll([const LoginRoute()]);
    appRouter.navigatorKey.currentContext?.read<NavigationCubit>().changeIndex(
      0,
    );
  }

  Future<void> getProfile() async {
    final result = await _authRepository.getProfile();
    if (result.isSuccess) {
      emit(state.copyWith(profile: result.data));
    }
  }
}
