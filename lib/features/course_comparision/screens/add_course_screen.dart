/*
 * @Author: Km Muzahid
 * @Date: 2026-02-28 09:24:52
 * @Email: km.muzahid@gmail.com
 */

import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/bloc/cubit_scope_value.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_state.dart';
import 'package:pinlink/features/course_comparision/cubit/add_course_cubit.dart';
import 'package:pinlink/features/course_comparision/cubit/add_course_state.dart';
import 'package:pinlink/features/course_comparision/model/course_model.dart';
import 'package:pinlink/features/course_comparision/widgets/already_added_course_dailoge_wiget.dart';

@RoutePage()
class AddCourseScreen extends StatelessWidget {
  const AddCourseScreen({
    super.key,
    this.enableSafeArea = true,
    this.isInNavigation = false,
  });
  final bool enableSafeArea;
  final bool isInNavigation;

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      appBar: isInNavigation
          ? null
          : CommonAppBar(
              disableBack: true,
              hideBack: true,
              appbarConfig: AppbarConfig(
                decoration: () =>
                    const BoxDecoration(color: Colors.transparent),
              ),
            ),
      body: CubitScopeValue(
        cubit: context.read<AddCourseCubit>()
          ..init()
          ..getAllCourses(isRefresh: true),
        builder: (context, cubit, state) {
          return Column(
            children: [
              if (!isInNavigation)
                CommonText(
                  text: 'Add Courses You\'ve Played',
                  fontSize: 24,
                  textColor: context.colors.tEXT_white,
                  fontWeight: FontWeight.w500,
                ),
              8.height,
              if (isInNavigation) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _sigmentedButton(
                    onTap: (value) {
                      cubit.setRankingType(value);
                    },
                    selectedTheme: state.rankingType,
                    context: context,
                  ),
                ),
              ],

              Flexible(
                child: SmartListLoader(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  onColapsAppbar: Container(
                    color: context.colors.background,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildHeader(context, state),
                  ),
                  appbar: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _appbar(context, state, cubit),
                  ),

                  itemCount: state.courses.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.selectedCourses.length) {
                      return _buildCourseCard(
                        context,
                        state.selectedCourses[index],
                        cubit,
                        isAdded: true,
                      );
                    }
                    if (index == state.selectedCourses.length) {
                      return CommonText(
                        text: 'Available Courses',
                        top: 16,
                        fontSize: 18,
                        textColor: context.colors.tEXT_white,
                      );
                    }
                    return _buildCourseCard(
                      context,
                      state.courses
                          .where(
                            (element) => !state.selectedCourses.any(
                              (e) => e.id == element.id,
                            ),
                          )
                          .toList()[index - state.selectedCourses.length - 1],
                      cubit,
                    );
                  },
                ),
              ),
              16.height,
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SafeArea(
                  top: false,
                  bottom: enableSafeArea,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, authState) {
                      final profile = authState.profile;
                      final existingCount =
                          state.rankingType == RankingType.courseRanking
                          ? (profile?.allCompareCourseCount ?? 0)
                          : (profile?.allWishlishCount ?? 0);

                      final canContinue =
                          state.selectedCourses.length >= 2 ||
                          (state.selectedCourses.length == 1 &&
                              existingCount >= 1);

                      return CommonButton(
                        borderColor: canContinue
                            ? context.colors.pRIMARY_priSoft
                            : context.colors.bACKGROUND_clickableBorder,
                        buttonColor: context.colors.background,
                        titleColor: canContinue
                            ? context.colors.tEXT_white
                            : context.colors.tEXT_white.withOpacity(0.5),
                        borderWidth: 2,
                        buttonWidth: double.infinity,
                        titleText: 'Continue to Course Ranking',
                        onTap: () {
                          if (canContinue) {
                            context.router.push(
                              ComparisonRoute(
                                cubit: cubit,
                                questinIndex: 0,
                                rankingType: state.rankingType,
                                isNaviagtion: isInNavigation,
                              ),
                            );
                          } else if (state.selectedCourses.isEmpty &&
                              state.courses.isEmpty) {
                            if (!isInNavigation) {
                              context.router.replace(const NavigationRoute());
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              if (enableSafeArea) 16.height,
              if (isInNavigation) 45.height,
            ],
          );
        },
      ),
    );
  }

  Widget _appbar(
    BuildContext context,
    AddCourseState state,
    AddCourseCubit cubit,
  ) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        final profile = authState.profile;
        final existingCount = state.rankingType == RankingType.courseRanking
            ? (profile?.allCompareCourseCount ?? 0)
            : (profile?.allWishlishCount ?? 0);

        final requiredCount = existingCount >= 1 ? 1 : 2;

        return Column(
          children: [
            CommonText(
              text:
                  "Add at least $requiredCount course${requiredCount > 1 ? 's' : ''} to continue",
              fontSize: 16,
              bottom: 20,
              textColor: context.colors.pRIMARY_priSoft,
              fontWeight: FontWeight.w400,
            ),
            CommonText(
              text: 'Added Courses (${state.selectedCourses.length})',
              bottom: 6,
              fontSize: 18,
              textColor: context.colors.tEXT_white,
            ).start,
            CommonText(
              text: 'Search Courses',
              fontSize: 14,
              textColor: context.colors.tEXT_white,
            ).start,
            4.height,
            CommonTextField(
              hintText: 'Search Courses',
              prefixIcon: Icon(Icons.search, color: context.colors.tEXT_sub),
              validationType: ValidationType.notRequired,
              borderRadius: 20,
              onChanged: (value) {
                cubit.searchCourse(query: value, isRefresh: true);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, AddCourseState state) {
    return Column(
      children: [
        CommonText(
          text: 'Added Courses (${state.selectedCourses.length})',
          bottom: 6,
          fontSize: 18,
          textColor: context.colors.tEXT_white,
        ).start,

        CommonTextField(
          hintText: 'Search Courses',
          prefixIcon: Icon(Icons.search, color: context.colors.tEXT_sub),
          validationType: ValidationType.notRequired,
          borderRadius: 20,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildCourseCard(
    BuildContext context,
    CourseModel course,
    AddCourseCubit cubit, {
    bool isAdded = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: context.colors.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.colors.bACKGROUND_darkCardBoarder,
          width: 1.4,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: context.colors.tEXT_white,
              ),
              Column(
                crossAxisAlignment: .start,
                children: [
                  CommonText(
                    text: course.name ?? '',
                    fontSize: 16,
                    left: 10,
                    textColor: context.colors.tEXT_white,
                    fontWeight: FontWeight.bold,
                  ).start,
                  CommonText(
                    text: course.locationName ?? '',
                    left: 10,
                    fontSize: 14,
                    textColor: context.colors.pRIMARY_priSoft,
                    fontWeight: FontWeight.w400,
                  ).start,
                ],
              ),
              const Spacer(),
              _actionButtion(
                isAdded,
                cubit,
                course,
                context,
                cubit.state.rankingType,
              ),
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector _actionButtion(
    bool isAdded,
    AddCourseCubit cubit,
    CourseModel course,
    BuildContext context,
    RankingType rankingType,
  ) {
    final isReRank =
        (rankingType == RankingType.courseRanking && course.isPlay == true) ||
        (rankingType == RankingType.wishlistRanking &&
            course.isWishlist == true);
    return GestureDetector(
      onTap: () {
        if (isAdded) {
          cubit.unselectCourse(course);
          return;
        }
        if (!isInNavigation) {
          cubit.selectCourse(course);
          return;
        }
        if (isReRank) {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: AlreadyAddedCourseDailogeWiget(
                rankingType: rankingType,
                cubit: cubit,
                course: course,
                onPostNewScore: () {
                  cubit.selectCourse(course);
                },
                onReRank: () {
                  cubit.selectCourse(course);
                },
              ),
            ),
          );
        } else {
          // showDialog(
          //   context: context,
          //   builder: (context) => Dialog(
          //     child: NewCourseDailogueWidget(
          //       cubit: cubit,
          //       onPostNewScore: () {
          cubit.selectCourse(course);
          //       },
          //     ),
          //   ),
          // );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          isAdded ? Icons.close : Icons.add,
          size: 24,
          color: isReRank && isInNavigation && !isAdded
              ? context.colors.ratingPremiumTags_goldAccent
              : context.colors.successVerifiedPositivestats_freshGrass,
        ),
      ),
    );
  }

  Widget _sigmentedButton({
    required Function(RankingType) onTap,
    required RankingType selectedTheme,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colors.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colors.bACKGROUND_darkCard,
          width: 1.2,
        ),
      ),

      child: Row(
        children: [
          _buildSegmentButton(
            rankingType: RankingType.courseRanking,
            selectedTheme: selectedTheme,
            onTap: onTap,
            context: context,
          ),
          _buildSegmentButton(
            rankingType: RankingType.wishlistRanking,
            selectedTheme: selectedTheme,
            onTap: onTap,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentButton({
    required RankingType rankingType,
    required RankingType selectedTheme,
    required Function(RankingType) onTap,
    required BuildContext context,
  }) {
    const radious = 8.0;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(rankingType),
        child: Container(
          decoration: BoxDecoration(
            color: selectedTheme == rankingType
                ? context.colors.bACKGROUND_darkPage
                : Colors.transparent,

            borderRadius: const BorderRadius.all(Radius.circular(radious)),
          ),
          child: Center(
            child: CommonText(
              left: 10,
              right: 10,
              top: 8,
              bottom: 8,
              preffix: Icon(
                rankingType == RankingType.courseRanking
                    ? Icons.golf_course_outlined
                    : Icons.favorite,
                size: 16,
                color: selectedTheme == rankingType
                    ? Colors.red
                    : context.colors.tEXT_white,
              ),
              text: rankingType.displayName,
              textColor: context.colors.tEXT_white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
