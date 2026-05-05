/*
 * @Author: Km Muzahid
 * @Date: 2026-01-11 11:48:18
 * @Email: km.muzahid@gmail.com
 */
import 'dart:async';

import 'package:core_kit/snackbar/snackbar.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/coreFeature/auth/cubit/otp_state.dart';
import 'package:pinlink/coreFeature/auth/repository/auth_repository.dart';

class OtpCubit extends SafeCubit<OtpState> {
  OtpCubit() : super(const OtpState());
  final AuthRepository _authRepository = AuthRepository();
  Timer? _timer;

  Future<void> resetState() async {
    emit(const OtpState());
  }

  Future<void> sendOtp(String? username, {bool isResend = false}) async {
    if (state.isLoading) {
      showSnackBar(
        'Please wait for the current request to complete',
        type: SnackBarType.warning,
      );
      return;
    }
    if (_timer?.isActive == true) {
      showSnackBar(
        'Resent Code in ${state.count} seconds',
        type: SnackBarType.warning,
      );
      return;
    }
    emit(
      state.copyWith(
        isLoading: true,
        isOtpSent: false,
        username: username,
        isResend: isResend,
      ),
    );

    final result = await _authRepository.sendOtp(
      username ?? state.username,
      isResend: isResend,
      resendToken: state.resendToken,
    );

    if (result.isSuccess) {
      emit(
        state.copyWith(
          isLoading: false,
          isOtpSent: true,
          resendToken: result.data?['forgetToken']?.toString() ?? '',
        ),
      );
      _startTimer();
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> verifyOtp(
    String otp,
    Function({required String token, required String email}) onSuccess,
  ) async {
    //remove it on integration
    onSuccess(token: '', email: state.username);

    //uncomment it on integration
    // if (state.isLoading) return;
    // final result = await _authRepository.verifyOtp(email: state.username, otp: otp);
    // if (result.isSuccess) {
    //   emit(state.copyWith(isVerified: true, isLoading: false));
    //   onSuccess(token: result.data ?? '', email: state.username);
    // } else {
    //   emit(state.copyWith(isLoading: false));
    // }
  }

  void alreadyOtpSent(String? username) {
    //remove it on integration
    emit(state.copyWith(isLoading: false, isOtpSent: true, username: username));
    _startTimer();
    //uncomment it on integration
    // if (_timer?.isActive == true) {
    //   showSnackBar('Resent Code in ${state.count} seconds', type: SnackBarType.warning);
    //   return;
    // }
    // emit(state.copyWith(isLoading: false, isOtpSent: true, username: username));
    // _startTimer();
  }

  void _startTimer() {
    emit(state.copyWith(count: state.maxCount));
    _timer = null;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(state.copyWith(count: state.count - 1));
      if (state.count <= 0) {
        _timer?.cancel();
        _timer = null;
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
