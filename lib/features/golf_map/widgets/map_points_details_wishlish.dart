import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/custom_card.dart';
import 'package:pinlink/config/color/app_color.dart';

class MapPointsDetailsWishlish extends StatelessWidget {
  const MapPointsDetailsWishlish({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xffFB2C36).withValues(alpha: 0.3),
            ),
            padding: const EdgeInsets.all(10),
            child: const Icon(Icons.favorite, color: Color(0xffFB2C36), size: 20),
          ),
          10.width,

          Column(
            crossAxisAlignment: .start,
            children: [
              CommonText(
                text: 'Royal Melbourne',
                fontSize: 14,
                fontWeight: .bold,
                textColor: context.colors.tEXT_white,
              ),
              CommonText(text: 'Australia', fontSize: 12, textColor: context.colors.tEXT_sub),
            ],
          ),
          10.width,

          CommonButton(
            titleText: 'Mark Played',
            titleColor: const Color(0xff10B981),
            buttonHeight: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            buttonRadius: 30,
            buttonColor: const Color(0xff10B981).withValues(alpha: 0.1),
          ),
        ],
      ),
    );
  }
}
