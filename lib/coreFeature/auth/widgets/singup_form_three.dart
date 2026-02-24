/*
 * @Author: Km Muzahid
 * @Date: 2026-02-23 15:16:43
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/common_widget.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/coreFeature/auth/entity/signup_entity.dart';

class SignupFormThree extends StatelessWidget {
  const SignupFormThree({super.key, required this.formKey, required this.entity});
  final GlobalKey<FormState> formKey;
  final SignUpEntity entity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Email Field
        const BuildLabel('Estimated Handicap'),
        CommonTextField(
          hintText: 'e.g.,12.5',
          validationType: ValidationType.validateRequired,
          prefixIcon: const Icon(Icons.email_outlined),
          onSaved: (value, controller) => entity.handicap = value,
        ),
        CommonText(
          text: 'Don’t know? Enter an estimate between 0-36',
          textColor: AppColor.textSubDark,
          isDescription: true,
          fontSize: 12,
          top: 4,
          left: 10,
          maxLines: 2,
        ),
        10.height,
        _buildInfo(),
        // Email Field
        20.height,
      ],
    );
  }

  Widget _buildInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.infoBoxColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonText(text: 'What Next?', fontSize: 16, fontWeight: FontWeight.w500),
          _buildText(text: 'Add 5-10 courses you’ve played'),
          _buildText(text: 'Compare courses to build your rankings'),
          _buildText(text: 'Add courses to your wishlist'),
        ],
      ),
    );
  }

  CommonText _buildText({required String text}) {
    return CommonText(
      preffix: Icon(Icons.check, color: AppColor.primary, size: 16),
      text: text,
      textColor: AppColor.textSubDark,
      isDescription: true,
      fontSize: 12,
      top: 4,
      left: 10,
      maxLines: 2,
    );
  }
}
