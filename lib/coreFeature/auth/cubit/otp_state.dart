// ignore_for_file: public_member_api_docs, sort_constructors_first

class OtpState {
  const OtpState({
    this.otp = '',
    this.count = 0,
    this.verificationId = '',
    this.isVerified = false,
    this.isLoading = false,
    this.username = '',
    this.isOtpSent = false,
    this.isResend = false,
    this.resendToken = '',
  });
  final String otp;
  final String verificationId;
  final bool isVerified;
  final String username;
  final int maxCount = 120; // 2 minutes
  final bool isLoading;
  final int count;
  final bool isOtpSent;
  final bool isResend;
  final String resendToken;

  OtpState copyWith({
    String? otp,
    String? verificationId,
    bool? isVerified,
    String? username,
    bool? isLoading,
    int? count,
    bool? isOtpSent,
    bool? isResend,
    String? resendToken,
  }) {
    return OtpState(
      otp: otp ?? this.otp,
      verificationId: verificationId ?? this.verificationId,
      isVerified: isVerified ?? this.isVerified,
      username: username ?? this.username,
      isLoading: isLoading ?? this.isLoading,
      count: count ?? this.count,
      isOtpSent: isOtpSent ?? this.isOtpSent,
      isResend: isResend ?? this.isResend,
      resendToken: resendToken ?? this.resendToken,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OtpState &&
        other.otp == otp &&
        other.verificationId == verificationId &&
        other.isVerified == isVerified &&
        other.username == username &&
        other.isLoading == isLoading &&
        other.count == count &&
        other.isOtpSent == isOtpSent &&
        other.isResend == isResend &&
        other.resendToken == resendToken;
  }

  @override
  int get hashCode {
    return otp.hashCode ^
        verificationId.hashCode ^
        isVerified.hashCode ^
        username.hashCode ^
        isLoading.hashCode ^
        count.hashCode ^
        isOtpSent.hashCode ^
        isResend.hashCode;
  }
}
