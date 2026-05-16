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
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/navigation/cubit/navigation_cubit.dart';
import 'package:pinlink/features/course_comparision/cubit/add_course_cubit.dart';
import 'package:pinlink/features/course_comparision/cubit/add_course_state.dart';
import 'package:pinlink/features/course_comparision/model/course_model.dart';
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
      cubit: cubit
        ..showCompareSet(
          isSelectedCourseRank: true,
          authCubit: context.read<AuthCubit>(),
        ),
      builder: (context, cubit, state) {
        // Dynamic question text from the cubit's 8-question list
        final questionText = state.comparison.isNotEmpty
            ? cubit.questions[state.currentQuestionIndex]
            : '';

        return SimpleBackground(
          appBar: CommonAppBar(
            disableBack: true,
            appbarConfig: AppbarConfig(
              decoration: () => const BoxDecoration(color: Colors.transparent),
              actions: [
                if (state.showSkip)
                  GestureDetector(
                    onTap: () {
                      appRouter.replace(
                        ComparisonRoute(
                          cubit: cubit,
                          questinIndex: questinIndex + 1,
                          rankingType: rankingType,
                        ),
                      );
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
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
                // ─── Dynamic question text with FADE animation ───
                SizedBox(
                  height: 80,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                    child: CommonText(
                      key: ValueKey(questionText),
                      text: questionText,
                      fontSize: 16,
                      maxLines: 3,
                      top: 8,
                      bottom: 4,
                      textColor: context.colors.pRIMARY_priSoft,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                // ─── Question progress indicator ───
                AnimatedOpacity(
                  opacity: state.comparison.isNotEmpty ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: CommonText(
                    text:
                        '${state.currentQuestionIndex + 1} / ${cubit.questions.length}',
                    fontSize: 13,
                    bottom: 10,
                    textColor: context.colors.tEXT_subDark,
                  ),
                ),
                Expanded(
                  child: SafeArea(
                    top: false,
                    bottom: true,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                      child: state.isComparisonLoading
                          ? Center(
                              key: const ValueKey('loader'),
                              child: CircularProgressIndicator(
                                color: context.colors.pRIMARY_priSoft,
                              ),
                            )
                          : state.comparison.isNotEmpty
                          ? _questions(state, context)
                          : const SizedBox.shrink(key: ValueKey('empty')),
                    ),
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
          ),
        );
      },
    );
  }

  Widget _questions(AddCourseState state, BuildContext context) {
    final comparison1 = state.comparison.first;
    final comparison2 = state.comparison.last;
    final matchupKey = "${comparison1.id}_${comparison2.id}";

    return Column(
      key: ValueKey(matchupKey),
      children: [
        Expanded(
          child: _AnimatedCourseCard(
            key: ValueKey("${comparison1.id}_0"),
            course: comparison1,
            onTap: () => _onTapAnswer(state, cubit, context, 0),
            delay: const Duration(milliseconds: 0),
            rankingType: rankingType,
          ),
        ),
        Expanded(
          child: _AnimatedCourseCard(
            key: ValueKey("${comparison2.id}_1"),
            course: comparison2,
            onTap: () => _onTapAnswer(state, cubit, context, 1),
            delay: const Duration(milliseconds: 100),
            rankingType: rankingType,
          ),
        ),
      ],
    );
  }

  void _onTapAnswer(
    AddCourseState state,
    AddCourseCubit cubit,
    BuildContext context,
    int index,
  ) {
    cubit.onSelectComparisonCourse(index, () {
      if (!isNaviagtion) {
        appRouter.replaceAll([const NavigationRoute()]);
      } else {
        appRouter.popUntil((r) => r.settings.name == NavigationRoute.name);
      }
      context.read<NavigationCubit>().changeIndex(
        4,
        filter: rankingType == RankingType.courseRanking
            ? .MyCourses
            : .MyWishlist,
      );
    }, context.read<AuthCubit>());
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

class _AnimatedCourseCard extends StatefulWidget {
  final CourseModel course;
  final VoidCallback onTap;
  final Duration delay;
  final RankingType rankingType;

  const _AnimatedCourseCard({
    required super.key,
    required this.course,
    required this.onTap,
    required this.delay,
    required this.rankingType,
  });

  @override
  State<_AnimatedCourseCard> createState() => _AnimatedCourseCardState();
}

class _AnimatedCourseCardState extends State<_AnimatedCourseCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isTapped = true),
        onTapUp: (_) => setState(() => _isTapped = false),
        onTapCancel: () => setState(() => _isTapped = false),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: Matrix4.identity()..scale(_isTapped ? 0.98 : 1.0),
          margin: EdgeInsets.only(
            bottom: widget.rankingType == RankingType.wishlistRanking ? 4 : 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: context.colors.bACKGROUND_darkCard,
            border: Border.all(
              color: _isTapped
                  ? context.colors.pRIMARY_priSoft
                  : context.colors.bACKGROUND_darkCardBoarder,
              width: 1.4,
            ),
            boxShadow: [
              if (_isTapped)
                BoxShadow(
                  color: context.colors.pRIMARY_priSoft.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: CommonImage(
                  src: widget.course.image ?? '',
                  borderRadiusCustom: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  fill: .fill,
                ),
              ),
              4.height,
              CommonText(
                text: widget.course.name ?? '',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                textColor: context.colors.tEXT_white,
              ).center,
              CommonText(
                text: widget.course.locationName ?? '',
                fontSize: 16,
                textColor: context.colors.tEXT_subDark,
              ).center,
              4.height,
            ],
          ),
        ),
      ),
    );
  }
}
