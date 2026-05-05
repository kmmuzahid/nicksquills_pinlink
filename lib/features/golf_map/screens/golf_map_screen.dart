import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/golf_map/cubit/golf_map_cubit.dart';
import 'package:pinlink/features/golf_map/cubit/golf_map_cubit_state.dart';
import 'package:pinlink/features/golf_map/widgets/filter_widget.dart';
import 'package:pinlink/features/profile/widgets/map_widget.dart';

class GolfMapScreen extends StatelessWidget {
  const GolfMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      body: CubitScope(
        create: () => GolfMapCubit(),
        builder: (context, cubit, state) {
          return Column(
            children: [
              6.height,
              _buildFilterSection(context, cubit, state),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: MapWidget(selectedFilter: state.selectedFilter),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 16,
                      child: SizedBox(
                        width: CoreScreenUtils.deviceSize.width * .7,
                        child: CommonTextField(
                          prefixIcon: Icon(
                            Icons.search,
                            color: context.colors.tEXT_sub,
                          ),
                          validationType: .notRequired,
                          backgroundColor: context.colors.background,
                          hintText: 'Search courses on map...',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterSection(
    BuildContext context,
    GolfMapCubit cubit,
    GolfMapCubitState state,
  ) {
    return Wrap(
      spacing: 4.w,
      children: [
        FilterWidget(
          title: MapFilters.Played,
          selectedFilter: state.selectedFilter,
          subtitle: "Courses Done",
          iconData: Icons.place_outlined,
          onTap: cubit.changeFilter,
        ),
        FilterWidget(
          selectedFilter: state.selectedFilter,
          title: MapFilters.Wishlist,
          subtitle: "Saved courses",
          iconData: Icons.bookmark_border,
          onTap: cubit.changeFilter,
        ),
        FilterWidget(
          selectedFilter: state.selectedFilter,
          title: MapFilters.Friends,
          subtitle: "Friends’ activity",
          iconData: Icons.people,
          onTap: cubit.changeFilter,
        ),
        FilterWidget(
          selectedFilter: state.selectedFilter,
          title: MapFilters.PinLinks5,
          subtitle: "Top rated picks",
          iconData: Icons.emoji_events_outlined,
          onTap: cubit.changeFilter,
        ),
      ],
    );
  }
}
