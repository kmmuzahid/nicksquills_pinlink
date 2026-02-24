/*
 * @Author: Km Muzahid
 * @Date: 2026-01-08 17:14:27
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:core_kit/app_bar/common_app_bar.dart';
import 'package:core_kit/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/simple_background.dart';

@RoutePage()
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleBackground(
      appBar: CommonAppBar(title: "Privacy Policy"),
      body: Center(
        child: CommonText(text: "Privacy Policy", fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
