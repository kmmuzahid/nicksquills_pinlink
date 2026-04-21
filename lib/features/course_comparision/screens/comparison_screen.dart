/*
 * @Author: Km Muzahid
 * @Date: 2026-02-28 12:50:40
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/bloc/cubit_scope_value.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/coreFeature/navigation/cubit/navigation_cubit.dart';
import 'package:pinlink/features/course_comparision/cubit/add_course_cubit.dart';
import 'package:pinlink/features/course_comparision/cubit/add_course_state.dart';
import 'package:pinlink/features/course_comparision/model/comparison_model.dart';
import 'package:pinlink/gen/assets.gen.dart';

@RoutePage()
class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({
    super.key,
    required this.cubit,
    required this.questinIndex,
    required this.rankingType,
    this.isNaviagtion = false,
  });
  final AddCourseCubit cubit;
  final int questinIndex;
  final RankingType rankingType;
  final bool isNaviagtion;

  @override
  Widget build(BuildContext context) {
    return CubitScopeValue(
      cubit: cubit,
      builder: (context, cubit, state) {
        return SimpleBackground(
          appBar: CommonAppBar(
            disableBack: true,
            appbarConfig: AppbarConfig(
              decoration: () => const BoxDecoration(color: Colors.transparent),
              actions: [
                if (rankingType == RankingType.wishlistRanking &&
                    questinIndex < state.comparison.length - 1)
                  GestureDetector(
                    onTap: () {
                      if (questinIndex < state.comparison.length - 1) {
                        appRouter.replace(
                          ComparisonRoute(
                            cubit: cubit,
                            questinIndex: questinIndex + 1,
                            rankingType: rankingType,
                          ),
                        );
                      } else if (questinIndex == state.comparison.length - 1) {
                        _goToWishList(cubit);
                      }
                    },
                    child: _skipButton(context),
                  ),
              ],
            ),
            onBackPress: () {
              if (questinIndex > 0) {
                appRouter.replace(
                  ComparisonRoute(
                    cubit: cubit,
                    questinIndex: questinIndex - 1,
                    rankingType: rankingType,
                  ),
                );
              } else if (questinIndex == 0) {
                appRouter.pop();
              }
            },
          ),
          body: Column(
            children: [
              // 20.height,
              _flagIcon(context),
              CommonText(
                text: rankingType == RankingType.courseRanking
                    ? 'Build Your Course Rankings'
                    : 'Rank Your Wishlist',
                fontSize: 24,
                top: 10,
                textColor: context.colors.tEXT_white,
                fontWeight: FontWeight.w500,
              ),
              CommonText(
                text: state.comparison[questinIndex].question,
                fontSize: 16,
                maxLines: 3,
                top: 8,
                bottom: 10,
                textColor: context.colors.pRIMARY_priSoft,
                fontWeight: FontWeight.w500,
              ),
              Expanded(
                child: SafeArea(
                  top: false,
                  bottom: true,
                  child: _questions(state, context),
                ),
              ),
              if (rankingType == RankingType.wishlistRanking)
                SafeArea(
                  top: false,
                  bottom: true,
                  child: Column(
                    children: [
                      4.height,
                      CommonText(
                        text:
                            'This takes just a second and improves your recommendations.',
                        fontSize: 12,
                        textColor: context.colors.tEXT_subDark,
                      ).center,
                      10.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64),
                        child: CommonButton(
                          buttonWidth: .infinity,
                          titleText: 'Skip the wishlist at this time',
                          buttonColor: Colors.transparent,
                          buttonRadius: 40,
                          borderColor:
                              context.colors.bACKGROUND_darkCardBoarder,
                          titleColor: context.colors.tEXT_white,
                          suffix: Icon(
                            Icons.arrow_forward,
                            color: context.colors.tEXT_white,
                            size: 15,
                          ),
                          onTap: () {
                            appRouter.replaceAll([const NavigationRoute()]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _questions(AddCourseState state, BuildContext context) {
    final comparison1 = state.comparison[questinIndex].options[0];
    final comparison2 = state.comparison[questinIndex].options[1];
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              _onTapAnswer(state, cubit, context);
            },
            child: _answerBuilder(context, comparison1),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              _onTapAnswer(state, cubit, context);
            },
            child: _answerBuilder(context, comparison2),
          ),
        ),
      ],
    );
  }

  void _onTapAnswer(
    AddCourseState state,
    AddCourseCubit cubit,
    BuildContext context,
  ) {
    if ((questinIndex < state.comparison.length - 1) &&
        rankingType == RankingType.courseRanking) {
      appRouter.replace(
        ComparisonRoute(
          cubit: cubit,
          questinIndex: questinIndex + 1,
          rankingType: rankingType,
        ),
      );
    } else if (rankingType == RankingType.wishlistRanking &&
        questinIndex < state.comparison.length) {
      _goToWishList(cubit);
    } else {
      if (!isNaviagtion) appRouter.replaceAll([const NavigationRoute()]);
      context.read<NavigationCubit>().changeIndex(
        4,
        filter: rankingType == RankingType.courseRanking
            ? .MyCourses
            : .MyWishlist,
      );
    }
  }

  void _goToWishList(AddCourseCubit cubit) {
    appRouter.replace(
      ComparisonRoute(
        cubit: cubit,
        questinIndex: questinIndex,
        rankingType: rankingType,
      ),
    );
  }

  Container _skipButton(BuildContext context) {
    return Container(
      height: 32,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: context.colors.bACKGROUND_darkCard,
        border: Border.all(
          color: context.colors.bACKGROUND_darkCardBoarder,
          width: 1.4,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          CommonText(
            text: 'Skip',
            fontSize: 16,
            textColor: context.colors.tEXT_white,
          ),
          4.width,
          Icon(Icons.arrow_forward, color: context.colors.tEXT_white, size: 15),
        ],
      ),
    );
  }

  AspectRatio _answerBuilder(
    BuildContext context,
    ComparisonOptionModel comparison,
  ) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: context.colors.bACKGROUND_darkCard,
          border: Border.all(
            color: context.colors.bACKGROUND_darkCardBoarder,
            width: 1.4,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: CommonImage(
                    // width: constraints.maxWidth,
                    src: comparison.image,
                    borderRadiusCustom: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    fill: .fill,
                  ),
                ),
                10.height,
                CommonText(
                  text: comparison.title,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  textColor: context.colors.tEXT_white,
                ).center,
                CommonText(
                  text: comparison.address,
                  fontSize: 16,
                  textColor: context.colors.tEXT_subDark,
                ).center,
                10.height,
              ],
            );
          },
        ),
      ),
    );
  }

  Container _flagIcon(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: rankingType == RankingType.courseRanking
              ? context.colors.bACKGROUND_darkCardBoarder
              : Colors.red,
          width: 1,
        ),
        color: rankingType == RankingType.courseRanking
            ? context.colors.bACKGROUND_darkCard
            : Colors.red.withOpacity(.3),
        boxShadow: [
          if (rankingType == RankingType.courseRanking)
            BoxShadow(
              offset: const Offset(0, 2),
              color: context.colors.pRIMARY_priLight,
              spreadRadius: 3,
              blurRadius: 3,
            ),
        ],
      ),
      child: rankingType == RankingType.courseRanking
          ? CommonImage(
              src: Assets.navigators.addCourse,
              fill: .contain,
              imageColor: context.colors.tEXT_white,
            )
          : const Icon(Icons.favorite, color: Colors.red, size: 38),
    );
  }
}
