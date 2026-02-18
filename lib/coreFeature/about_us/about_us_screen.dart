/*
 * @Author: Km Muzahid
 * @Date: 2026-02-08 11:36:29
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/appbar/appbar_simple.dart';
import 'package:pinlink/constant/app_string.dart';

@RoutePage()
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSimple(title: AppString.about_us),
      body: const Center(child: Text('About Us')),
    );
  }
}
