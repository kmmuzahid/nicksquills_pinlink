import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/custom_card.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/coreFeature/custom_google_map/model/business_model/map_point_model.dart';
import 'package:pinlink/features/profile/model/user_course_model.dart';
import 'package:pinlink/features/profile/screens/profile_screen.dart';

class MapPointsDetailsWishlish extends StatelessWidget {
  const MapPointsDetailsWishlish({
    super.key,
    required this.name,
    required this.address,
    required this.courseId,
    required this.mapPointModel,
  });
  final String name;
  final String address;
  final String courseId;
  final MapPointModel mapPointModel;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xffFB2C36).withValues(alpha: 0.3),
            ),
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.favorite,
              color: Color(0xffFB2C36),
              size: 20,
            ),
          ),
          10.width,

          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: name,
                  fontSize: 14,
                  fontWeight: .bold,
                  textColor: context.colors.tEXT_white,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                CommonText(
                  text: address,
                  fontSize: 12,
                  textColor: context.colors.tEXT_sub,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          10.width,

          CommonButton(
            titleText: 'Mark Played',
            titleColor: const Color(0xff10B981),
            buttonHeight: 40,
            onTap: () {
              showReRankDailoge(
                context,
                isPinlin5: mapPointModel.isPinkLink5 ?? false,
                course: UserCourseModel(
                  id: mapPointModel.id ?? '',
                  courseId: Course(
                    name: name,
                    locationName: address,
                    id: courseId,
                  ),
                ),
              );
            },
            padding: const EdgeInsets.symmetric(horizontal: 10),
            buttonRadius: 30,
            buttonColor: const Color(0xff10B981).withValues(alpha: 0.1),
          ),
        ],
      ),
    );
  }
}
