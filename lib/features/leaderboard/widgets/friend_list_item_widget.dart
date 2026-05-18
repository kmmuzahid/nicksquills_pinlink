import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/custom_card.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/features/leaderboard/model/friend_model.dart';

class FriendListItemWidget extends StatelessWidget {
  const FriendListItemWidget({
    super.key,
    this.isSelected = false,
    required this.friend,
  });

  final FriendModel friend;
  final bool isSelected;

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
                friend.profile != null || friend.profile?.isNotEmpty == true
                    ? CommonImage(src: friend.profile!, borderRadius: 22)
                    : CircleAvatar(
                        radius: 22.r,
                        backgroundColor: Colors.teal,
                        child: Text(
                          friend.fullName ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: friend.fullName ?? '',
                        style: TextStyle(
                          color: context.colors.tEXT_white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      CommonText(
                        text: 'Home Course: ${friend.homeCourse ?? 'Not Set'}',
                        style: TextStyle(
                          color: context.colors.tEXT_subDark,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  CustomCard(
                    borderRadius: 40,
                    padding: const EdgeInsets.all(5),
                    backgroundColor:
                        context.colors.successVerifiedPositivestats_freshGrass,
                    child: const Icon(
                      Icons.check,
                      size: 21,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: .horizontal,
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  _buildStat(context, 'Points', '1245'),
                  const SizedBox(width: 16),
                  _buildStat(context, 'Played courses', '47'),

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
        Text(
          label,
          style: TextStyle(color: context.colors.tEXT_subDark, fontSize: 12),
        ),
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
