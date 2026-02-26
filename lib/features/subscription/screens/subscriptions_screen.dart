/*
 * @Author: Km Muzahid
 * @Date: 2026-02-25 13:41:32
 * @Email: km.muzahid@gmail.com
 */
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/subscriptions.dart';

@RoutePage()
class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key, this.isBackDisabled = false});
  final bool isBackDisabled;

  @override
  Widget build(BuildContext context) {
    File('assets/images/subscription.png');
    return SimpleBackground(
      appBar: CommonAppBar(
        // hideBack: isBackDisabled,
        // disableBack: isBackDisabled,
        title: 'hello',

        appbarConfig: AppbarConfig(backgroundColor: Colors.transparent),
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
    return Container(
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
                mainAxisAlignment: .start,
                children: [
                  CommonText(
                    text: plan.name,
                    fontSize: 20,
                    textColor: context.colors.tEXT_white,
                    fontWeight: FontWeight.bold,
                  ),
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
         
        ],
      ),
    );
  }
}
