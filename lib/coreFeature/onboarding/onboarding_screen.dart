/*
 * @Author: Km Muzahid
 * @Date: 2026-01-08 10:38:30
 * @Email: km.muzahid@gmail.com
 */

import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/app_string.dart' show AppString;
import 'package:pinlink/gen/assets.gen.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> { 
  bool showPages = false;
  List<Map<String, String>> pages = [
    {
      'title': 'Play. Compare. Discover.',
      'subtitle':
          'Track the golf courses you’ve played, explore new ones, and share your journey with friends.',
      'image': Assets.images.oboarding1.path,
    },
    {
      'title': 'Rate by Comparison.',
      'subtitle': 'Simply choose which course you liked more — we’ll do the rest.',
      'image': Assets.images.oboarding2.path,
    },
    {
      'title': 'Your Golf World on the Map',
      'subtitle': 'See played courses, wishlist spots, and friends’ journeys — all in one map.',
      'image': Assets.images.onboarding3.path,
    },
    {
      'title': 'Compete, Connect, and Climb the Leaderboard',
      'subtitle': 'Travel farther, play better courses, and rise among fellow golfers.',
      'image': Assets.images.onboarding4.path,
    },
  ];

  late PageController pageController;

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    pageController.addListener(() {
      setState(() {
        pageIndex = pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(

   
      body: SizedBox(height: double.infinity, width: double.infinity, child: _page()),
    );
  }

  Widget _pageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pages.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: pageIndex == index ? 24 : 10,
          height: 10,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1.5),
            borderRadius: BorderRadius.circular(15),
            color: pageIndex == index ? ThemeColor.dark.pRIMARY_brandClr : Colors.white,
          ),
        );
      }),
    );
  }

  Widget _page() {
    return Stack(
      children: [
        Positioned.fill(
          child: PageView.builder(
            controller: pageController,
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return CommonImage(src: pages[index]['image']!, fill: BoxFit.fill);
            },
          ),
        ),

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: CommonAppBar(
            hideBack: true,
            disableBack: true,
            appbarConfig: AppbarConfig(backgroundColor: Colors.transparent),
          ),
        ),
        Align(
          alignment: .bottomEnd,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                80.height,
                const Spacer(),
                CommonImage(src: Assets.images.globe.path, height: 117, width: 86),
                20.height,
                CommonText(
                  text: pages[pageIndex]['title']!,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  textColor: ThemeColor.dark.tEXT_white,
                  maxLines: 2,
                ),
                4.height,
                CommonText(
                  text: pages[pageIndex]['subtitle']!,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textColor: ThemeColor.dark.bACKGROUND_clickableBorder,
                  maxLines: 3,
                ),
                const Spacer(),
                _pageIndicator(),
                100.height,

                CommonButton(
                  onTap: () {
                    if (pageController.page == pages.length - 1) {
                      appRouter.replace(const LoginRoute());
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                  suffix: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CommonImage(src: Assets.images.onBoardingNextButtonPrefix),
                    ),
                  ),

                  titleText: pageIndex == pages.length - 1 ? AppString.letsStart : 'Next',
                ),
                200.height,
              ],
            ),
          ),
        )
      ],
    );
  }
}
