/*
 * @Author: Km Muzahid
 * @Date: 2026-01-11 12:13:44
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/common_widget.dart';
import 'package:pinlink/config/bloc/cubit_scope_value.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/coreFeature/auth/cubit/otp_cubit.dart';

class OtpSend extends StatefulWidget {
  const OtpSend({super.key, this.username, required this.isSignUp, required this.cubit});
  final String? username;
  final bool isSignUp;
  final OtpCubit cubit;

  @override
  State<OtpSend> createState() => _OtpSendState();
}

class _OtpSendState extends State<OtpSend> {
  late TextEditingController controller;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    controller = TextEditingController();
    controller.text = widget.username ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20.w),
        padding: EdgeInsets.only(top: 25.h, bottom: 30.h, left: 16.w, right: 16.w),
        decoration: BoxDecoration(
          color: context.colors.bACKGROUND_darkCard,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [

              const BuildLabel('Email Address'),
              12.height,
              CommonTextField(
                controller: controller,
                isReadOnly: widget.isSignUp,
                hintText: 'Enter email or username here...',
                validationType: ValidationType.validateRequired,
                prefixIcon: const Icon(Icons.email_outlined),
                onSaved: (value, controller) {},
              ),
              40.height,
              CubitScopeValue(
                cubit: widget.cubit,
                builder: (context, cubit, state) {
                  return CommonButton(
                    titleText: 'Send OTP',
                    isLoading: state.isLoading,
                    buttonWidth: double.infinity,
                    titleSize: 12,
                    titleWeight: FontWeight.w500,
                    onTap: () {
                      // if (formKey.currentState?.validate() == true) {
                      context.read<OtpCubit>().sendOtp(controller.text);
                      // }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
 
}
