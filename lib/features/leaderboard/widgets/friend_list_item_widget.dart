import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/custom_card.dart';
import 'package:pinlink/config/color/app_color.dart';

class FriendListItemWidget extends StatelessWidget {
  const FriendListItemWidget({super.key, required this.name, required this.course});

  final String name;
  final String course;

  @override
  Widget build(BuildContext context) {
    return _buildFriendCard(context);
  }

  Widget _buildFriendCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: Colors.teal,
                  child: Text(
                    name[0],
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: name,
                        style: TextStyle(
                          color: context.colors.tEXT_white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      CommonText(
                        text: 'Home Course: $course',
                        style: TextStyle(color: context.colors.tEXT_subDark, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: .horizontal,
              child: Row(
                children: [
                  _buildStat(context, 'Points', '1245'),
                  const SizedBox(width: 16),
                  _buildStat(context, 'Played courses', '47'),
                  const SizedBox(width: 16),
                  _buildStat(context, 'Played Round', '24'),
                  const SizedBox(width: 16),
                  _buildStat(context, 'Travel Distance', '1246 mi'),
                  const SizedBox(width: 16),
                  _buildStat(context, 'Played PinLinks 5', '8 times'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: TextStyle(color: context.colors.tEXT_subDark, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: context.colors.tEXT_white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
