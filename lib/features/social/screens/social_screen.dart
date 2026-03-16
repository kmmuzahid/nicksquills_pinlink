/*
 * @Author: Km Muzahid
 * @Date: 2026-03-04 08:35:35
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/social_item_widget.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SmartStaggeredLoader(
        topWidget: _topWidget(context),
        aspectRatio: 0.65,
        itemCount: 20,
        onRefresh: () {},
        onLoadMore: (page) {},
        limit: 20,
        itemBuilder: (context, index) => const SocialItemWidget(),
      ),
    );
  }

  Column _topWidget(BuildContext context) {
    return Column(
      children: [
        18.height,
        CommonText(
          text: 'See what your friends are playing and sharing',
          fontSize: 16,
          textColor: context.colors.tEXT_subDark,
          maxLines: 2,
        ).center,
        18.height,
        consentCard(context),
        10.height,
        CommonButton(
          titleText: 'Create Post',
          prefix: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: Colors.white, width: 1.4.r),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          onTap: () {
            appRouter.push(const CreatePostRoute());
          },
        ).end, 
        10.height,
      ],
    );
  }

 

  Widget consentCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.bACKGROUND_darkCard,
        border: Border.all(color: context.colors.bACKGROUND_darkCardBoarder),
        borderRadius: BorderRadius.circular(16.r),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CommonText(
            text: 'Golf-Only Content',
            textColor: context.colors.tEXT_white,
            fontSize: 14,
            fontWeight: .bold,
          ).start,
          10.height,
          CommonText(
            text:
                'Posts are moderated to keep the feed focused on golf experiences, courses, and scores.',
            fontSize: 13,
            textColor: context.colors.tEXT_subDark,
            maxLines: 5,
            textAlign: .left,
          ).start,
          15.height,
          Row(
            children: [
              CommonText(
                text: 'Profanity Filter',
                fontSize: 14,
                textColor: context.colors.tEXT_white,
              ),
              const Spacer(),
              Switch(
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xFF2F6F57),
                inactiveThumbColor: Colors.grey.shade400,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                inactiveTrackColor: Colors.grey.shade200,
                trackOutlineWidth: const WidgetStatePropertyAll(0),
                trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
                value: true,
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
