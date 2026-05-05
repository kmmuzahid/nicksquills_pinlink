import 'package:core_kit/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';

class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget({super.key, required this.title, required this.description});
  final String title;
  final String description;

  // Info card at the top
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.bACKGROUND_darkCardBoarder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: context.colors.lightYellow, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: title,
                  fontSize: 16,
                  fontWeight: .bold,
                  textColor: context.colors.lightYellow,
                ),
                const SizedBox(height: 4),
                CommonText(
                  textAlign: .left,
                  text: description,
                  fontSize: 14,
                  maxLines: 100,
                  textColor: context.colors.tEXT_subDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
