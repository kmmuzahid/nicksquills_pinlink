/*
 * @Author: Km Muzahid
 * @Date: 2026-02-08 11:05:36
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:core_kit/app_bar/common_app_bar.dart';
import 'package:core_kit/list_loader/smart_list_loader.dart';
import 'package:core_kit/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/app_string.dart';
import 'package:pinlink/coreFeature/faq/model/faq_model.dart';

@RoutePage()
class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: AppString.faq_help),
      body: SmartListLoader(
        onRefresh: () {},
        itemCount: 10,
        itemBuilder: (context, index) {
          return _faqBuilder(
            context,
            const FaqModel(
              question: 'What is ShareCharge?',
              answer:
                  'ShareCharge is a platform that allows you to share your electric vehicle charging station with other EV owners.',
            ),
          );
        },
      ),
    );
  }

  Widget _faqBuilder(BuildContext context, FaqModel faq) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Card(
          color: context.colors.bACKGROUND_darkCard,
          elevation: .5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: ExpansionTile(
            title: CommonText(
              text: faq.question,
              textAlign: TextAlign.left,
              maxLines: 4,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: 1, color: Colors.grey[300]),
              const SizedBox(height: 12),
              CommonText(
                text: faq.answer,
                maxLines: 20,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey[700], fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
