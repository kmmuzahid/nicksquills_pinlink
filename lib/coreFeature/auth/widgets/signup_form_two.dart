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

class SignupFormTwo extends StatelessWidget {
  const SignupFormTwo({super.key, required this.formKey, required this.entity});
  final GlobalKey<FormState> formKey;
  final SignUpEntity entity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Email Field
        const BuildLabel('Hometown'),
        CommonTextField(
          hintText: 'City, Country',
          validationType: ValidationType.validateRequired,
          prefixIcon: const Icon(Icons.location_city),
          onSaved: (value, controller) => entity.hometown = value,
        ),
        10.height,
        // Email Field
        const BuildLabel('Home Course'),
        CommonTextField(
          hintText: 'e.g., Pebble Beach Golf Links',
          validationType: ValidationType.validateRequired,
          prefixIcon: const Icon(Icons.golf_course),
          onSaved: (value, controller) => entity.homeCourse = value,
        ),
        10.height,
        CommonText(
          text:
              'Choose the course you play most frequently. If you do not have a home course, choose the course closest to you',
          isDescription: true,
          left: 5,
          textColor: AppColor.tEXT_subDark,
          textAlign: TextAlign.left,
          maxLines: 5,
        ),
        20.height,
      ],
    );
  }
}
