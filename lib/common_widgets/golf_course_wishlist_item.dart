import 'package:core_kit/button/common_button.dart';
import 'package:core_kit/text/common_text.dart';
import 'package:core_kit/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/text_to_avater.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/profile/model/user_course_model.dart';

class GolfCourseWishListItem extends StatelessWidget {
  const GolfCourseWishListItem({
    super.key,
    required this.course,
    required this.index,
    required this.selectedFilter,
    required this.fixedWidth,
    required this.onMarkPlayed,
  });
  final UserCourseModel course;
  final int index;
  final MapFilters? selectedFilter;
  final double fixedWidth;
  final VoidCallback? onMarkPlayed;

  @override
  Widget build(BuildContext context) {
    return _buildCourseCard(context, course, index);
  }

  Widget _buildCourseCard(
    BuildContext context,
    UserCourseModel course,
    int index,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: context.colors.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.colors.bACKGROUND_darkCardBoarder,
          width: 1.4,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: fixedWidth,
            child: Row(
              children: [
                TextToAvatar(
                  size: 35,
                  text: (index + 1).toString(),
                  color: Colors.red,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: course.courseId?.name ?? '',
                        fontSize: 16,
                        left: 10,
                        textColor: context.colors.tEXT_white,
                        fontWeight: FontWeight.bold,
                      ).start,
                      CommonText(
                        text: course.courseId?.locationName ?? '',
                        left: 10,
                        fontSize: 14,
                        textColor: context.colors.pRIMARY_priSoft,
                        fontWeight: FontWeight.w400,
                      ).start,
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          CommonButton(
            titleText: 'Mark Played',
            onTap: onMarkPlayed,
            titleColor: const Color(0xff10B981),
            buttonHeight: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            buttonRadius: 30,
            buttonColor: const Color(0xff10B981).withValues(alpha: 0.1),
          ),
        ],
      ),
    );
  }
}
