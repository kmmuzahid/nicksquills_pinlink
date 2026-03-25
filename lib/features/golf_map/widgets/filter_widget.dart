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
    return GestureDetector(
      onTap: () => onTap(title),
      child: CustomCard(
        borderColor: selectedFilter == title ? Colors.transparent : null,
        backgroundColor: selectedFilter == title ? Colors.transparent : null,
        height: 80,
        child: Row(
          crossAxisAlignment: .start,
          children: [
            Icon(iconData, color: context.colors.tEXT_subDark, size: 15),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: title.displayName,
                    fontSize: 14,
                    fontWeight: .bold,
                    textColor: context.colors.tEXT_white,
                  ),
                  CommonText(
                    textAlign: .left,
                    text: subtitle,
                    fontSize: 12,
                    maxLines: 2,
                    textColor: context.colors.tEXT_subDark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
