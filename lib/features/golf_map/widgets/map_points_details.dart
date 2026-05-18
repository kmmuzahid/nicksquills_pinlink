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
import 'package:pinlink/constant/enums.dart';
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
          maxHeight: 340.h,
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
                        text: 'Recent Post',
                        fontSize: 14,
                        textColor: context.colors.tEXT_sub,
                      ),
                      SizedBox(
                        height: 90.h,
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
                                      child: SizedBox(
                                        width: 80.w,
                                        height: 90.h,
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: CommonImage(
                                                src: getFirstAvailImage(
                                                  state
                                                          .mapPointsDetails
                                                          ?.allPost?[index]
                                                          ?.postDataId
                                                          ?.mediaLinks ??
                                                      [],
                                                ),

                                                borderRadius: 8,
                                              ),
                                            ),

                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              left: 0,
                                              child: Container(
                                                width: .infinity,
                                                color: Colors.black.withValues(
                                                  alpha: .5,
                                                ),
                                                padding: const .symmetric(
                                                  horizontal: 6,
                                                  vertical: 6,
                                                ),
                                                child: CommonText(
                                                  fontSize: 18,
                                                  fontWeight: .bold,
                                                  textColor: Colors.white,
                                                  text:
                                                      'Score: ${post?.postDataId?.scorecardTotalScore ?? 0}',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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
                      // CommonText(
                      //   top: 4,
                      //   text: 'Score List',
                      //   fontSize: 14,
                      //   textColor: context.colors.tEXT_sub,
                      // ),

                      // Row(
                      //   children: List.generate(
                      //     state.mapPointsDetails?.allPost?.length ?? 0,
                      //     (index) => CustomCard(
                      //       margin: const EdgeInsets.only(right: 8),
                      //       borderRadius: 8,
                      //       backgroundColor: context.colors.bACKGROUND_darkPage,
                      //       child: CommonText(
                      //         text:
                      //             '${state.mapPointsDetails?.allPost?[index]?.postDataId?.scorecardTotalScore ?? 0}',
                      //         fontSize: 14,
                      //         textColor: context.colors.tEXT_white,
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
    final isSubscriptionActive =
        context
            .read<AuthCubit>()
            .state
            .profile
            ?.subscription
            ?.where((e) => (e?.amount ?? 0) > 0)
            .isNotEmpty ??
        false;

    const categoriesCount = 8; // Total 8 categories just like in profile

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: .start,
        children: List.generate(categoriesCount, (index) {
          double rating = 0;
          if (compareCourse != null) {
            if (index == 0) {
              rating = (compareCourse.favorite ?? 0).toDouble();
            } else if (index == 1) {
              rating = (compareCourse.scenery ?? 0).toDouble();
            } else if (index == 2) {
              rating = (compareCourse.difficulty ?? 0).toDouble();
            } else if (index == 3) {
              rating = (compareCourse.teeBoxFairwayCondition ?? 0).toDouble();
            } else if (index == 4) {
              rating = (compareCourse.greenSpeed ?? 0).toDouble();
            } else if (index == 5) {
              rating = (compareCourse.greenCondition ?? 0).toDouble();
            } else if (index == 6) {
              rating = (compareCourse.clubHouse ?? 0).toDouble();
            } else if (index == 7) {
              rating = (compareCourse.foodDrink ?? 0).toDouble();
            }
          }

          final hasSubscription = isSubscriptionActive;

          return Container(
            width: 60.w, // Match profile screen category column width
            margin: const EdgeInsets.only(right: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonText(
                  alignment: .center,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  text: RatingCategories.values[index].displayName,
                ),
                5.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (lIndex) => rattingIcon(
                      color: index == 0 || hasSubscription
                          ? Colors.amber
                          : context.colors.tEXT_sub,
                      icon: index == 0 || hasSubscription
                          ? (lIndex >= rating ? Icons.star_outline : Icons.star)
                          : Icons.star,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    2,
                    (lIndex) => rattingIcon(
                      color: index == 0 || hasSubscription
                          ? Colors.amber
                          : context.colors.tEXT_sub,
                      icon: index == 0 || hasSubscription
                          ? (lIndex + 3 >= rating
                                ? Icons.star_outline
                                : Icons.star)
                          : Icons.star,
                    ),
                  ),
                ),
                5.height,
                if (index == 0)
                  Text(
                    rating.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: context.colors.tEXT_white,
                    ),
                  ),
                if (!hasSubscription && index != 0) ...[
                  Icon(Icons.lock, color: context.colors.tEXT_sub, size: 14),
                ],
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget rattingIcon({Color color = Colors.amber, required IconData icon}) {
    return Icon(icon, color: color, size: 12);
  }
}
