import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/golf_course_played_item.dart';
import 'package:pinlink/common_widgets/golf_course_wishlist_item.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/common_widgets/social_item_widget.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/course_comparision/model/course_model.dart';
import 'package:pinlink/features/profile/cubit/profile_cubit.dart';
import 'package:pinlink/features/profile/cubit/profile_cubit_state.dart';
import 'package:pinlink/features/profile/widgets/profile_card_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      body: CubitScope(
        create: () => ProfileCubit(),
        builder: (context, cubit, state) {
          const length = 19;

          final isList = state.selectedFilter != FilterProfile.MyPosts;
          final rowCount = (length / 2).ceil();

          return SmartListLoader(
            appbar: _appbar(context, cubit, state),
            padding: Constants.bodyPadding,
            itemCount: isList ? length : rowCount,
            itemBuilder: (context, index) {
              if (!isList) {
                final firstIndex = index * 2;
                final secondIndex = firstIndex + 1;

                final hasSecondItem = secondIndex < length;

                return Row(
                  children: [
                    Expanded(child: _buildRowItem(context, firstIndex)),
                    Expanded(
                      child: hasSecondItem ? _buildRowItem(context, secondIndex) : const SizedBox(),
                    ),
                  ],
                );
              }

              if (state.selectedFilter == FilterProfile.MyCourses) {
                return GolfCoursePlayedItem(
                  course: CourseModel(
                    name: 'Royal Melbourne',
                    address: 'Australia',
                    isAlreadyPlayed: false,
                  ),
                  selectedFilter: null,
                  index: index,
                );
              }

              return GolfCourseWishListItem(
                course: CourseModel(
                  name: 'Royal Melbourne',
                  address: 'Australia',
                  isAlreadyPlayed: false,
                ),
                selectedFilter: null,
                index: index,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRowItem(BuildContext context, int index, {bool showItem = true}) {
    final isEven = index.isEven;

    return Padding(
      padding: EdgeInsets.only(left: isEven ? 0 : 4, right: isEven ? 4 : 0, bottom: 8),
      child: AspectRatio(
        aspectRatio: 0.8,
        child: showItem ? const SocialItemWidget() : const SizedBox.shrink(),
      ),
    );
  }

  Widget _appbar(BuildContext context, ProfileCubit cubit, ProfileCubitState state) {
    return Padding(
      padding: Constants.bodyPadding,
      child: Column(
        children: [
          CommonText(
            text: 'Track your played courses, ratings, and wishlist',
            fontSize: 16,
            maxLines: 2,
            textColor: context.colors.tEXT_subDark,
            bottom: 10,
          ).center,
          const ProfileCardWidget(),
          const SizedBox(height: 20),
          _buildSegmentedButton(
            onTap: (value) {
              cubit.changeFilter(value);
            },
            selectedLeaderboardType: state.selectedFilter,
            context: context,
            totalCoursesPlayed: 10,
            totalPosts: 20,
            totalWishlist: 30,
          ),
          10.height,
          if (state.selectedFilter != FilterProfile.MyPosts) _headline(context, state),
        ],
      ),
    );
  }

  Widget _headline(BuildContext context, ProfileCubitState state) {
    return Row(
      children: [
        5.width,
        CommonText(
          text: state.selectedFilter == FilterProfile.MyCourses
              ? 'Ranked from favorite to least favorite'
              : 'Courses you want to play',
          fontSize: 14,
          textColor: context.colors.tEXT_white,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            appRouter.push(
              GolfMapViewRoute(
                selectedFilter: state.selectedFilter == FilterProfile.MyCourses
                    ? MapFilters.Played
                    : MapFilters.Wishlist,
              ),
            );
          },
          child: const CommonText(
            text: 'View on Map (5)',
            fontSize: 12,
            fontWeight: .bold,
            textColor: Color(0xff10B981),
          ),
        ),
        5.width,
      ],
    );
  }

  Widget _buildSegmentedButton({
    required Function(FilterProfile) onTap,
    required FilterProfile selectedLeaderboardType,
    required BuildContext context,
    required int totalCoursesPlayed,
    required int totalPosts,
    required int totalWishlist,
  }) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colors.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: context.colors.bACKGROUND_darkCard, width: 1.2),
      ),

      child: Row(
        children: [
          _buildSegmentButton(
            leaderboardType: FilterProfile.MyCourses,
            selectedLeaderboardType: selectedLeaderboardType,
            onTap: onTap,
            context: context,
            total: totalCoursesPlayed,
          ),
          _buildSegmentButton(
            leaderboardType: FilterProfile.MyPosts,
            selectedLeaderboardType: selectedLeaderboardType,
            onTap: onTap,
            context: context,
            total: totalPosts,
          ),
          _buildSegmentButton(
            leaderboardType: FilterProfile.MyWishlist,
            selectedLeaderboardType: selectedLeaderboardType,
            onTap: onTap,
            context: context,
            total: totalWishlist,
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentButton({
    required FilterProfile leaderboardType,
    required FilterProfile selectedLeaderboardType,
    required Function(FilterProfile) onTap,
    required BuildContext context,
    required int total,
  }) {
    const radious = 40.0;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(leaderboardType),
        child: Container(
          decoration: BoxDecoration(
            color: selectedLeaderboardType == leaderboardType
                ? context.colors.bACKGROUND_darkPage
                : Colors.transparent,

            borderRadius: const BorderRadius.all(Radius.circular(radious)),
          ),
          child: Center(
            child: CommonText(
              left: 10,
              right: 10,
              top: 8,
              bottom: 8,
              text: '${leaderboardType.displayName} ($total)',
              textColor: context.colors.tEXT_white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
