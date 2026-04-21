/*
 * @Author: Km Muzahid
 * @Date: 2026-02-23 15:16:43
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/text_field/common_text_field.dart';
import 'package:core_kit/text_field/validation_type.dart';
import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/common_widget.dart';
import 'package:pinlink/constant/app_string.dart';
import 'package:pinlink/coreFeature/auth/entity/signup_entity.dart';
import 'package:pinlink/coreFeature/auth/widgets/terms_agreement_widget.dart';

class SignupFormOne extends StatelessWidget {
  const SignupFormOne({super.key, required this.formKey, required this.entity});
  final GlobalKey<FormState> formKey;
  final SignUpEntity entity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Email Field
        BuildLabel(AppString.name),
        CommonTextField(
          hintText: 'Enter Your Full Name',
          validationType: ValidationType.validateRequired,
          prefixIcon: const Icon(Icons.person_outline_outlined),
          onSaved: (value, controller) => entity.fullName = value,
        ),
        10.height,

        const BuildLabel('Username'),
        CommonTextField(
          hintText: 'Enter a Unique Username (e.g., nickgolf23)',
          validationType: ValidationType.validateRequired,
          prefixIcon: const Icon(Icons.person_outline_outlined),
          onSaved: (value, controller) => entity.username = value,
        ),
        10.height,
        // Email Field
        BuildLabel(AppString.email),
        CommonTextField(
          hintText: 'Enter Your Email',
          validationType: ValidationType.validateEmail,
          prefixIcon: const Icon(Icons.email_outlined),
          onSaved: (value, controller) => entity.email = value,
        ),
        10.height,
        BuildLabel(AppString.phone_number),
        CommonTextField(
          hintText: 'Enter Your Phone Number',
          validationType: ValidationType.validatePhone,
          prefixIcon: const Icon(Icons.phone_outlined),
          onSaved: (value, controller) => entity.phoneNumber = value,
        ),
        10.height,
        // Password Field
        BuildLabel(AppString.password),
        CommonTextField(
          hintText: AppString.password,
          validationType: ValidationType.validatePassword,
          prefixIcon: const Icon(Icons.lock_outline),
          onSaved: (value, controller) => entity.password = value,
        ),
        10.height,

        // Password Field
        BuildLabel(AppString.confirm_password),
        CommonTextField(
          hintText: AppString.confirm_password,
          originalPassword: () => entity.password ?? '',
          validationType: ValidationType.validateConfirmPassword,
          prefixIcon: const Icon(Icons.lock_outline),
          onSaved: (value, controller) => entity.confirmPassword = value,
        ),
        20.height,
        TermsAgreementWidget(
          onChanged: (value) {
            entity.isAgree = value;
          },
        ),
        20.height,
      ],
    );
  }
}
