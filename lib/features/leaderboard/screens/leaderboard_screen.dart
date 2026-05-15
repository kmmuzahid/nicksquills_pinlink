import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/common_widget.dart';
import 'package:pinlink/common_widgets/custom_card.dart';
import 'package:pinlink/common_widgets/info_card_widget.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/common_widgets/text_to_avater.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/leaderboard/cubit/leaderboard_cubit.dart';
import 'package:pinlink/features/leaderboard/cubit/leaderboard_state.dart';
import 'package:pinlink/features/leaderboard/model/leaderboard_model.dart';
import 'package:pinlink/features/leaderboard/widgets/how_points_earned_dialog.dart';
import 'package:pinlink/gen/assets.gen.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final GlobalKey _infoIconKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      body: CubitScope(
        create: () => LeaderboardCubit()..fetchLeaderboard(),
        builder: (context, cubit, state) {
          return SmartListLoader(
            itemCount: state.leaderboardList.isEmpty
                ? 1
                : 2 +
                      (state.leaderboardList.length > 3
                          ? state.leaderboardList.length - 3
                          : 0),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              if (index == 0) {
                return _topChild(context, state, cubit);
              }

              if (index == 1) {
                return _buildPodiumSection(
                  context,
                  state.searchType,
                  state.leaderboardList.take(3).toList(),
                );
              }

              final model = state.leaderboardList[index + 1];
              return _buildRankList(
                context,
                name: model.name ?? "",
                points: model.pointCount ?? 0,
                miles: state.searchType == LeaderboardSearchType.TravelDistance
                    ? model.miles
                    : null,
                course:
                    state.searchType == LeaderboardSearchType.MostCoursesPlayed
                    ? model.totalCourses
                    : null,
                times:
                    state.searchType ==
                        LeaderboardSearchType.PlayedMostPinLinks5Courses
                    ? model.playCount
                    : null,
                rank: index + 2,
              );
            },
          );
        },
      ),
    );
  }

  Column _topChild(
    BuildContext context,
    LeaderboardState state,
    LeaderboardCubit cubit,
  ) {
    return Column(
      children: [
        Row(
          children: [
            CommonText(
              text: "Check out top players and courses",
              textColor: context.colors.tEXT_subDark,
              fontSize: 16,
            ),
            const Spacer(),
            IconButton(
              key: _infoIconKey,
              onPressed: () {
                final renderBox =
                    _infoIconKey.currentContext!.findRenderObject()
                        as RenderBox;
                final offset = renderBox.localToGlobal(Offset.zero);
                final size = renderBox.size;

                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: 'Dismiss',
                  barrierColor: Colors.black.withOpacity(0.3),
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return Stack(
                      children: [
                        Positioned(
                          left: 20,
                          right: 20,
                          top: offset.dy + size.height + 10,
                          child: FadeTransition(
                            opacity: animation,
                            child: const Material(
                              color: Colors.transparent,
                              child: HowPointsEarnedDialog(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.info_outline,
                size: 20,
                color: context.colors.tEXT_subDark,
              ),
            ),
          ],
        ),
        const InfoCardWidget(
          title: 'Automatic Rankings',
          description:
              'Rankings update automatically when you add or compare courses using Add / Play.',
        ),
        const SizedBox(height: 15),
        _buildActionButtons(context),
        const SizedBox(height: 6),
        _buildSegmentedButton(
          selectedLeaderboardType: state.leaderboardType,
          onTap: (p0) {
            cubit.changeLeaderboardType(p0);
          },
          context: context,
        ),
        const SizedBox(height: 10),
        const BuildLabel("Search by"),
        CommonDropDown<LeaderboardSearchType>(
          borderRadius: 8,
          backgroundColor: context.colors.bACKGROUND_darkCard,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          textStyle: TextStyle(color: context.colors.tEXT_white, fontSize: 14),
          initalValue: state.searchType,
          hint: "Search by",
          items: LeaderboardSearchType.values,
          onChanged: (value) {
            if (value == null) return;
            cubit.changeSearchType(value);
          },
          nameBuilder: (value) => CommonText(
            text: value.item.displayName,
            textColor: context.colors.tEXT_subDark,
            fontSize: 14,
          ),
        ),
        10.height,
      ],
    );
  }

  // Button row (Build Tournament / Add Friend)
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        CommonButton(
          buttonHeight: 36,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          titleText: 'Build a Tournament',
          onTap: () {
            appRouter.push(const BuildTournamentRoute());
          },
          prefix: const Icon(Icons.calendar_today, size: 16),
        ),
        const SizedBox(width: 10),
        CommonButton(
          buttonHeight: 36,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          titleText: 'Add Friend',
          onTap: () {
            appRouter.push(const FriendsRoute());
          },
          prefix: const Icon(Icons.person_add, size: 16),
        ),
      ],
    );
  }

  // The 1, 2, 3 Podium section
  Widget _buildPodiumSection(
    BuildContext context,
    LeaderboardSearchType searchType,
    List<LeaderboardModel> users,
  ) {
    const rank1Gradient = LinearGradient(
      colors: [Color(0xFFFEEF8A), Color(0xFFDD971B)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    const rank2Gradient = LinearGradient(
      colors: [Color(0xFF6c7484), Color(0xFF929aa8)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    const rank3Gradient = LinearGradient(
      colors: [Color(0xFF734326), Color(0xFFac6b42)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: context.colors.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Podium order: Rank 2, Rank 1, Rank 3
              if (users.length >= 2)
                _podiumUser(
                  context,
                  rank2Gradient,
                  80.w,
                  name: users[1].name ?? "",
                  points: users[1].pointCount ?? 0,
                  rankSvg: Assets.images.rank2,
                  miles: searchType == LeaderboardSearchType.TravelDistance
                      ? users[1].miles
                      : null,
                  course: searchType == LeaderboardSearchType.MostCoursesPlayed
                      ? users[1].totalCourses
                      : null,
                  times:
                      searchType ==
                          LeaderboardSearchType.PlayedMostPinLinks5Courses
                      ? users[1].playCount
                      : null,
                  rank: 2,
                ),
              if (users.isNotEmpty)
                _podiumUser(
                  context,
                  rank1Gradient,
                  100.w,
                  name: users[0].name ?? "",
                  points: users[0].pointCount ?? 0,
                  rankSvg: Assets.images.rank1,
                  miles: searchType == LeaderboardSearchType.TravelDistance
                      ? users[0].miles
                      : null,
                  course: searchType == LeaderboardSearchType.MostCoursesPlayed
                      ? users[0].totalCourses
                      : null,
                  times:
                      searchType ==
                          LeaderboardSearchType.PlayedMostPinLinks5Courses
                      ? users[0].playCount
                      : null,
                  rank: 1,
                ),
              if (users.length >= 3)
                _podiumUser(
                  context,
                  rank3Gradient,
                  80.w,
                  name: users[2].name ?? "",
                  points: users[2].pointCount ?? 0,
                  rankSvg: Assets.images.rank3,
                  miles: searchType == LeaderboardSearchType.TravelDistance
                      ? users[2].miles
                      : null,
                  course: searchType == LeaderboardSearchType.MostCoursesPlayed
                      ? users[2].totalCourses
                      : null,
                  times:
                      searchType ==
                          LeaderboardSearchType.PlayedMostPinLinks5Courses
                      ? users[2].playCount
                      : null,
                  rank: 3,
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _getMiddleText({
    required int? course,
    required double? miles,
    required int? times,
  }) {
    if (course != null) return "$course courses";
    if (miles != null) return "$miles miles";
    if (times != null) return "$times times";
    return "";
  }

  Widget _podiumUser(
    BuildContext context,
    Gradient gradient,
    double height, {
    required String name,
    int? course,
    double? miles,
    int? times,
    required int rank,
    required int points,
    String? rankSvg,
  }) {
    return Column(
      children: [
        if (rank == 1)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(rankSvg!, height: 30, width: 23),
          ),
        if (rank == 1)
          TextToAvatar(size: height + 10, text: name, gradient: gradient),
        if (rank != 1)
          SizedBox(
            height: height,
            width: height + 10,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    padding: const EdgeInsets.only(right: 5),
                    child: TextToAvatar(
                      size: height + 10,
                      text: name,
                      gradient: gradient,
                    ),
                  ),
                ),
                if (rankSvg != null)
                  Positioned(
                    top: 5,
                    right: 0,
                    child: SvgPicture.asset(rankSvg, height: 30, width: 23),
                  ),
              ],
            ),
          ),
        const SizedBox(height: 8),
        CommonText(
          text: name,
          minFontSize: 12,
          fontSize: 14,
          fontWeight: .bold,
          textColor: context.colors.tEXT_white,
        ),
        CommonText(
          text: '$points points',
          fontSize: 12,
          textColor: context.colors.tEXT_white,
        ),
        if (course != null || miles != null || times != null)
          CommonText(
            text: _getMiddleText(course: course, miles: miles, times: times),
            fontSize: 12,
            textColor: context.colors.tEXT_subDark,
          ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Center(
            child: Text(
              rank.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Rank list for 4, 5, 6...
  Widget _buildRankList(
    BuildContext context, {
    required String name,
    int? course,
    double? miles,
    int? times,
    required int rank,
    required int points,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: CustomCard(
        child: Row(
          crossAxisAlignment: .center,
          children: [
            Text(
              "$rank",
              style: TextStyle(
                color: context.colors.tEXT_white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            10.width,
            TextToAvatar(text: name, color: Colors.grey, fontSize: 16),
            10.width,
            Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: context.colors.tEXT_white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  _getMiddleText(course: course, miles: miles, times: times),
                  style: TextStyle(
                    color: context.colors.tEXT_subDark,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            CustomCard(
              child: Column(
                mainAxisSize: .min,
                mainAxisAlignment: .center,
                children: [
                  CommonText(
                    text: "$points",
                    textColor: context.colors.tEXT_white,
                    fontSize: 14,
                    fontWeight: .w600,
                    textAlign: .center,
                  ),
                  CommonText(
                    text: "Points",
                    textColor: context.colors.tEXT_subDark,
                    fontSize: 12,
                    textAlign: .center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedButton({
    required Function(LeaderboardType) onTap,
    required LeaderboardType selectedLeaderboardType,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colors.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: context.colors.bACKGROUND_darkCard,
          width: 1.2,
        ),
      ),

      child: Row(
        children: [
          _buildSegmentButton(
            leaderboardType: LeaderboardType.pinLinksWorldRankings,
            selectedLeaderboardType: selectedLeaderboardType,
            onTap: onTap,
            context: context,
          ),
          _buildSegmentButton(
            leaderboardType: LeaderboardType.friends,
            selectedLeaderboardType: selectedLeaderboardType,
            onTap: onTap,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentButton({
    required LeaderboardType leaderboardType,
    required LeaderboardType selectedLeaderboardType,
    required Function(LeaderboardType) onTap,
    required BuildContext context,
  }) {
    const radious = 40.0;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(leaderboardType),
        child: Container(
          decoration: BoxDecoration(
            color: selectedLeaderboardType == leaderboardType
                ? context.colors.bACKGROUND_darkPage
                : Colors.transparent,

            borderRadius: const BorderRadius.all(Radius.circular(radious)),
          ),
          child: Center(
            child: CommonText(
              left: 10,
              right: 10,
              top: 8,
              bottom: 8,
              preffix: Icon(
                leaderboardType == LeaderboardType.pinLinksWorldRankings
                    ? Icons.emoji_events_outlined
                    : Icons.group,
                size: 16,
                color: context.colors.tEXT_white,
              ),
              text: leaderboardType.displayName,
              textColor: context.colors.tEXT_white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
