import 'package:core_kit/core_kit.dart';
import 'package:core_kit/list_loader/smart_tab_list_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/golf_course_played_item.dart';
import 'package:pinlink/common_widgets/golf_course_wishlist_item.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/common_widgets/social_item_widget.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/bloc/cubit_scope_value.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/navigation/cubit/navigation_cubit.dart';
import 'package:pinlink/features/course_comparision/cubit/add_course_cubit.dart';
import 'package:pinlink/features/course_comparision/model/course_model.dart';
import 'package:pinlink/features/profile/cubit/profile_cubit.dart';
import 'package:pinlink/features/profile/cubit/profile_cubit_state.dart';
import 'package:pinlink/features/profile/model/user_course_model.dart';
import 'package:pinlink/features/profile/widgets/category_scrolled_list.dart';
import 'package:pinlink/features/profile/widgets/profile_card_widget.dart';
import 'package:pinlink/features/social/cubit/social_cubit.dart'
    show SocialCubit;
import 'package:pinlink/features/social/model/post_model.dart';
import 'package:pinlink/features/social/widgets/report_dailoge.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      body: CubitScope(
        create: () => ProfileCubit()..getUserPlayedCourse(1),
        builder: (context, cubit, state) {
          final hasSubscription =
              context
                  .read<AuthCubit>()
                  .state
                  .profile
                  ?.subscription
                  ?.where((e) => (e?.amount ?? 0) > 0)
                  .isNotEmpty ??
              false;
          return LayoutBuilder(
            builder: (context, constraints) {
              final fixedWidth = (constraints.maxWidth * 0.42);
              final rattingWidth = (constraints.maxWidth - fixedWidth) / 4;
              return SmartTabListLoader(
                onLoadMore: (ctx, page) {
                  if (ctx.tab == .MyPosts) {
                    cubit.getUserPosts(page);
                  } else if (ctx.tab == .MyCourses) {
                    cubit.getUserPlayedCourse(page);
                  } else if (ctx.tab == .MyWishlist) {
                    cubit.getUserWishlistCourse(page);
                  }
                },
                onRefresh: (ctx) async {
                  if (ctx.tab == .MyPosts) {
                    cubit.getUserPosts(1, isRefresh: true);
                  } else if (ctx.tab == .MyCourses) {
                    cubit.getUserPlayedCourse(1, isRefresh: true);
                  } else if (ctx.tab == .MyWishlist) {
                    cubit.getUserWishlistCourse(1, isRefresh: true);
                  }
                },
                appbar: _appbar(context, cubit, state),

                onColapsAppbar: _onColupseGenral(context, cubit, state),
                padding: .only(bottom: 45.h, left: 16.w, right: 16.w),
                tabs: [
                  SmartTabConfig(
                    isLoading: state.isPostLoading,
                    onReorder: (oldIndex, newIndex) {
                      cubit.reorderCourses(oldIndex, newIndex);
                    },
                    subAppBar: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          _headline(context, state),
                          10.height,
                          _subHeader(
                            cubit,
                            state.selectedFilter,
                            fixedWidth: fixedWidth,
                            rattingWidth: rattingWidth,
                          ),
                        ],
                      ),
                    ),
                    subOnColapsAppbar: Container(
                      color: context.colors.background,
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 4,
                      ),
                      child: Column(
                        children: [
                          _headline(context, state),
                          10.height,
                          _subHeader(
                            cubit,
                            state.selectedFilter,
                            fixedWidth: fixedWidth,
                            rattingWidth: rattingWidth,
                          ),
                        ],
                      ),
                    ),
                    tab: FilterProfile.MyCourses,
                    itemCount: state.userCourses.length,
                  ),
                  SmartTabConfig(
                    isLoading: state.isUserPlayedCourseLoading,
                    tab: FilterProfile.MyPosts,
                    subOnColapsAppbar: _subHeaderForPost(context),
                    subAppBar: _subHeaderForPost(context),
                    itemCount: state.posts.length,
                    gridConfig: GridConfig(itemInRow: 2),
                  ),
                  SmartTabConfig(
                    isLoading: state.isWishListLoading,
                    subOnColapsAppbar: Container(
                      color: context.colors.background,
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 4,
                      ),
                      child: _headline(context, state),
                    ),
                    tab: FilterProfile.MyWishlist,
                    itemCount: state.wishListCourses.length,
                  ),
                ],
                itemBuilder: (tab, index) {
                  if (tab.tab == FilterProfile.MyCourses) {
                    final course = state.userCourses[index];
                    return GolfCoursePlayedItem(
                      key: ValueKey(course.courseId?.name),
                      controllers: cubit.controllers,
                      fixedWidth: fixedWidth,
                      rattingWidth: rattingWidth,
                      course: course,
                      selectedFilter: null,
                      index: index,
                      hasSubscription: hasSubscription,
                    );
                  } else if (tab.tab == FilterProfile.MyPosts) {
                    return _buildRowItem(
                      context,
                      postModel: state.posts[index],
                      cubit: cubit,
                    );
                  } else {
                    final course = state.wishListCourses[index];
                    return GolfCourseWishListItem(
                      onMarkPlayed: () {
                        showReRankDailoge(
                          context,
                          isPinlin5: course.isPinkLink5 ?? false,
                          course: course,
                        );
                      },
                      course: course,
                      selectedFilter: null,
                      index: index,
                      fixedWidth: fixedWidth,
                    );
                  }
                },
                value: state.selectedFilter,
              );
            },
          );
        },
      ),
    );
  }

  Container _subHeaderForPost(BuildContext context) {
    return Container(
      color: context.colors.background,
      padding: .only(left: 16.w, bottom: 4.h),
      child: Row(
        children: [
          CommonButton(
            titleText: 'Create Post',
            prefix: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(color: Colors.white, width: 1.4.r),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            onTap: () {
              appRouter.push(CreatePostRoute());
            },
          ),
          10.width,
          CommonText(
            text: 'Golf memories and scorecards',
            textColor: context.colors.tEXT_subDark,
            fontSize: 14,
          ),
        ],
      ),
    );
  }

  Widget _buildRowItem(
    BuildContext context, {
    bool showItem = true,
    required PostModel postModel,
    required ProfileCubit cubit,
  }) {
    return AspectRatio(
      aspectRatio: 0.8,
      child: showItem
          ? SocialItemWidget(
              postModel: postModel,
              onChanged: (postModel) {
                cubit.onChangePost(postModel);
              },
              onReportPost: () {
                showDialog(
                  context: context,
                  builder: (context) => ReportDialog(
                    postId: '', // Placeholder since no real post yet
                    onReport: (reason) {
                      context.read<SocialCubit>().createPostReport(
                        '', // Placeholder
                        reason,
                      );
                    },
                  ),
                );
              },
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _appbar(
    BuildContext context,
    ProfileCubit cubit,
    ProfileCubitState state,
  ) {
    return Padding(
      padding: Constants.bodyPadding,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .start,
        children: [
          CommonText(
            text: 'Track your played courses, ratings, and wishlist',
            fontSize: 16,
            maxLines: 2,
            textColor: context.colors.tEXT_subDark,
            bottom: 10,
          ).center,
          const ProfileCardWidget(),
          const SizedBox(height: 10),
          CubitScopeValue(
            cubit: context.read<AuthCubit>(),
            builder: (context, authCubit, authstate) {
              return _buildSegmentedButton(
                onTap: (value) {
                  cubit.changeFilter(value);
                },
                selectedLeaderboardType: state.selectedFilter,
                context: context,
                totalCoursesPlayed:
                    authstate.profile?.allCompareCourseCount ?? 0,
                totalPosts: authstate.profile?.allPostCount ?? 0,
                totalWishlist: authstate.profile?.allWishlishCount ?? 0,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _onColupseGenral(
    BuildContext context,
    ProfileCubit cubit,
    ProfileCubitState state,
  ) {
    return Container(
      color: context.colors.background,
      padding: const .symmetric(horizontal: 16),
      child: Column(
        children: [
          CubitScopeValue(
            cubit: context.read<AuthCubit>(),
            builder: (context, authCubit, authstate) {
              return _buildSegmentedButton(
                onTap: (value) {
                  cubit.changeFilter(value);
                },
                selectedLeaderboardType: state.selectedFilter,
                context: context,
                totalCoursesPlayed:
                    authstate.profile?.allCompareCourseCount ?? 0,
                totalPosts: authstate.profile?.allPostCount ?? 0,
                totalWishlist: authstate.profile?.allWishlishCount ?? 0,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _subHeader(
    ProfileCubit cubit,
    FilterProfile filter, {
    required double fixedWidth,
    required double rattingWidth,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: fixedWidth,

            child: const Row(
              children: [
                SizedBox(
                  width: 35,
                  child: CommonText(
                    text: 'Rank',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    textAlign: .center,
                  ),
                ),
                Spacer(),
                CommonText(
                  text: 'Courses',
                  fontSize: 11,
                  left: 10,
                  fontWeight: FontWeight.bold,
                  textAlign: .center,
                ),
                Spacer(),
              ],
            ),
          ),
          Expanded(
            child: CategoryScrolledList(
              rattingWidth: rattingWidth,
              controllers: cubit.controllers,
            ),
          ),
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
              CustomMapRoute(
                mapFilters: state.selectedFilter == FilterProfile.MyCourses
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
        border: Border.all(
          color: context.colors.bACKGROUND_darkCard,
          width: 1.2,
        ),
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

void showReRankDailoge(
  BuildContext context, {
  bool isPinlin5 = false,
  required UserCourseModel course,
}) {
  final title = isPinlin5
      ? 'Hey! You just played a PinLinks 5.'
      : 'Course Completed!';
  final subtitle = isPinlin5
      ? 'Join Pro & get 100 points.'
      : 'Would you like to rate this course now?';

  final primaryButtonTitle = isPinlin5 ? 'Get Pro' : 'Later';
  final primaryButtonAction = isPinlin5
      ? () {
          appRouter.push(SubscriptionsRoute());
        }
      : () {};

  final widget = Container(
    decoration: BoxDecoration(
      color: context.colors.bACKGROUND_darkCard,
      borderRadius: BorderRadius.circular(16),
    ),
    padding: const EdgeInsets.only(top: 8, bottom: 10, left: 16, right: 16),
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
          text: title,
          fontSize: 24,
          maxLines: 2,
          textAlign: TextAlign.center,
          textColor: context.colors.tEXT_white,
          fontWeight: FontWeight.w500,
        ),
        16.height,
        CommonText(
          text: subtitle,
          fontSize: 14,
          maxLines: 5,
          textAlign: TextAlign.center,
          textColor: context.colors.tEXT_sub,
          fontWeight: FontWeight.w500,
        ),
        20.height,

        Row(
          children: [
            Expanded(
              child: CommonButton(
                buttonWidth: .infinity,
                titleText: primaryButtonTitle,
                onTap: () {
                  Navigator.pop(context);
                  primaryButtonAction();
                },
              ),
            ),
            10.width,
            Expanded(
              child: CommonButton(
                titleColor: context.colors.tEXT_dark,
                buttonColor: context.colors.ratingPremiumTags_goldAccent,
                buttonWidth: .infinity,
                titleText: 'Add Rank',
                onTap: () {
                  Navigator.pop(context);
                  context.read<AddCourseCubit>().selectCourse(
                    CourseModel(
                      id: course.courseId?.id,
                      name: course.courseId?.name,
                      locationName: course.courseId?.locationName,
                      image: course.courseId?.image,
                      latitude: course.courseId?.latitude,
                      longitude: course.courseId?.longitude,
                      isPinkLink5: course.isPinkLink5,
                    ),
                  );
                  context.read<NavigationCubit>().changeIndex(2);
                },
              ),
            ),
            20.height,
          ],
        ),
      ],
    ),
  );
  showDialog(
    context: context,
    builder: (context) =>
        Dialog(insetPadding: const EdgeInsets.all(16), child: widget),
  );
}
