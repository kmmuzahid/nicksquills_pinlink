/*
 * @Author: Km Muzahid
 * @Date: 2026-02-24 10:34:47
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/coreFeature/auth/entity/signup_entity.dart';

class SignUpOverview extends StatelessWidget {
  final SignUpEntity entity;
  const SignUpOverview({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildText('Name', entity.fullName ?? ''),
        _buildText('Username', entity.username ?? ''),
        _buildText('Email', entity.email ?? ''),
        _buildText('Hometown', entity.hometown ?? ''),
        _buildText('Home Course', entity.homeCourse ?? ''),
        _buildText('Estimated Handicap', entity.handicap ?? '', isLast: true),
        20.height,
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColor.infoBoxColor,
            border: Border.all(color: AppColor.outlineColor, width: 1.4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'By clicking “Create Account”, you agree to our ',
                  style: TextStyle(color: AppColor.textSub),
                ),
                const TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(color: Color(0xFF6FAE97)),
                ),
                TextSpan(
                  text: ' and ',
                  style: TextStyle(color: AppColor.textSub),
                ),
                const TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(color: Color(0xFF6FAE97)),
                ),
              ],
            ),
          ),
        ),
        20.height,
      ],
    );
  }

  Widget _buildText(String title, String value, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: !isLast
          ? BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColor.outlineColor, width: 1.4)),
            )
          : null,
      child: Row(
        children: [
          CommonText(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: AppColor.textSubDark,
          ),
          const Spacer(),
          CommonText(
            text: value,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
