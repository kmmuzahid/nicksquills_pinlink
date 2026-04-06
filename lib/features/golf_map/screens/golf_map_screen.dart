import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/custom_divider.dart';
import 'package:pinlink/common_widgets/golf_course_played_item.dart';
import 'package:pinlink/common_widgets/golf_course_wishlist_item.dart';
import 'package:pinlink/common_widgets/info_card_widget.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/course_comparision/model/course_model.dart';
import 'package:pinlink/features/golf_map/cubit/golf_map_cubit.dart';
import 'package:pinlink/features/golf_map/cubit/golf_map_cubit_state.dart';
import 'package:pinlink/features/golf_map/widgets/filter_widget.dart';
import 'package:pinlink/features/golf_map/widgets/golf_course_item.dart';

class GolfMapScreen extends StatelessWidget {
  const GolfMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      body: CubitScope(
        create: () => GolfMapCubit(),
        builder: (context, cubit, state) {
          return SmartListLoader(
            padding: Constants.bodyPadding,
            appbar: _appbar(context, cubit, state),
            onColapsAppbar: Container(
              color: context.colors.background,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Column(
                children: [
                  CommonTextField(
                    backgroundColor: Colors.transparent,
                    prefixIcon: Icon(
                      Icons.search,
                      color: context.colors.tEXT_sub,
                    ),
                    validationType: .notRequired,
                    hintText: 'Search courses on map...',
                  ),

                  5.height,
                  _headline(context, state),
                ],
              ),
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              if (state.selectedFilter == MapFilters.Wishlist) {
                return GolfCourseWishListItem(
                  course: CourseModel(
                    name: 'Royal Melbourne',
                    address: 'Australia',
                    isAlreadyPlayed: false,
                  ),
                  index: index,
                  selectedFilter: state.selectedFilter,
                );
              } else if (state.selectedFilter == MapFilters.Played) {
                return GolfCoursePlayedItem(
                  scrollController: cubit.controllerFor(index),
                  course: CourseModel(
                    name: 'Royal Melbourne',
                    address: 'Australia',
                    isAlreadyPlayed: false,
                  ),
                  index: index,
                  selectedFilter: state.selectedFilter,
                );
              }
              return GolfCourseItem(
                course: CourseModel(
                  name: 'Royal Melbourne',
                  address: 'Australia',
                  isAlreadyPlayed: false,
                ),
                index: index,
                selectedFilter: state.selectedFilter,
              );
            },
          );
        },
      ),
    );
  }

  Widget _appbar(
    BuildContext context,
    GolfMapCubit cubit,
    GolfMapCubitState state,
  ) {
    return Padding(
      padding: Constants.bodyPadding,
      child: Column(
        crossAxisAlignment: .center,
        mainAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          CommonText(
            text: 'Explore courses near you and worldwide',
            fontSize: 16,
            textColor: context.colors.tEXT_subDark,
          ),
          10.height,
          CommonTextField(
            prefixIcon: Icon(Icons.search, color: context.colors.tEXT_sub),
            validationType: .notRequired,
            backgroundColor: context.colors.background,
            hintText: 'Search courses on map...',
          ),
          10.height,
          const InfoCardWidget(
            title: 'Explore Your Golf Journey',
            description:
                'Add or update courses using Add / Play. Filter pins to discover new courses.',
          ),

          _buildFilterSection(context, cubit, state),
          5.height,
          _headline(context, state),
        ],
      ),
    );
  }

  Widget _headline(BuildContext context, GolfMapCubitState state) {
    return Row(
      children: [
        CommonText(
          text: 'All Courses',
          fontSize: 16,
          fontWeight: .bold,
          textColor: context.colors.tEXT_white,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            appRouter.push(
              GolfMapViewRoute(selectedFilter: state.selectedFilter),
            );
          },
          child: const CommonText(
            text: 'View on Map (5)',
            fontSize: 14,
            fontWeight: .bold,
            textColor: Color(0xff10B981),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSection(
    BuildContext context,
    GolfMapCubit cubit,
    GolfMapCubitState state,
  ) {
    return Column(
      children: [
        const CustomDivider(),
        Row(
          children: [
            Expanded(
              child: FilterWidget(
                title: MapFilters.Played,
                selectedFilter: state.selectedFilter,
                subtitle: "Courses you have played",
                iconData: Icons.place_outlined,
                onTap: cubit.changeFilter,
              ),
            ),
            4.width,
            Expanded(
              child: FilterWidget(
                selectedFilter: state.selectedFilter,
                title: MapFilters.Wishlist,
                subtitle: "Courses you want to play",
                iconData: Icons.bookmark_border,
                onTap: cubit.changeFilter,
              ),
            ),
          ],
        ),
        4.height,
        Row(
          children: [
            Expanded(
              child: FilterWidget(
                selectedFilter: state.selectedFilter,
                title: MapFilters.Friends,
                subtitle: "Courses your friends have played",
                iconData: Icons.people,
                onTap: cubit.changeFilter,
              ),
            ),
            4.width,
            Expanded(
              child: FilterWidget(
                selectedFilter: state.selectedFilter,
                title: MapFilters.PinLinks5,
                subtitle: "Our top rated courses",
                iconData: Icons.emoji_events_outlined,
                onTap: cubit.changeFilter,
              ),
            ),
          ],
        ),
        const CustomDivider(),
      ],
    );
  }
}
