/*
 * @Author: Km Muzahid
 * @Date: 2026-02-28 09:24:52
 * @Email: km.muzahid@gmail.com
 */

import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/features/course_comparision/cubit/add_course_cubit.dart';
import 'package:pinlink/features/course_comparision/model/course_model.dart';
import 'package:pinlink/features/course_comparision/widgets/already_added_course_dailoge_wiget.dart';
import 'package:pinlink/features/course_comparision/widgets/new_course_dailoge_widgets.dart';

@RoutePage()
class AddCourseScreen extends StatelessWidget {
  const AddCourseScreen({super.key, this.enableSafeArea = true});
  final bool enableSafeArea;

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      appBar: const CommonAppBar(disableBack: true, hideBack: true),
      body: CubitScope(
        create: () => AddCourseCubit()..init(),
        builder: (context, cubit, state) {
          return Column(
            children: [
              CommonText(
                text: 'Add Courses You\'ve Played',
                fontSize: 24,
                textColor: context.colors.tEXT_white,
                fontWeight: FontWeight.w500,
              ),
              8.height,
              CommonText(
                text: 'Add at least 2 courses to continue',
                fontSize: 16,
                textColor: context.colors.pRIMARY_priSoft,
                fontWeight: FontWeight.w400,
              ),
              8.height,

              Flexible(
                child: SmartListLoader(
                  padding: const EdgeInsets.symmetric(horizontal: 16),

                  itemCount: state.courses.length + state.selectedCourses.length + 3,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return CommonText(
                        text: 'Added Courses (${state.selectedCourses.length})',
                        bottom: 6,
                        fontSize: 18,
                        textColor: context.colors.tEXT_white,
                      );
                    }

                    if (index == 1) {
                      return _buildHeader(context);
                    }

                    if (index < state.selectedCourses.length + 2 && index > 1) {
                      return _buildCourseCard(
                        context,
                        state.selectedCourses[index - 2],
                        cubit,
                        isAdded: true,
                      );
                    }
                    if (index == state.selectedCourses.length + 2) {
                      return CommonText(
                        text: 'Available Courses',
                        top: 16,
                        fontSize: 18,
                        textColor: context.colors.tEXT_white,
                      );
                    }
                    return _buildCourseCard(
                      context,
                      state.courses[index - state.selectedCourses.length - 3],
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
                  child: CommonButton(
                    borderColor: context.colors.bACKGROUND_clickableBorder,
                    buttonColor: context.colors.background,
                    titleColor: context.colors.tEXT_white,
                    borderWidth: 2,
                    buttonWidth: double.infinity,
                    titleText: 'Continue to Course Rnaking',
                    onTap: () {
                      if (state.comparison.isNotEmpty) {
                        context.router.push(ComparisonRoute(cubit: cubit, questinIndex: 0));
                      }
                    },
                  ),
                ),
              ),
              if (enableSafeArea)
              16.height,
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
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
        border: Border.all(color: context.colors.bACKGROUND_darkCardBoarder, width: 1.4),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.location_on_outlined, color: context.colors.tEXT_white),
              Column(
                crossAxisAlignment: .start,
                children: [
                  CommonText(
                    text: course.name,
                    fontSize: 16,
                    left: 10,
                    textColor: context.colors.tEXT_white,
                    fontWeight: FontWeight.bold,
                  ).start,
                  CommonText(
                    text: course.address,
                    left: 10,
                    fontSize: 14,
                    textColor: context.colors.pRIMARY_priSoft,
                    fontWeight: FontWeight.w400,
                  ).start,
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  if (isAdded) {
                    cubit.unselectCourse(course);
                    return;
                  }
                  if (course.isAlreadyPlayed) {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: AlreadyAddedCourseDailogeWiget(
                          cubit: cubit,
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
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: NewCourseDailogueWidget(
                          cubit: cubit,
                          onPostNewScore: () {
                            cubit.selectCourse(course);
                          },
                        ),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    isAdded ? Icons.close : Icons.add,
                    size: 24,
                    color: course.isAlreadyPlayed && !isAdded
                        ? context.colors.ratingPremiumTags_goldAccent
                        : context.colors.successVerifiedPositivestats_freshGrass,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
