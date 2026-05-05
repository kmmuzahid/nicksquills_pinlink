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
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/coreFeature/terms/cubit/policy_cubit.dart';
import 'package:pinlink/coreFeature/terms/cubit/policy_state.dart';

@RoutePage()
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      appBar: const CommonAppBar(title: "Privacy Policy"),
      body: CubitScope<PolicyCubit, PolicyState>(
        create: () => PolicyCubit()..fetchPolicy(),
        builder: (context, cubit, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
            alignment: Alignment.topLeft,
            child: CommonText(
              text: state.privacyPolicy,
              left: 16,
              right: 16,
              fontWeight: FontWeight.bold,
              isDescription: true,
            ),
          );
        },
      ),
    );
  }
}
