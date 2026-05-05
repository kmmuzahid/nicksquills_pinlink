import 'package:core_kit/text/common_text.dart';
import 'package:core_kit/utils/core_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/custom_card.dart';
import 'package:pinlink/common_widgets/text_to_avater.dart';
import 'package:pinlink/config/color/app_color.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final textGrey = context.colors.tEXT_subDark;

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section: Avatar, Name, and Location
          Row(
            children: [
              TextToAvatar(text: 'J', size: 50.w, color: const Color(0xFF00BC7D)),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: context.colors.tEXT_white,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: textGrey, size: 16),
                      const SizedBox(width: 4),
                      Text('Northern Ireland', style: TextStyle(color: textGrey, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Stats Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: .max,
            children: [
              _buildStat('11', 'HCP', context),
              _buildDivider(context),
              _buildStat('2,847', 'Points', context),
              _buildDivider(context),
              _buildStat('24', 'followings', context),
              _buildDivider(context),
              _buildStat('24', 'followers', context),
            ],
          ),
          const SizedBox(height: 20),

          // Home Course Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: context.colors.background,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFF04452B),
                  child: Icon(Icons.location_on_outlined, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: 'Home Course',
                        style: TextStyle(color: textGrey, fontSize: 12),
                      ),
                      CommonText(
                        text: 'Pebble Beach Golf Links',
                        style: TextStyle(
                          color: context.colors.tEXT_white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.info_outline, color: textGrey, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        CommonText(
          text: value,
          style: TextStyle(
            color: context.colors.tEXT_white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 4),
        CommonText(
          text: label,
          style: TextStyle(color: context.colors.tEXT_subDark, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(height: 15.h, width: 1.5, color: context.colors.bACKGROUND_darkCardBoarder);
  }
}
