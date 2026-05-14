import 'package:core_kit/image/common_image.dart';
import 'package:core_kit/pop_up/common_popup_menu.dart';
import 'package:core_kit/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/features/social/model/post_model.dart';

class SocialItemWidget extends StatelessWidget {
  const SocialItemWidget({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return _item(context);
  }

  Widget _item(BuildContext context) {
    return GestureDetector(
      onTap: () {
        appRouter.push(PostDetailsRoute(postModel: postModel));
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: CommonImage(
              src: postModel.postDataId?.mediaLinks?.isNotEmpty ?? false
                  ? postModel.postDataId!.mediaLinks!.first ?? ''
                  : Constants.sampleImage,
              borderRadius: 6,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              color: Colors.black.withValues(alpha: 0.05),
              child: CommonPopupMenu(
                triggerBuilder: (property) =>
                    const Icon(Icons.more_vert, color: Colors.white, size: 30),
                items: const ['Report User', 'Report Post'],
                itemBuilder: (property) => CommonText(
                  text: property.item ?? '',
                  textColor: context.colors.tEXT_sub,
                ),
                onItemSelected: (value) {},
              ),
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
