/*
 * @Author: Km Muzahid
 * @Date: 2026-02-25 13:41:32
 * @Email: km.muzahid@gmail.com
 */
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/subscriptions.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';

@RoutePage()
class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key, this.isBackDisabled = false, this.isNavPage = false});
  final bool isBackDisabled;
  final bool isNavPage;

  @override
  Widget build(BuildContext context) {
    File('assets/images/subscription.png');
    return SimpleBackground(
      appBar: isNavPage
          ? null
          : CommonAppBar(
        hideBack: isBackDisabled,
              disableBack: isBackDisabled, 
              appbarConfig: AppbarConfig(
                decoration: () => const BoxDecoration(color: Colors.transparent),
              ),
      ),
      body: Column(
        children: [
          CommonText(
            text: 'Choose Your Plan',
            fontSize: 24,
            textColor: context.colors.tEXT_white,
            fontWeight: FontWeight.w500,
          ),
          18.height,
          CommonText(
            text: 'Select the plan that fits your golf journey',
            fontSize: 16,
            textColor: context.colors.pRIMARY_priSoft,
            fontWeight: FontWeight.w400,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  subscriptionCard(context: context, plan: freePlan),
                  subscriptionCard(context: context, plan: clubPlan),
                  subscriptionCard(context: context, plan: creatorPlan),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget subscriptionCard({required BuildContext context, required Plan plan}) {
    return GestureDetector(
      onTap: () {
        context.read<AuthCubit>().updateSubscriptionPlan(plan);
        if (isBackDisabled) {
          appRouter.replaceAll([AddCourseRoute()]);
        } else {
          appRouter.pop();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: context.colors.bACKGROUND_darkCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.colors.bACKGROUND_darkCardBoarder, width: 1.4),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: context.colors.background,
                  ),
                  child: Icon(Icons.electric_bolt_sharp, color: context.colors.tEXT_white),
                ),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    CommonText(
                      text: plan.name,
                      fontSize: 20,
                      left: 10,
                      textColor: context.colors.tEXT_white,
                      fontWeight: FontWeight.bold,
                    ).start,
                    CommonText(
                      text: plan.subtitle,
                      left: 10,
                      fontSize: 16,
                      textColor: context.colors.pRIMARY_priSoft,
                      fontWeight: FontWeight.w400,
                    ).start,
                  ],
                ),
              ],
            ),

            Row(
              children: [
                CommonText(
                  text: '\$${plan.price}',
                  left: 10,
                  fontSize: 36,
                  top: 10,
                  bottom: 10,
                  textColor: context.colors.tEXT_white,
                  fontWeight: FontWeight.bold,
                ).start,
                CommonText(
                  text: '/${plan.durationTitle}',
                  left: 10,
                  fontSize: 12,
                  top: 10,
                  bottom: 10,
                  textColor: context.colors.tEXT_subDark,
                ),
              ],
            ),
            ...plan.featureTitles.map((e) => _buildFeatureText(e, context)),
            if (plan.extraFeatures.isNotEmpty)
              Divider(color: context.colors.bACKGROUND_darkCardBoarder),
            if (plan.extraFeatures.isNotEmpty)
              ...plan.extraFeatures.map((e) => _buildFeatureText(e, context, isExtra: true)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureText(String text, BuildContext context, {bool isExtra = false}) {
    return Row(
      children: [
        10.width,
        if (!isExtra) ...[
          Icon(Icons.check, size: 21, color: context.colors.pRIMARY_priSoft),
          10.width,
        ],
        Expanded(
          child: CommonText(
            text: '${isExtra ? '* ' : ''}$text',
            fontSize: 14,
            bottom: 8,
            textColor: isExtra ? context.colors.pRIMARY_priSoft : context.colors.tEXT_white,
            fontWeight: FontWeight.w400,
          ).start,
        ),
      ],
    );
  }
}
