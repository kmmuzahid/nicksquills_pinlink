import 'package:equatable/equatable.dart';

class PolicyState extends Equatable {
  final String privacyPolicy;
  final String termsAndConditions;
  final bool isLoading;

  const PolicyState({
    this.privacyPolicy = '',
    this.termsAndConditions = '',
    this.isLoading = false,
  });

  PolicyState copyWith({
    String? privacyPolicy,
    String? termsAndConditions,
    bool? isLoading,
  }) => PolicyState(
    privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    termsAndConditions: termsAndConditions ?? this.termsAndConditions,
    isLoading: isLoading ?? this.isLoading,
  );

  @override
  List<Object?> get props => [privacyPolicy, termsAndConditions, isLoading];
}
