import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/custom_card.dart';
import 'package:pinlink/common_widgets/custom_divider.dart';
import 'package:pinlink/common_widgets/show_url_widget.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/constants.dart';

class MapPointsDetails extends StatelessWidget {
  const MapPointsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 350,
          maxWidth: CoreScreenUtils.deviceSize.width * .7,
        ),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,

          children: [
            CommonText(
              text: 'Pebble Beach',
              fontSize: 16,
              fontWeight: .bold,
              textColor: context.colors.tEXT_white,
            ).start,
            const CustomDivider(),
            _rattings(context),
            CommonText(top: 4, text: 'Post List', fontSize: 14, textColor: context.colors.tEXT_sub),
            SizedBox(
              height: 75.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CommonImage(src: Constants.sampleImage, width: 62.w, height: 70.h),
                ),
              ),
            ),
            CommonText(
              top: 4,
              text: 'Score List',
              fontSize: 14,
              textColor: context.colors.tEXT_sub,
            ),

            Row(
              children: List.generate(
                4,
                (index) => CustomCard(
                  margin: const EdgeInsets.only(right: 8),
                  borderRadius: 8,
                  backgroundColor: context.colors.bACKGROUND_darkPage,
                  child: CommonText(
                    text: '${50 + index}',
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
            _buildSocialLinks(
              context,
              'https://www.youtube.com/watch?v=1234567890',
              DateTime.now(),
            ),
            _buildSocialLinks(context, 'https://www.instagram.com/p/1234567890/', DateTime.now()),
            _buildSocialLinks(context, 'https://www.facebook.com/posts/1234567890', DateTime.now()),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLinks(BuildContext context, String url, DateTime date) {
    return Row(
      crossAxisAlignment: .center,
      children: [
        CommonText(top: 4, text: date.date, fontSize: 12, textColor: context.colors.tEXT_white),
        12.width,
        ShowUrlWidget(url: url, maxLength: 25.w.toInt()),
      ],
    );
  }

  SingleChildScrollView _rattings(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: .start,
        children: [
          const CommonRatingBar(rating: 5, size: 12, spacing: 0),
          Text(
            ' 5.0',
            style: TextStyle(color: context.colors.tEXT_white, fontSize: 12, fontWeight: .bold),
          ),
          lockedRatting(context),
          lockedRatting(context),
          lockedRatting(context),
          lockedRatting(context),
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
