/*
 * @Author: Km Muzahid
 * @Date: 2026-01-08 10:38:30
 * @Email: km.muzahid@gmail.com
 */

import 'package:auto_route/auto_route.dart';
import 'package:core_kit/app_bar/common_app_bar.dart';
import 'package:core_kit/button/common_button.dart';
import 'package:core_kit/image/common_image.dart' show CommonImage;
import 'package:core_kit/utils/core_screen_utils.dart';
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
      'title': AppString.welcome_to_sharecharge,
      'subtitle': AppString.find_ev_charging_points_and_rental_parking_spaces_easily,
      'image': Assets.images.onboarding1.path,
    },
    {
      'title': AppString.search_book_charging_points,
      'subtitle': AppString.quickly_find_nearby_charging_stations_and_reserve_your_spot_directly,
      'image': Assets.images.onboarding2.path,
    },
    {
      'title': AppString.rent_your_parking_space,
      'subtitle': AppString.earn_money_with_your_parking_spaces_by_offering_ev_charging,
      'image': Assets.images.onboarding3.path,
    },
    {
      'title': AppString.rent_your_parking_space,
      'subtitle': AppString.earn_money_with_your_parking_spaces_by_offering_ev_charging,
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
            color: pageIndex == index ? AppColor.primary : Colors.white,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
        )
      ],
    );
  }
}
