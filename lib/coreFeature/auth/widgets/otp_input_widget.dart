import 'package:core_kit/core_kit.dart';
import 'package:core_kit/text_field/input_formatters/input_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pinlink/config/bloc/cubit_scope_value.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/app_string.dart';
import 'package:pinlink/coreFeature/auth/cubit/otp_cubit.dart';
import 'package:pinlink/coreFeature/auth/cubit/otp_state.dart';

class OtpInputWidget extends StatefulWidget {
  const OtpInputWidget({
    required this.onSuccess,
    required this.state,
    required this.username,
    required this.cubit,
    super.key,
  });
  final Function({required String token, required String email}) onSuccess;
  final OtpState state;
  final String? username;
  final OtpCubit cubit;
  @override
  State<OtpInputWidget> createState() => _OtpVerifyWidgetState();
}

class _OtpVerifyWidgetState extends State<OtpInputWidget> {
  String otp = '';
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.only(top: 25.h, bottom: 30.h, left: 16.w, right: 16.w),
    decoration: BoxDecoration(
      color: AppColor.bACKGROUND_darkCard,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        CommonText(
          text: AppString.enter_verification_code,
          textColor: AppColor.tEXT_white,
          fontSize: 12,
          bottom: 4,
        ).start,
        Form(key: formKey, child: _otpBuilder(context)),

        _resendOtpTimerBuilder(widget.state).end,
        20.height,
        CubitScopeValue(
          cubit: widget.cubit,
          builder: (context, cubit, state) {
            return CommonButton(
              
              titleText: AppString.verify_otp,
              isLoading: state.isLoading,
              buttonWidth: double.infinity,
              titleSize: 12,
              titleWeight: FontWeight.w500,
              onTap: () {
                if (formKey.currentState?.validate() == true) {
                  context.read<OtpCubit>().verifyOtp(otp, widget.onSuccess);
                }
              },
            );
          },
        ),
      ],
    ),
  );

  Widget _resendOtpTimerBuilder(OtpState state) {
    return state.count == 0
        ? _resendMessageBuilder(state)
        : CommonText(
            alignment: MainAxisAlignment.end,
            text: '${AppString.resend_code_in} ${state.count} ${AppString.seconds}',
            fontWeight: FontWeight.bold,
            textColor: AppColor.sTATUS_info,
          );
  }

  Widget _resendMessageBuilder(OtpState state) => Align(
    alignment: Alignment.centerRight,
    child: Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '${AppString.didnt_recive_code}? ',
            style: TextStyle(
              color: getTheme.textTheme.bodySmall?.color,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),

          /// Sign Up Button here
          TextSpan(
            text: AppString.resend_code,
            recognizer: TapGestureRecognizer()
              ..onTap = () { 
                context.read<OtpCubit>().sendOtp(widget.username, isResend: true);
              },
            style: const TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    ),
  );

  Widget _otpBuilder(BuildContext context) {
    return PinCodeTextField(  
      cursorColor: AppColor.pRIMARY_brandClr,
      backgroundColor: Colors.transparent,
      textStyle: getTheme.textTheme.bodyMedium?.copyWith(
        fontSize: 25,
        color: AppColor.pRIMARY_brandClr,
      ),
      appContext: context,
      autoFocus: true,
      onChanged: (value) {
        otp = value;
      },
      pinTheme: PinTheme(
        
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(4),
        fieldHeight: 40,
        fieldWidth: 40,
        activeFillColor: AppColor.bACKGROUND_darkPage,
        selectedFillColor: AppColor.bACKGROUND_darkPage,
        inactiveFillColor: AppColor.bACKGROUND_darkPage,
        borderWidth: 0.1,
        selectedColor: AppColor.bACKGROUND_darkPage,
        activeColor: AppColor.bACKGROUND_darkPage,
        inactiveColor: AppColor.bACKGROUND_darkPage,
      ),
      length: 6, 
      keyboardType: InputHelper.getKeyboardType(ValidationType.validateOTP),
      inputFormatters: InputHelper.getInputFormatters(ValidationType.validateOTP),
      autovalidateMode: AutovalidateMode.disabled,
      enableActiveFill: true,
      validator: (value) => InputHelper.validate(ValidationType.validateOTP, value),
    );
  }

  @override
  void dispose() { 
    super.dispose();
  }
}
