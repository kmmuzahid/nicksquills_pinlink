import 'package:core_kit/image/common_image.dart';
import 'package:core_kit/pop_up/common_popup_menu.dart';
import 'package:core_kit/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/constants.dart';

class SocialItemWidget extends StatelessWidget {
  const SocialItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _item();
  }

  Widget _item() {
    return GestureDetector(
      onTap: () {
        appRouter.push(const PostDetailsRoute());
      },
      child: Stack(
        children: [
          Positioned.fill(child: CommonImage(src: Constants.sampleImage, borderRadius: 6)),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              color: Colors.black.withValues(alpha: 0.05),
              child: CommonPopupMenu(
                showIconTrigger: true,
                showTextTrigger: false,
                primaryColor: Colors.white,
                onPrimaryColor: Colors.white,
                menuTextStyle: const TextStyle(color: Colors.black),
                items: const ['Report User', 'Report Post'],
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
              child: const CommonText(
                text: 'Amazing weather today! Course was in perfect condition.',
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
