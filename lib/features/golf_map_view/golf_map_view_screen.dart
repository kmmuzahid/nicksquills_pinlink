import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/profile/widgets/map_widget.dart';

@RoutePage()
class GolfMapViewScreen extends StatelessWidget {
  const GolfMapViewScreen({super.key, required this.selectedFilter});
  final MapFilters? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      appBar: const CommonAppBar(),
      body: MapWidget(selectedFilter: selectedFilter),
    );
  }
}
