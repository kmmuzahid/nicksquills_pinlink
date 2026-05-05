import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/common_widget.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/features/leaderboard/widgets/friend_list_item_widget.dart';

@RoutePage()
class BuildTournamentScreen extends StatelessWidget {
  const BuildTournamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      appBar: const CommonAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SmartListLoader(
              padding: Constants.bodyPadding,
              itemCount: 20,
              appbar: _appBar(context),
              onColapsAppbar: Container(
                padding: Constants.bodyPadding,
                color: context.colors.background,
                child: _onColupse(context),
              ),
              itemBuilder: (context, index) {
                return FriendListItemWidget(
                  name: 'Pete',
                  course: 'Not set',
                  isSelected: index == 0,
                );
              },
            ),
          ),

          _bottomSections(),
        ],
      ),
    );
  }

  Widget _bottomSections() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const BuildLabel('Start Date'),
                      CommonDateInputTextField(borderRadius: 40),
                    ],
                  ),
                ),
                10.width,
                Expanded(
                  child: Column(
                    children: [
                      const BuildLabel('End Date'),
                      CommonDateInputTextField(borderRadius: 40),
                    ],
                  ),
                ),
              ],
            ),
            8.height,
            CommonButton(buttonWidth: .infinity, titleText: 'Create Tournament', onTap: () {}),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Padding(
      padding: Constants.bodyPadding,
      child: Column(
        children: [
          20.height,
          CommonText(
            text: 'Build a Tournament',
            fontSize: 24,
            fontWeight: .w500,
            textColor: context.colors.tEXT_white,
          ).center,
          CommonText(
            text: 'Create a private points competition with your friends',
            fontSize: 14,
            maxLines: 2,
            textAlign: .center,
            textColor: context.colors.tEXT_subDark,
          ).center,
          10.height,
          const BuildLabel('Tournament Name'),
          CommonTextField(
            validationType: .notRequired,
            borderColor: context.colors.bACKGROUND_darkCardBoarder,
            backgroundColor: Colors.transparent,
            hintText: 'e.g., Summer Golf Challenge',
          ),
          _onColupse(context),
        ],
      ),
    );
  }

  Widget _onColupse(BuildContext context) {
    return Column(
      children: [
        8.height,
        Row(
          children: [
            const BuildLabel('Select Friend'),
            const Spacer(),
            CommonText(
              text: '3 friends selected',
              fontSize: 12,
              textColor: context.colors.tEXT_subDark,
            ),
          ],
        ),
        CommonTextField(
          validationType: .notRequired,
          backgroundColor: Colors.transparent,
          borderColor: context.colors.bACKGROUND_darkCardBoarder,
          hintText: 'Search',
        ),
        4.height,
      ],
    );
  }
}
