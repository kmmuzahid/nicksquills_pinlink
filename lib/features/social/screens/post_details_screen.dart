import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pinlink/common_widgets/show_url_widget.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/common_widgets/text_to_avater.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/features/social/cubit/post_details_cubit.dart';
import 'package:pinlink/features/social/model/post_model.dart';
import 'package:pinlink/features/social/widgets/post_text_widget.dart';
import 'package:video_player/video_player.dart';

@RoutePage()
class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({
    super.key,
    required this.postModel,
    required this.reportPost,
    required this.onChanged,
  });
  final PostModel postModel;
  final void Function() reportPost;
  final void Function(PostModel postModel) onChanged;

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      body: CubitScope(
        create: () => PostDetailsCubit(context.read<AuthCubit>(), postModel),
        builder: (context, cubit, state) {
          final postStateModel = state.postModel;
          final postData = postStateModel.postDataId;
          final mediaLinks = postData?.mediaLinks ?? [];

          return Stack(
            children: [
              Positioned.fill(
                child: mediaLinks.isEmpty
                    ? CommonImage(src: Constants.sampleImage)
                    : PageView.builder(
                        itemCount: mediaLinks.length,
                        onPageChanged: cubit.changePage,
                        itemBuilder: (context, index) {
                          final url = mediaLinks[index];
                          if (cubit.isVideo(url)) {
                            return FutureBuilder(
                              future: cubit.initVideo(index, url!),
                              builder: (context, snapshot) {
                                final controller =
                                    state.videoControllers[index];
                                if (controller != null &&
                                    controller.value.isInitialized) {
                                  return Center(
                                    child: AspectRatio(
                                      aspectRatio: controller.value.aspectRatio,
                                      child: VideoPlayer(controller),
                                    ),
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                          } else {
                            return CommonImage(src: url ?? '');
                          }
                        },
                      ),
              ),

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CommonAppBar(
                  appbarConfig: AppbarConfig(
                    decoration: () =>
                        const BoxDecoration(color: Colors.transparent),
                  ),
                ),
              ),

              // 4. Bottom Information Overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  top: false,
                  bottom: true,
                  child: Column(
                    mainAxisSize: .min,

                    children: [
                      Container(
                        color: Colors.black.withValues(alpha: 0.05),
                        padding: const EdgeInsets.only(top: 10),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: IntrinsicWidth(
                          child: Column(
                            mainAxisAlignment: .center,
                            crossAxisAlignment: .center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  cubit.likePost(
                                    postStateModel.id ?? '',
                                    onChanged,
                                  );
                                },
                                child: _buildActionButton(
                                  cubit.isLiked(postStateModel.id ?? '')
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  "${postStateModel.likesCount ?? 0}",
                                  cubit.isLiked(postStateModel.id ?? '')
                                      ? Colors.red
                                      : Colors.white,
                                ).end,
                              ),
                              // const SizedBox(height: 20),
                              // _buildActionButton(
                              //   Icons.chat_bubble_outline,
                              //   "${postStateModel.commentsCount ?? 0}",
                              //   Colors.white,
                              // ).end,
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  cubit.sharePost(postStateModel.id ?? '');
                                },
                                child: _buildActionButton(
                                  Icons.share,
                                  "${postStateModel.shareCount ?? 0}",
                                  Colors.white,
                                ).end,
                              ),
                              const SizedBox(height: 20),
                              CommonPopupMenu(
                                triggerBuilder: (property) => const Icon(
                                  Icons.more_vert_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                menuBackgroundColor:
                                    context.colors.bACKGROUND_page,
                                separator: const PopupMenuDivider(
                                  thickness: 0,
                                  height: 10,
                                ),

                                items: const ['Report Post'],
                                itemBuilder: (property) => CommonText(
                                  text: property.item ?? '',
                                  textColor: context.colors.tEXT_white,
                                ),
                                onItemSelected: (value) {
                                  reportPost();
                                },
                              ),
                            ],
                          ),
                        ),
                      ).end,
                      Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.black.withValues(alpha: 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildUserInfo(context, cubit, postStateModel),
                            const SizedBox(height: 12),
                            const Divider(color: Colors.white24),
                            if (postData?.links != null &&
                                postData!.links!.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              SingleChildScrollView(
                                scrollDirection: .horizontal,
                                child: Row(
                                  children: postData.links!
                                      .where((url) => url != null)
                                      .map((url) => ShowUrlWidget(url: url!))
                                      .toList(),
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                            _buildPostStats(postStateModel),
                            if (postData?.headline != null) ...[
                              const SizedBox(height: 12),
                              CommonText(
                                text: postData!.headline!,
                                maxLines: 2,
                                textAlign: .start,
                                textColor: Colors.white,
                                fontSize: 18,
                                preventScaling: true,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                            if (postData?.description != null) ...[
                              const SizedBox(height: 8),
                              PostTextWidget(text: postData!.description!),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        mainAxisSize: .min,
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          Icon(icon, color: color, size: 30),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(
    BuildContext context,
    PostDetailsCubit cubit,
    PostModel postModel,
  ) {
    final user = postModel.userId;
    final postData = postModel.postDataId;

    var timeAgo = '';
    if (postModel.createdAt != null) {
      try {
        final date = DateTime.parse(postModel.createdAt!);
        final diff = DateTime.now().difference(date);
        if (diff.inDays > 0) {
          timeAgo = "${diff.inDays}d ago";
        } else if (diff.inHours > 0) {
          timeAgo = "${diff.inHours}h ago";
        } else {
          timeAgo = "${diff.inMinutes}m ago";
        }
      } catch (e) {
        timeAgo = postModel.createdAt!;
      }
    }

    return Row(
      children: [
        TextToAvatar(
          text: user?.fullName?.substring(0, 1) ?? "",
          size: 50.w,
          color: const Color(0xFF00BC7D),
        ),
        // CommonImage(
        //   src: user?.profile ?? Constants.sampleImage,
        //   borderRadius: 46,
        //   size: 46,
        // ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CommonText(
                    text: user?.fullName ?? "Anonymous",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  10.width,
                  if (postModel.userId?.id !=
                      context.read<AuthCubit>().state.profile?.id)
                    CommonButton(
                      titleText: 'Follow',
                      buttonHeight: 20,
                      onTap: () {
                        cubit.follow(postModel.userId?.id ?? '');
                      },
                      buttonRadius: 4,
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 5,
                      ),
                      titleColor: Colors.black,
                      buttonColor: const Color(0xffE3C97A),
                    ),
                ],
              ),
              Row(
                children: [
                  CommonText(
                    text: postData?.courseId?.name ?? "Unknown Course",
                    style: const TextStyle(
                      color: Color(0xffB2CBC1),
                      fontSize: 12,
                    ),
                    right: 2,
                  ),
                  const Icon(Icons.circle, size: 6, color: Color(0xffE3C97A)),
                  CommonText(
                    text: " ${postData?.courseId?.locationName ?? 'N/A'}",
                    style: const TextStyle(
                      color: Color(0xffB2CBC1),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          timeAgo,
          style: const TextStyle(color: Colors.white54, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildPostStats(PostModel postModel) {
    final postData = postModel.postDataId;
    if (postData == null) return const SizedBox.shrink();

    var formattedDate = '';
    if (postData.scorecardDate != null) {
      try {
        final date = DateTime.parse(postData.scorecardDate!);
        formattedDate = DateFormat('dd MMM, yyyy').format(date);
      } catch (e) {
        formattedDate = postData.scorecardDate!;
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if (formattedDate.isNotEmpty)
            _buildPostStatsText(title: "Date", value: formattedDate),
          if (postData.scorecardTotalScore != null) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.circle, size: 4, color: Colors.white),
            ),
            _buildPostStatsText(
              title: "Total Score",
              value: "${postData.scorecardTotalScore}",
            ),
          ],
          if (postData.scorecardHoles != null) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.circle, size: 4, color: Colors.white),
            ),
            _buildPostStatsText(
              title: "Holes",
              value: "${postData.scorecardHoles}",
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPostStatsText({required String title, required String value}) {
    return Row(
      children: [
        CommonText(
          text: title,
          style: const TextStyle(color: Color(0xffB2CBC1), fontSize: 14),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(Icons.circle, size: 4, color: Colors.white),
        ),
        CommonText(
          text: value,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}
