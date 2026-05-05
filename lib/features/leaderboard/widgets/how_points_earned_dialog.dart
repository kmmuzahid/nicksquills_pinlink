import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';

class HowPointsEarnedDialog extends StatelessWidget {
  const HowPointsEarnedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.colors.bACKGROUND_darkCardBoarder,
          width: 1.2,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: 'How Points Are Earned',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            textColor: context.colors.tEXT_white,
          ),
          8.height,
          _buildPointItem(
            context,
            'Signing up as ',
            '+100 pts',
            highlightedText: '"Pro tier"',
          ),
          8.height,
          _buildPointItem(context, 'Playing a PinLinks 5', '+100 pts'),
          8.height,
          _buildPointItem(context, 'New lowest score', '+50 pts'),
          8.height,
          _buildPointItem(
            context,
            'Playing & rating a course from wishlist',
            '+35 pts',
          ),
          8.height,
          _buildPointItem(context, 'Signing up the referral friend', '+30 pts'),
          8.height,
          _buildPointItem(context, 'Playing & rating a new course', '+25 pts'),
          8.height,
          _buildPointItem(context, 'Create a post', '+15 pts'),
          8.height,
          _buildPointItem(context, 'Traveling 100+ miles', '+0.1pts / mi'),
        ],
      ),
    );
  }

  Widget _buildPointItem(
    BuildContext context,
    String text,
    String points, {
    String? highlightedText,
  }) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(
            Icons.circle,
            size: 6,
            color: context.colors.tEXT_subDark.withOpacity(0.6),
          ),
        ),
        12.width,
        Expanded(
          child: Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: context.colors.tEXT_subDark.withOpacity(0.8),
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(text: text),
                if (highlightedText != null)
                  TextSpan(
                    text: highlightedText,
                    style: TextStyle(
                      color: context
                          .colors
                          .successVerifiedPositivestats_freshGrass,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ),
        CommonText(
          text: points,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          textColor: context.colors.successVerifiedPositivestats_freshGrass,
        ),
      ],
    );
  }
}
