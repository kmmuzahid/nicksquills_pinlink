import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/custom_card.dart';
import 'package:pinlink/common_widgets/custom_divider.dart';
import 'package:pinlink/common_widgets/show_url_widget.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/features/golf_map/cubit/map_point_details_cubit.dart';
import 'package:pinlink/features/golf_map/model/map_point_details_model.dart';

class MapPointsDetails extends StatelessWidget {
  const MapPointsDetails({super.key, required this.courseId});
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 350.h,
          maxWidth: CoreScreenUtils.deviceSize.width * .7,
        ),
        child: CubitScope(
          create: () => MapPointDetailsCubit()..getMapPointDetails(courseId),
          builder: (context, cubit, state) {
            return state.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: context.colors.pRIMARY_brandClr,
                    ),
                  )
                : Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .start,

                    children: [
                      CommonText(
                        text:
                            state
                                .mapPointsDetails
                                ?.compareCourse
                                ?.courseId
                                ?.name ??
                            '',
                        fontSize: 16,
                        fontWeight: .bold,
                        textColor: context.colors.tEXT_white,
                      ).start,
                      const CustomDivider(),
                      _rattings(context, state.mapPointsDetails?.compareCourse),
                      CommonText(
                        top: 4,
                        text: 'Post List',
                        fontSize: 14,
                        textColor: context.colors.tEXT_sub,
                      ),
                      SizedBox(
                        height: 75.h,
                        child:
                            state.mapPointsDetails?.allPost?.isNotEmpty == true
                            ? ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    state.mapPointsDetails?.allPost?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  final post =
                                      state.mapPointsDetails?.allPost?[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        appRouter.push(
                                          PostDetailsRoute(
                                            postId: post?.id,
                                            reportPost: () {},
                                            onChanged: (v) {},
                                          ),
                                        );
                                      },
                                      child: CommonImage(
                                        src: getFirstAvailImage(
                                          state
                                                  .mapPointsDetails
                                                  ?.allPost?[index]
                                                  ?.postDataId
                                                  ?.mediaLinks ??
                                              [],
                                        ),
                                        width: 62.w,
                                        height: 70.h,
                                        borderRadius: 8,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : CommonText(
                                text: 'No posts found',
                                fontSize: 14,
                                textColor: context.colors.tEXT_subDark,
                              ).center,
                      ),
                      CommonText(
                        top: 4,
                        text: 'Score List',
                        fontSize: 14,
                        textColor: context.colors.tEXT_sub,
                      ),

                      Row(
                        children: List.generate(
                          state.mapPointsDetails?.allPost?.length ?? 0,
                          (index) => CustomCard(
                            margin: const EdgeInsets.only(right: 8),
                            borderRadius: 8,
                            backgroundColor: context.colors.bACKGROUND_darkPage,
                            child: CommonText(
                              text:
                                  '${state.mapPointsDetails?.allPost?[index]?.postDataId?.scorecardTotalScore ?? 0}',
                              fontSize: 14,
                              textColor: context.colors.tEXT_white,
                            ),
                          ),
                        ),
                      ),
                      CommonText(
                        top: 4,
                        text: 'Posted Social Link',
                        fontSize: 14,
                        textColor: context.colors.tEXT_sub,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.links.length,
                          itemBuilder: (context, index) {
                            return _buildSocialLinks(
                              context,
                              state.links[index].value,
                              state.links[index].key,
                            );
                          },
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  String getFirstAvailImage(List<String?> mediaList) {
    for (var element in mediaList) {
      if (element?.endsWith('mp4') != true &&
          element?.endsWith('mov') != true &&
          element?.endsWith('avi') != true) {
        return element ?? '';
      }
    }
    return Constants.sampleImage;
  }

  Widget _buildSocialLinks(BuildContext context, String url, DateTime date) {
    return Row(
      crossAxisAlignment: .center,
      children: [
        CommonText(
          top: 4,
          text: date.date,
          fontSize: 12,
          textColor: context.colors.tEXT_white,
        ),
        12.width,
        ShowUrlWidget(url: url, maxLength: 25.w.toInt()),
      ],
    );
  }

  SingleChildScrollView _rattings(
    BuildContext context,
    CompareCourse? compareCourse,
  ) {
    final isSubscriptionActive = context
        .read<AuthCubit>()
        .state
        .profile
        ?.subscription
        ?.where((e) => (e?.amount ?? 0) > 0)
        .isNotEmpty;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: .start,
        children: [
          const CommonRatingBar(rating: 5, size: 12, spacing: 0),
          Text(
            ' (${compareCourse?.favorite})',
            style: TextStyle(
              color: context.colors.tEXT_white,
              fontSize: 12,
              fontWeight: .bold,
            ),
          ),

          ...isSubscriptionActive == true
              ? [
                  4.width,
                  const CommonRatingBar(rating: 5, size: 12, spacing: 0),
                  Text(
                    ' (${compareCourse?.favorite})',
                    style: TextStyle(
                      color: context.colors.tEXT_white,
                      fontSize: 12,
                      fontWeight: .bold,
                    ),
                  ),
                  4.width,
                  const CommonRatingBar(rating: 5, size: 12, spacing: 0),
                  Text(
                    ' (${compareCourse?.favorite})',
                    style: TextStyle(
                      color: context.colors.tEXT_white,
                      fontSize: 12,
                      fontWeight: .bold,
                    ),
                  ),
                  4.width,
                  const CommonRatingBar(rating: 5, size: 12, spacing: 0),
                  Text(
                    ' (${compareCourse?.favorite})',
                    style: TextStyle(
                      color: context.colors.tEXT_white,
                      fontSize: 12,
                      fontWeight: .bold,
                    ),
                  ),
                  4.width,
                  const CommonRatingBar(rating: 5, size: 12, spacing: 0),
                  Text(
                    ' (${compareCourse?.favorite})',
                    style: TextStyle(
                      color: context.colors.tEXT_white,
                      fontSize: 12,
                      fontWeight: .bold,
                    ),
                  ),
                ]
              : [
                  lockedRatting(context),
                  lockedRatting(context),
                  lockedRatting(context),
                  lockedRatting(context),
                ],
        ],
      ),
    );
  }

  Widget lockedRatting(BuildContext context) {
    return Row(
      children: [
        10.width,
        Icon(Icons.star, color: context.colors.tEXT_sub, size: 16),
        Icon(Icons.lock, color: context.colors.tEXT_sub, size: 12),
      ],
    );
  }
}
