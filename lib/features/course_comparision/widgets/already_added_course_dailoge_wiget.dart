/*
 * @Author: Km Muzahid
 * @Date: 2026-02-28 12:11:58
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/features/course_comparision/cubit/add_course_cubit.dart';
import 'package:pinlink/features/course_comparision/widgets/new_course_dailoge_widgets.dart';

class AlreadyAddedCourseDailogeWiget extends StatelessWidget {
  const AlreadyAddedCourseDailogeWiget({
    super.key,
    required this.cubit,
    required this.onReRank,
    required this.onPostNewScore,
  });

  final AddCourseCubit cubit;
  final Function onReRank;
  final Function onPostNewScore;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close, color: context.colors.tEXT_subDark),
          ).end,
          CommonText(
            text: 'You’ve already ranked this course.',
            fontSize: 24,
            maxLines: 2,
            textAlign: TextAlign.center,
            textColor: context.colors.tEXT_white,
            fontWeight: FontWeight.w500,
          ),
          16.height,
          CommonText(
            text: 'You’ve previously played and ranked this course. What would you like to do?',
            fontSize: 14,
            maxLines: 5,
            textAlign: TextAlign.center,
            textColor: context.colors.tEXT_sub,
            fontWeight: FontWeight.w500,
          ),
          50.height,

          Row(
            children: [
              Expanded(
                child: CommonButton(
                  buttonWidth: .infinity,
                  titleText: 'Post New Score',
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: NewCourseDailogueWidget(
                          cubit: cubit,
                          onPostNewScore: onPostNewScore,
                        ),
                      ),
                    );
                  },
                ),
              ),
              10.width,
              Expanded(
                child: CommonButton(
                  titleColor: context.colors.tEXT_dark,
                  buttonColor: context.colors.ratingPremiumTags_goldAccent,
                  buttonWidth: .infinity,
                  titleText: 'Re-rank',
                  onTap: () {
                    Navigator.pop(context);
                    onReRank();
                  },
                ),
              ),
              20.height,
            ],
          ),
        ],
      ),
    );
  }
}
