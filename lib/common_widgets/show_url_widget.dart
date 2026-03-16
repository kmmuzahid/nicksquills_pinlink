import 'package:core_kit/image/common_image.dart';
import 'package:core_kit/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/gen/assets.gen.dart';

class ShowUrlWidget extends StatelessWidget {
  const ShowUrlWidget({super.key, required this.url, this.maxLength = 20});
  final int maxLength;
  final String url;

  @override
  Widget build(BuildContext context) {
    Widget? icon;
    if (url.contains('youtube')) {
      icon = CommonImage(src: Assets.images.youtube, size: 14);
    } else if (url.contains('instagram')) {
      icon = CommonImage(src: Assets.images.instagram, size: 14);
    } else if (url.contains('facebook')) {
      icon = CommonImage(src: Assets.images.facebook, size: 14);
    }

    return GestureDetector(
      onTap: () {},
      child: CommonText(
        preffix: icon,
        text: "${url.substring(0, url.length > maxLength ? maxLength : url.length)}...   ",
        maxLines: 2,
        textAlign: .start,
        textColor: const Color(0xffB2CBC1),
        fontSize: 12,
        preventScaling: true,
      ),
    );
  }
}
