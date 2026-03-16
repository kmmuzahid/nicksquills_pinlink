import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/text_to_avater.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/course_comparision/model/course_model.dart';
import 'package:pinlink/features/golf_map/widgets/golf_primary_color.dart';

class GolfCoursePlayedItem extends StatelessWidget {
  const GolfCoursePlayedItem({
    super.key,
    required this.course,
    required this.index,
    required this.selectedFilter,
  });
  final CourseModel course;
  final int index;
  final MapFilters? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return _buildCourseCard(context, course, index);
  }

  Widget _buildCourseCard(BuildContext context, CourseModel course, int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: context.colors.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.bACKGROUND_darkCardBoarder, width: 1.4),
      ),
      child: Row(
        children: [
          TextToAvatar(text: (index + 1).toString(), color: getGolfPrimaryColor(selectedFilter)),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                CommonText(
                  text: course.name,
                  fontSize: 16,
                  left: 10,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  preventScaling: true,
                  textColor: context.colors.tEXT_white,
                  fontWeight: FontWeight.bold,
                ).start,
                CommonText(
                  text: course.address,
                  left: 10,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                  preventScaling: true,
                  textColor: context.colors.pRIMARY_priSoft,
                  fontWeight: FontWeight.w400,
                ).start,
                CommonText(
                  text: 'Played 2024-01-15',
                  left: 10,
                  fontSize: 12,
                  textColor: context.colors.tEXT_sub,
                  fontWeight: FontWeight.w400,
                ).start,
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 60,
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,

                scrollDirection: .horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisSize: .min,
                      children: [
                        5.height,
                        CommonRatingBar(
                          rating: 5,
                          size: 12,
                          spacing: 0,
                          color: index == 0 ? Colors.amber : context.colors.tEXT_sub,
                        ),
                        if (index == 0)
                          CommonText(
                            top: 5,
                            text: '5.0',
                            fontSize: 14,
                            fontWeight: .bold,
                            textColor: context.colors.tEXT_white,
                          ),
                        if (index != 0) ...[
                          5.height,
                          Icon(Icons.lock, color: context.colors.tEXT_sub, size: 14),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
