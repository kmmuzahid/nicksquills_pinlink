import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/features/social/widgets/post_text_widget.dart';

@RoutePage()
class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key});

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
                decoration: () => const BoxDecoration(color: Colors.transparent),
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
                children: [
                  _buildActionButton(Icons.favorite, "42", Colors.red).end,
                  const SizedBox(height: 20),
                  _buildActionButton(Icons.chat_bubble_outline, "35", Colors.white).end,
                  const SizedBox(height: 20),
                  _buildActionButton(Icons.share, "52", Colors.white).end,
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.more_vert, color: Colors.white).end,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildUserInfo(context),
                        const SizedBox(height: 12),
                        const Divider(color: Colors.white24),
                        const SizedBox(height: 8),
                        _buildPostStats(),
                        const SizedBox(height: 12),
                        Text(
                          "Amazing weather today! Course was in perfect condition.",
                          style: TextStyle(
                            color: context.colors.tEXT_white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
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
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
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
                  CommonText(
                    text: "Ava Harper",
                    style: TextStyle(
                      color: context.colors.tEXT_white,
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
              Row(
                children: [
                  CommonText(
                    text: "Augusta National ",
                    style: TextStyle(color: context.colors.tEXT_subDark, fontSize: 12),
                  ),
                  const Icon(Icons.circle, size: 6, color: Color(0xffE3C97A)),
                  CommonText(
                    text: " California, USA",
                    style: TextStyle(color: context.colors.tEXT_subDark, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Text("23 minutes ago", style: TextStyle(color: Colors.white54, fontSize: 10)),
      ],
    );
  }

  Widget _buildPostStats() {
    return const Row(
      children: [
        Text("Date: 12 Jan, 2026", style: TextStyle(color: Colors.white, fontSize: 12)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(Icons.circle, size: 4, color: Colors.white),
        ),
        Text("Total Score: 45", style: TextStyle(color: Colors.white, fontSize: 12)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(Icons.circle, size: 4, color: Colors.white),
        ),
        Text("Holes: 9", style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
