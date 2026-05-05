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
        _buildText(context, 'Name', entity.fullName ?? ''),
        _buildText(context, 'Username', entity.username ?? ''),
        _buildText(context, 'Email', entity.email ?? ''),
        _buildText(context, 'Hometown', entity.hometown ?? ''),
        _buildText(context, 'Home Course', entity.homeCourse ?? ''),
        _buildText(
          context,
          'Estimated Handicap',
          entity.handicap ?? '',
          isLast: true,
        ),
        20.height,
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: context.colors.bACKGROUND_darkPage,
            border: Border.all(
              color: context.colors.bACKGROUND_darkCardBoarder,
              width: 1.4,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'By clicking “Create Account”, you agree to our ',
                  style: TextStyle(color: context.colors.tEXT_sub),
                ),
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(color: context.colors.pRIMARY_priSoft),
                ),
                TextSpan(
                  text: ' and ',
                  style: TextStyle(color: context.colors.tEXT_sub),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(color: context.colors.pRIMARY_priSoft),
                ),
              ],
            ),
          ),
        ),
        20.height,
      ],
    );
  }

  Widget _buildText(
    BuildContext context,
    String title,
    String value, {
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: !isLast
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: context.colors.bACKGROUND_darkCardBoarder,
                  width: 1.4,
                ),
              ),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: context.colors.tEXT_subDark,
          ),
          20.width,
          Expanded(
            child: Align(
              alignment: .centerRight,
              child: CommonText(
                text: value,
                textAlign: .right,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textColor: context.colors.tEXT_white,
                isDescription: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
