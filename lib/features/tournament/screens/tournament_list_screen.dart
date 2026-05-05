import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/custom_card.dart';
import 'package:pinlink/common_widgets/custom_divider.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/color/app_color.dart';

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
              body: SmartListLoader(
                itemCount: 20 + 1,
                appbar: Column(
                  mainAxisSize: .min,
                  children: [
                    _statsSection(context),
                    10.height,
                    _search(context),
                    10.height,
                    _filter(context),
                  ],
                ),
                onColapsAppbar: Container(
                  color: context.colors.background,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      _search(context),
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
                  if (index == 0) {
                    return _tournamentCard(
                      context,
                      14,
                      FontWeight.w500,
                      column1: 'Tournament Name',
                      column2: 'Date & Time',
                      column3: 'Created By',
                      column4: 'Total Participants',
                    );
                  }
                  return _tournamentCard(
                    context,
                    12,
                    FontWeight.w400,
                    column1: 'Summer Golf Challenge',
                    column2: 'Jan 12, 10 am - Jan 13 4 pm',
                    column3: 'Mr’s Alex',
                    column4: '120',
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
              child: Center(
                child: CommonText(
                  text: column1,
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

  CommonTextField _search(BuildContext context) {
    return CommonTextField(
      validationType: .notRequired,
      borderRadius: 8,
      hintText: 'Search',
      backgroundColor: Colors.transparent,
      prefixIcon: Icon(Icons.search, color: context.colors.tEXT_subDark),
    );
  }

  Row _statsSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _statsBuilder(
            title: 'Created Tournament',
            value: '15',
            color: context.colors.tEXT_subDark,
            context: context,
          ),
        ),
        10.width,
        Expanded(
          child: _statsBuilder(
            title: 'Invited Tournaments',
            value: '15',
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
