import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/golf_map/widgets/golf_primary_color.dart';
import 'package:pinlink/features/golf_map/widgets/map_points_details.dart';
import 'package:pinlink/features/golf_map/widgets/map_points_details_wishlish.dart';
import 'package:pinlink/gen/assets.gen.dart';

@RoutePage()
class GolfMapViewScreen extends StatelessWidget {
  const GolfMapViewScreen({super.key, required this.selectedFilter});
  final MapFilters? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      appBar: const CommonAppBar(),
      body: Stack(
        children: [
          Positioned.fill(child: CommonImage(src: Assets.images.mapSample.path)),
          if (selectedFilter == MapFilters.Wishlist)
            const Positioned(left: 10, top: 10, child: MapPointsDetailsWishlish()),
          if (selectedFilter != MapFilters.Wishlist)
            const Positioned(left: 10, top: 10, child: MapPointsDetails()),
          marker(context),

          Positioned(right: 10, bottom: 10, child: _totalCourses(context)),
        ],
      ),
    );
  }

  Widget marker(BuildContext context) {
    final color = getGolfPrimaryColor(selectedFilter);
    return Positioned(
      left: 30,
      bottom: 50,
      child: CommonImage(src: Assets.images.marker, width: 24.w, height: 35.h, imageColor: color),
    );
  }

  Widget _totalCourses(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.colors.bACKGROUND_darkCardBoarder, width: 1.5),
      ),
      child: const Column(
        children: [
          CommonText(text: '5', fontSize: 24, fontWeight: .w700, textColor: Colors.black),
          CommonText(text: 'Courses', fontSize: 14, fontWeight: .w400, textColor: Colors.black),
        ],
      ),
    );
  }
}
