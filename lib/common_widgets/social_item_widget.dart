import 'package:core_kit/image/common_image.dart';
import 'package:core_kit/pop_up/common_popup_menu.dart';
import 'package:core_kit/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_kit/core_kit.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/dependency/dependency_injection.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/features/social/model/post_model.dart';
import 'package:pinlink/features/social/repository/social_repository.dart';

class SocialItemWidget extends StatelessWidget {
  const SocialItemWidget({
    super.key,
    required this.postModel,
    required this.onReportPost,
    required this.onChanged,
    this.onDeletePost,
  });

  final PostModel postModel;
  final VoidCallback onReportPost;
  final VoidCallback? onDeletePost;
  final void Function(PostModel postModel) onChanged;

  @override
  Widget build(BuildContext context) {
    return _item(context);
  }

  String getFirstAvailImage() {
    for (var element in (postModel.postDataId?.mediaLinks ?? [])) {
      if (element?.endsWith('mp4') != true &&
          element?.endsWith('mov') != true &&
          element?.endsWith('avi') != true) {
        return element ?? '';
      }
    }
    return Constants.sampleImage;
  }

  Widget _item(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (postModel.postDataId?.id != null) {
          appRouter.push(
            PostDetailsRoute(
              postId: postModel.id ?? '',
              reportPost: () {
                onReportPost();
              },
              onChanged: onChanged,
              onDeletePost: onDeletePost,
            ),
          );
        }
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: CommonImage(src: getFirstAvailImage(), borderRadius: 6),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              color: Colors.black.withValues(alpha: 0.05),
              child: Builder(builder: (context) {
                final isOwner = context.read<AuthCubit>().state.profile?.id ==
                    postModel.userId?.id;
                return CommonPopupMenu(
                  menuBackgroundColor: context.colors.bACKGROUND_page,
                  separator: const PopupMenuDivider(thickness: 0, height: 10),
                  triggerBuilder: (property) =>
                      const Icon(Icons.more_vert, color: Colors.white, size: 30),
                  items: [isOwner ? 'Delete Post' : 'Report Post'],
                  itemBuilder: (property) => CommonText(
                    text: property.item ?? '',
                    textColor: context.colors.tEXT_white,
                  ),
                  onItemSelected: (value) async {
                    if (value == 'Delete Post') {
                      final response = await getIt<SocialRepository>()
                          .deletePost(postModel.id ?? '');
                      if (response.isSuccess) {
                        showSnackBar("Post deleted successfully", type: .success);
                        onDeletePost?.call();
                      }
                    } else {
                      onReportPost();
                    }
                  },
                );
              }),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withValues(alpha: 0.05),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: CommonText(
                text: postModel.postDataId?.headline ?? '',
                maxLines: 3,
                textAlign: .left,
                fontSize: 14,
                fontWeight: .w500,
                textColor: Colors.white,
                autoResize: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
