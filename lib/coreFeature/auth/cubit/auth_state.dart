/*
 * @Author: Km Muzahid
 * @Date: 2026-01-07 14:11:36
 * @Email: km.muzahid@gmail.com
 */
import 'package:equatable/equatable.dart';
import 'package:pinlink/constant/subscriptions.dart';
import 'package:pinlink/coreFeature/auth/model/profile_model.dart';

class AuthState extends Equatable {
  final String accessToken;
  final String refreshToken;
  final bool isLoading;
  final Plan subscriptionPlan;
  final ProfileModel? profile;

  const AuthState({
    this.accessToken = '',
    this.refreshToken = '',
    this.isLoading = false,
    required this.subscriptionPlan,
    this.profile,
  });

  AuthState copyWith({
    String? accessToken,
    String? refreshToken,
    bool? isLoading,
    Plan? subscriptionPlan,
    ProfileModel? profile,
  }) {
    return AuthState(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      isLoading: isLoading ?? this.isLoading,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
    isLoading,
    subscriptionPlan,
    profile,
  ];
}
