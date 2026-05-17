import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/golf_map/widgets/golf_primary_color.dart';
import 'package:pinlink/features/golf_map/widgets/map_points_details.dart';
import 'package:pinlink/features/golf_map/widgets/map_points_details_wishlish.dart';
import 'package:pinlink/gen/assets.gen.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key, required this.selectedFilter});
  final MapFilters? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: CommonImage(src: Assets.images.mapSample.path)),
        if (selectedFilter == MapFilters.Wishlist)
          const Positioned(
            left: 10,
            top: 10,
            child: MapPointsDetailsWishlish(),
          ),
        if (selectedFilter != MapFilters.Wishlist)
          const Positioned(
            left: 30,
            top: 30,
            child: MapPointsDetails(courseId: ''),
          ),
        marker(context),

        Positioned(
          right: 10,
          bottom: 10,
          child: _totalCourses(context, getGolfPrimaryColor(selectedFilter)),
        ),
      ],
    );
  }

  Widget marker(BuildContext context) {
    final color = getGolfPrimaryColor(selectedFilter);
    return Positioned(
      left: 30,
      bottom: 75.h,
      child: CommonImage(
        src: Assets.images.marker,
        width: 24.w,
        height: 35.h,
        imageColor: color,
      ),
    );
  }

  Widget _totalCourses(BuildContext context, Color color) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: .4), width: 1.5),
      ),
      child: Column(
        children: [
          CommonText(
            text: '5',
            fontSize: 24,
            fontWeight: .w700,
            textColor: color,
          ),
          CommonText(
            text: 'Courses',
            fontSize: 14,
            fontWeight: .w400,
            textColor: color,
          ),
        ],
      ),
    );
  }
}
