import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/custom_card.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/enums.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconData,
    required this.onTap,
    required this.selectedFilter,
  });
  final MapFilters title;
  final String subtitle;
  final IconData iconData;
  final MapFilters? selectedFilter;
  final Function(MapFilters) onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedFilter == title;
    final color = isSelected
        ? context.colors.tEXT_white
        : context.colors.tEXT_subDark;

    return GestureDetector(
      onTap: () => onTap(title),
      child: CustomCard(
        width: (CoreScreenUtils.deviceSize.width - 30.w) / 4,
        padding: .symmetric(horizontal: 5.w, vertical: 8.h),
        margin: .only(bottom: 4.h),
        borderColor: context.colors.iconBorder,
        backgroundColor: context.colors.bACKGROUND_darkCard,
        child: Column(
          crossAxisAlignment: .center,
          children: [
            Icon(iconData, color: color, size: 25),
            const SizedBox(width: 8),
            CommonText(
              text: title.displayName,
              maxLines: 1,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w700,
              textColor: color,
            ),
            CommonText(
              textAlign: .left,
              text: subtitle,
              fontSize: 12,
              maxLines: 1,
              textColor: color,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
