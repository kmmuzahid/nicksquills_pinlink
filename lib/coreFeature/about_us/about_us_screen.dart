/*
 * @Author: Km Muzahid
 * @Date: 2026-02-08 11:36:29
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/constant/app_string.dart';
import 'package:pinlink/coreFeature/about_us/cubit/about_us.dart';

@RoutePage()
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: AppString.about_us),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CubitScope(
          create: () => AboutUsCubit()..getAboutUs(),
          builder: (context, cubit, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return CommonText(text: state.message ?? '', isDescription: true);
          },
        ),
      ),
    );
  }
}
