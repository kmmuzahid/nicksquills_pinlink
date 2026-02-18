/*
 * @Author: Km Muzahid
 * @Date: 2026-01-07 14:11:36
 * @Email: km.muzahid@gmail.com
 */
import 'package:equatable/equatable.dart';
import 'package:pinlink/constant/enums.dart';

class AuthState extends Equatable {
  final String accessToken;
  final String refreshToken;
  final bool isLoading; 
  final SubscriptionType subscriptionType;

  const AuthState({
    this.accessToken = '',
    this.refreshToken = '',
    this.isLoading = false,
    this.subscriptionType = SubscriptionType.Free,
  });

  AuthState copyWith({
    String? accessToken,
    String? refreshToken,
    bool? isLoading,
    SubscriptionType? subscriptionType,
  }) {
    return AuthState(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      isLoading: isLoading ?? this.isLoading, 
      subscriptionType: subscriptionType ?? this.subscriptionType,
    );
  }

  @override
  List<Object?> get props => [accessToken, refreshToken, isLoading, subscriptionType];
}
