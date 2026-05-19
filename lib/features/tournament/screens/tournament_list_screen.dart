import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/custom_card.dart';
import 'package:pinlink/common_widgets/custom_divider.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/common_widgets/text_to_avater.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/features/tournament/cubit/tournament_cubit.dart';
import 'package:pinlink/features/tournament/model/tournament_info_model.dart';
import 'package:pinlink/features/tournament/model/tournament_model.dart';

@RoutePage()
class TournamentListScreen extends StatelessWidget {
  const TournamentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      appBar: const CommonAppBar(title: 'Tournament List'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Expanded(
          child: SafeArea(
            top: false,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              body: CubitScope(
                create: () => TournamentCubit(),
                builder: (context, cubit, state) {
                  return SmartListLoader(
                    itemCount: state.tournamentList.length,
                    isLoading: state.isLoading,
                    onRefresh: () {
                      cubit.getTournamentList(isRefresh: true);
                    },
                    onLoadMore: (page) {
                      cubit.getTournamentList(page: page);
                    },
                    appbar: Column(
                      mainAxisSize: .min,
                      children: [
                        _statsSection(context, state.tournamentInfoModel),
                        10.height,
                        _search(context, cubit),
                        // 10.height,
                        // _filter(context),
                        8.height,
                        _tournamentCard(
                          context,
                          14,
                          FontWeight.w500,
                          column1: 'Tournament Name',
                          column2: 'Date & Time',
                          column3: 'Created By',
                          column4: 'Total Participants',
                        ),
                      ],
                    ),
                    onColapsAppbar: Container(
                      color: context.colors.background,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        children: [
                          _search(context, cubit),
                          4.height,
                          _tournamentCard(
                            context,
                            14,
                            FontWeight.w500,
                            column1: 'Tournament Name',
                            column2: 'Date & Time',
                            column3: 'Created By',
                            column4: 'Total Participants',
                          ),
                        ],
                      ),
                    ),
                    itemBuilder: (context, index) {
                      final tournament = state.tournamentList[index];
                      return GestureDetector(
                        onTap: () {
                          _showFriendsDialog(context, tournament.friendList);
                        },
                        child: _tournamentCard(
                          context,
                          12,
                          FontWeight.w400,
                          column1: tournament.name ?? 'N/A',
                          column2:
                              '${DateTime.tryParse(tournament.startDate ?? '')?.date} - ${DateTime.tryParse(tournament.endDate ?? '')?.date}',
                          column3: tournament.userId?.fullName ?? 'N/A',
                          column4:
                              tournament.friendList?.length.toString() ?? '0',
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tournamentCard(
    BuildContext context,
    double fontSize,
    FontWeight fontWeight, {
    required String column1,
    required String column2,
    required String column3,
    required String column4,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CommonText(
                text: column1,
                textColor: context.colors.tEXT_subDark,
                fontSize: fontSize,
                fontWeight: fontWeight,
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: CommonText(
                  text: column2,
                  textColor: context.colors.tEXT_subDark,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: CommonText(
                  text: column3,
                  textColor: context.colors.tEXT_subDark,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: CommonText(
                  text: column4,
                  textColor: context.colors.tEXT_subDark,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),

        const CustomDivider(),
      ],
    );
  }

  void _showFriendsDialog(BuildContext context, List<FriendList?>? friendList) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.colors.bACKGROUND_darkCard,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: context.colors.bACKGROUND_darkCardBoarder,
                width: 1.4,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(
                      text: 'Participants (${friendList?.length ?? 0})',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      textColor: context.colors.tEXT_white,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(dialogContext),
                      child: Icon(
                        Icons.close,
                        color: context.colors.tEXT_white,
                      ),
                    ),
                  ],
                ),
                16.height,
                if (friendList == null || friendList.isEmpty)
                  CommonText(
                    text: 'No participants yet.',
                    textColor: context.colors.tEXT_subDark,
                  ).center
                else
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: context.colors.bACKGROUND_darkCardBoarder,
                        );
                      },
                      itemCount: friendList.length,
                      itemBuilder: (context, index) {
                        final friend = friendList[index];
                        if (friend == null) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              friend.profile != null &&
                                      friend.profile!.isNotEmpty
                                  ? CommonImage(
                                      src: friend.profile!,
                                      borderRadius: 22,
                                      height: 44,
                                      width: 44,
                                    )
                                  : TextToAvatar(
                                      text: friend.fullName ?? '',
                                      color: Colors.teal,
                                      limit: 1,
                                      fontSize: 16,
                                      size: 44,
                                    ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CommonText(
                                  text: friend.fullName ?? '',
                                  textColor: context.colors.tEXT_white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Row _filter(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CommonDropDown(
            hint: 'Status',
            suffixIcon: Icon(
              Icons.arrow_forward_ios,
              color: context.colors.tEXT_subDark,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            backgroundColor: Colors.transparent,
            borderRadius: 8,
            items: const [],
            onChanged: (value) {},
            nameBuilder: (value) => CommonText(
              text: value.item,
              textColor: context.colors.tEXT_subDark,
            ),
          ),
        ),
        10.width,

        Expanded(
          child: CommonDateInputTextField(backgroundColor: Colors.transparent),
        ),
      ],
    );
  }

  CommonTextField _search(BuildContext context, TournamentCubit cubit) {
    return CommonTextField(
      validationType: .notRequired,
      borderRadius: 8,
      hintText: 'Search',
      backgroundColor: Colors.transparent,
      prefixIcon: Icon(Icons.search, color: context.colors.tEXT_subDark),
      onChanged: (value) {
        cubit.search(value);
      },
    );
  }

  Row _statsSection(
    BuildContext context,
    TournamentInfoModel? tournamentInfoModel,
  ) {
    return Row(
      children: [
        Expanded(
          child: _statsBuilder(
            title: 'Created Tournament',
            value:
                tournamentInfoModel?.allCreatedTournamentCount.toString() ?? '',
            color: context.colors.tEXT_subDark,
            context: context,
          ),
        ),
        10.width,
        Expanded(
          child: _statsBuilder(
            title: 'Invited Tournaments',
            value:
                tournamentInfoModel?.allInvitedTournamentCount.toString() ?? '',
            color: context.colors.ratingPremiumTags_goldAccent,
            context: context,
          ),
        ),
      ],
    );
  }

  CustomCard _statsBuilder({
    required String title,
    required String value,
    required Color color,
    required BuildContext context,
  }) {
    return CustomCard(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          CommonText(
            text: title,
            fontSize: 14,
            textColor: context.colors.tEXT_subDark,
            maxLines: 2,
          ),
          CommonText(
            text: value,
            textColor: color,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ],
      ),
    );
  }
}
