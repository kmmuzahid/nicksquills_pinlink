import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/show_url_widget.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/features/social/model/post_model.dart';
import 'package:pinlink/features/social/widgets/post_text_widget.dart';

@RoutePage()
class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key, required this.postModel});
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      body: Stack(
        children: [
          Positioned.fill(child: CommonImage(src: Constants.sampleImage)),

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
                          _buildActionButton(
                            Icons.favorite,
                            "42",
                            Colors.red,
                          ).end,
                          const SizedBox(height: 20),
                          _buildActionButton(
                            Icons.chat_bubble_outline,
                            "35",
                            Colors.white,
                          ).end,
                          const SizedBox(height: 20),
                          _buildActionButton(
                            Icons.share,
                            "52",
                            Colors.white,
                          ).end,
                          const SizedBox(height: 20),
                          CommonPopupMenu(
                            triggerBuilder: (property) => const Icon(
                              Icons.more_vert_outlined,
                              color: Colors.black,
                              size: 30,
                            ),

                            items: const ['Report User', 'Report Post'],
                            itemBuilder: (property) => CommonText(
                              text: property.item ?? '',
                              textColor: context.colors.tEXT_sub,
                            ),
                            onItemSelected: (value) {},
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
                        _buildUserInfo(context),
                        const SizedBox(height: 12),
                        const Divider(color: Colors.white24),
                        const SizedBox(height: 8),
                        const SingleChildScrollView(
                          scrollDirection: .horizontal,
                          child: Row(
                            children: [
                              ShowUrlWidget(
                                url:
                                    'https://www.youtube.com/watch?v=1234567890',
                              ),
                              ShowUrlWidget(url: 'https://www.instagram.com/'),
                              ShowUrlWidget(url: 'https://www.facebook.com/'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildPostStats(),
                        const SizedBox(height: 12),
                        const CommonText(
                          text:
                              "Amazing weather today! Course was in perfect condition.",
                          maxLines: 2,
                          textAlign: .start,
                          textColor: Colors.white,
                          fontSize: 18,
                          preventScaling: true,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 8),
                        const PostTextWidget(
                          text:
                              'We collect data to personalize your experience and improve our services. This includes Played at Pebble Beach this morning and the course was flawless. Greens were smooth, fairways were perfect, and the breeze made every shot enjoyable. Can’t wait to come back next weekend! you provide,  such as your habits and preferences, as well as data collected automatically, like usage patterns.',
                        ), // Padding for bottom notch
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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

  Widget _buildUserInfo(BuildContext context) {
    return Row(
      children: [
        CommonImage(src: Constants.sampleImage, borderRadius: 46, size: 46),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CommonText(
                    text: "Ava Harper",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  10.width,

                  const CommonButton(
                    titleText: 'Follow',
                    buttonHeight: 20,
                    buttonRadius: 4,
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    titleColor: Colors.black,
                    buttonColor: Color(0xffE3C97A),
                  ),
                ],
              ),
              const Row(
                children: [
                  CommonText(
                    text: "Augusta National ",
                    style: TextStyle(color: Color(0xffB2CBC1), fontSize: 12),
                  ),
                  Icon(Icons.circle, size: 6, color: Color(0xffE3C97A)),
                  CommonText(
                    text: " California, USA",
                    style: TextStyle(color: Color(0xffB2CBC1), fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Text(
          "23 minutes ago",
          style: TextStyle(color: Colors.white54, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildPostStats() {
    return Row(
      children: [
        _buildPostStatsText(title: "Date", value: "12 Jan, 2026"),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(Icons.circle, size: 4, color: Colors.white),
        ),
        _buildPostStatsText(title: "Total Score", value: "45"),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(Icons.circle, size: 4, color: Colors.white),
        ),
        _buildPostStatsText(title: "Holes", value: "9"),
      ],
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
