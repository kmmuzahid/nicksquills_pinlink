import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/custom_card.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/features/leaderboard/widgets/friend_list_item_widget.dart';

@RoutePage()
class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      appBar: const CommonAppBar(),
      body: SmartListLoader(
        itemCount: 20 + 1,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _firstChild(context, 20);
          }
          return const FriendListItemWidget(name: 'Pete', course: 'Not set');
        },
      ),
    );
  }

  Column _firstChild(BuildContext context, int length) {
    return Column(
      children: [
        10.height,
        _buildAddFriendSection(context),
        10.height,
        // _buildStatusMessage(context),
        CommonButton(
          titleText: 'Invite Friends to Join PinLinks!',
          onTap: () {},
        ),
        10.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Friends',
              style: TextStyle(
                color: context.colors.tEXT_white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$length friends',
              style: TextStyle(
                color: context.colors.tEXT_subDark,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Input section for adding friends
  Widget _buildAddFriendSection(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: 'Add Friend',
            style: TextStyle(
              color: context.colors.tEXT_white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),

          CommonText(
            text: 'Add friend by username or email (they must have an account)',
            style: TextStyle(color: context.colors.tEXT_subDark, fontSize: 12),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(
                child: CommonTextField(
                  hintText: 'Enter email or username',
                  validationType: .validateEmail,
                ),
              ),
              const SizedBox(width: 12),
              CommonButton(
                titleText: 'Add',
                onTap: () {},
                buttonRadius: 30,
                buttonWidth: 80,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Small status bubble
  Widget _buildStatusMessage(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: context.colors.lightYellow.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: CommonText(
        text: 'Friend added. They\'ll show up here if they have an account.',
        style: TextStyle(color: context.colors.lightYellow, fontSize: 12),
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }

  // Reusable card for the friends list
}
