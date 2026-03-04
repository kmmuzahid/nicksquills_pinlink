/*
 * @Author: Km Muzahid
 * @Date: 2026-03-04 08:35:35
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/gen/assets.gen.dart';

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
        itemBuilder: (context, index) => _item(),
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
        raffle(context),
        10.height,
      ],
    );
  }

  Stack _item() {
    return Stack(
      children: [
        Positioned.fill(child: CommonImage(src: Constants.sampleImage, borderRadius: 16)),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            color: Colors.black.withValues(alpha: 0.05),
            child: CommonPopupMenu(
              showIconTrigger: true,
              showTextTrigger: false,
              primaryColor: Colors.white,
              onPrimaryColor: Colors.white,
              menuTextStyle: const TextStyle(color: Colors.black),
              items: const ['Report User', 'Report Post'],
              onItemSelected: (value) {},
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.black.withValues(alpha: 0.05),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: const CommonText(
              text: 'Amazing weather today! Course was in perfect condition.',
              maxLines: 3,
              textAlign: .left,
              fontSize: 14,
              fontWeight: .w500,
              textColor: Colors.white,
              autoResize: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget raffle(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: .centerLeft,
          end: .centerRight,
          colors: [Color(0xff2F80ED), Color(0xff2668C1), Color(0xff1B4987)],
        ),
        border: Border.all(color: context.colors.bACKGROUND_darkCardBoarder),
        borderRadius: BorderRadius.circular(16.r),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CommonImage(src: Assets.images.raffleIcon),
          10.width,
          Column(
            crossAxisAlignment: .start,
            children: [
              const CommonText(
                text: 'Enter Raffle to Win Free Clubs and Prizes!',
                textColor: Colors.white,
                fontSize: 14,
                fontWeight: .bold,
              ),
              CommonText(
                text: 'Win free golf rounds ⚡',
                textColor: Colors.white,
                fontSize: 13,
                maxLines: 2,
                borderRadious: 15,
                borderColor: Colors.transparent,
                backgroundColor: Colors.white.withOpacity(0.2),
                fontWeight: .w600,
                top: 5,
                left: 12,
                bottom: 5,
                right: 12,
              ),
            ],
          ),
        ],
      ),
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
              Transform.scale(
                scaleX: 1.2,
                scaleY: .9,
                child: Switch(
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
