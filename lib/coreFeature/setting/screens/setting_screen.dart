import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/custom_card.dart';
import 'package:pinlink/common_widgets/custom_divider.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/bloc/cubit_scope_value.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/config/theme/cubit/theme_cubit.dart';
import 'package:pinlink/constant/app_string.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/coreFeature/navigation/widget/account_delete_widget.dart';
import 'package:pinlink/coreFeature/navigation/widget/logout_dailog.dart';
import 'package:pinlink/gen/assets.gen.dart';

@RoutePage()
class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      appBar: const CommonAppBar(title: 'Settings'),
      body: CustomScrollView(
        slivers: [
 
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                10.height,
                _buildSectionTitle(
                  context: context,
                  title: 'Account',
                  image: Assets.setting.editProfile,
                ),
                6.height,

                _accountSections(context),

                10.height,
                _buildSectionTitle(context: context, title: 'Theme', image: Assets.setting.theme),
                6.height,
                _theme(context),

                10.height,
                _buildSectionTitle(
                  context: context,
                  title: 'Privacy & Social',
                  image: Assets.setting.privacy,
                ),
                6.height,

                _privacy(context),

                10.height,
                _buildSectionTitle(
                  context: context,
                  title: 'Notifications',
                  image: Assets.setting.notification,
                ),
                6.height,
                _notifications(context),
                10.height,
                _buildSectionTitle(
                  context: context,
                  title: 'Gameplay Preferences',
                  image: Assets.setting.scores,
                ),
                6.height,

                CustomCard(
                  child: Column(
                    children: [
                      _buildMenuTileSwitch(
                        context: context,
                        title: 'Profanity Filter',
                        subtitle: 'Filter inappropriate content',
                        onSwitchChanged: (value) {
                          
                        },
                        image: Assets.setting.filter,
                      ),
                      const CustomDivider(),
                      _buildMenuTileSwitch(
                        context: context,
                        title: 'Played Courses',
                        subtitle: 'Show courses you\'ve played',
                        onSwitchChanged: (value) {
                         
                        },
                        image: Assets.setting.palyedCourses,
                      ),
                    ],
                  ),
                ),

                10.height,
                _buildSectionTitle(
                  context: context,
                  title: 'Support',
                  image: Assets.setting.support,
                ),
                6.height,

                _support(context),

              
                const SizedBox(height: 20),
                _buildActionButton(
                  context,
                  AppString.logout,
                  Icons.logout_outlined,
                  context.colors.sTATUS_error,
                  () {
                    showDialog<Widget>(
                      context: context,
                      builder: (context) => const Dialog(child: LogoutAlertWidget()),
                    );
                  },
                ),
               
                const SizedBox(height: 30),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  CustomCard _notifications(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          _buildMenuTileSwitch(
            context: context,
            title: 'Friend Requests',
            subtitle: 'Get notified when someone sends you a friend request',
            onSwitchChanged: (value) {},
            image: Assets.setting.editProfile,
          ),
          const CustomDivider(),
          _buildMenuTileSwitch(
            context: context,
            title: 'Leaderboard Updates',
            subtitle: 'Updates on your ranking and achievements',
            onSwitchChanged: (value) {},
            image: Assets.setting.showHandicap,
          ),
          const CustomDivider(),
          _buildMenuTileSwitch(
            context: context,
            title: 'Tournament Invites',
            subtitle: 'Get notified about tournament invitations',
            onSwitchChanged: (value) {},
            image: Assets.setting.subscriptions,
          ),
          const CustomDivider(),
          _buildMenuTileSwitch(
            context: context,
            title: 'Score Updates',
            subtitle: 'Notifications when friends post scores',
            onSwitchChanged: (value) {},
            image: Assets.setting.scores,
          ),
          const CustomDivider(),
          _buildMenuTileSwitch(
            context: context,
            title: 'Comments & Likes',
            subtitle: 'Interactions on your posts',
            onSwitchChanged: (value) {},
            image: Assets.setting.comment,
          ),
        ],
      ),
    );
  }

  CubitScopeValue<ThemeCubit, ThemeMode> _theme(BuildContext context) {
    return CubitScopeValue(
      cubit: context.read<ThemeCubit>(),
      builder: (context, cubit, state) {
        return _sigmentedButton(
          selectedTheme: state == ThemeMode.light ? ThemeType.light : ThemeType.dark,
          onTap: (p0) {
            cubit.toggleTheme();
          },
          context: context,
        );
      },
    );
  }

  CustomCard _privacy(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: _buildMenuTileSwitch(
        context: context,
        title: 'Show Handicap',
        subtitle: 'Display your handicap on your profile',
        image: Assets.setting.showHandicap,
        onSwitchChanged: (value) {},
      ),
    );
  }

  CustomCard _support(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          _buildMenuTile(
            context: context,
            title: 'About Us',
            onTap: () {
              appRouter.push(const AboutUsRoute());
            },
            image: Assets.setting.aboutUs,
          ),
          const CustomDivider(),
          _buildMenuTile(
            context: context,
            title: 'FAQ’s',
            onTap: () {
              appRouter.push(const FaqRoute());
            },
            image: Assets.setting.faq,
          ),
        ],
      ),
    );
  }

  CustomCard _accountSections(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          _buildMenuTile(
            context: context,
            title: 'Edit Profile',
            onTap: () {
              appRouter.push(const EditProfileRoute());
            },
            image: Assets.setting.editProfile,
          ),
          const CustomDivider(),
          _buildMenuTile(
            context: context,
            title: 'Change Password',
            onTap: () {
              appRouter.push(const ChangePasswordRoute());
            },
            image: Assets.setting.changePassword,
          ),
          const CustomDivider(),
          _buildMenuTile(
            context: context,
            title: 'Tournaments List',
            onTap: () {},
            image: Assets.setting.tournamentList,
          ),
          const CustomDivider(),
          _buildMenuTile(
            context: context,
            title: 'Talk to Support',
            onTap: () {},
            image: Assets.setting.talkToSupport,
          ),
          const CustomDivider(),
          _buildMenuTile(
            context: context,
            title: 'Subscription Management',
            onTap: () {},
            image: Assets.setting.subscriptions,
            subscriptionName: 'Free',
          ),
          const CustomDivider(),
          _buildMenuTile(
            context: context,
            title: 'Delete Account',
            onTap: () {
              showDialog<Widget>(
                context: context,
                builder: (context) => const Dialog(child: AccountDeleteWidget()),
              );
            },
            image: Assets.setting.delete,
            color: context.colors.sTATUS_error,
            enableTrail: false,
          ),

      
        ],
      ),
    );
  }
  Widget _buildSectionTitle({
    required BuildContext context,
    required String title,
    required String image,
  }) {
    return CommonText(
      preffix: CommonImage(
        src: image,
        size: 16,
        imageColor: context.colors.successVerifiedPositivestats_freshGrass,
      ),
      text: title,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: context.colors.tEXT_white),
    );
  }

 
  Widget _buildMenuTile({
    required BuildContext context,
    required String title,
    required Function() onTap,
    required String image,
    bool enableTrail = true,
    String? subscriptionName,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: context.colors.bACKGROUND_darkCard,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            CommonImage(src: image, imageColor: color ?? context.colors.tEXT_subDark, size: 20),
            CommonText(
              left: 10,
              text: title,
              fontSize: 16,
              style: TextStyle(color: color ?? context.colors.tEXT_white),
            ),
            const Spacer(),
            if (subscriptionName != null)
              CustomCard(
                child: CommonText(
                  left: 5,
                  right: 5,
                  text: subscriptionName,
                  textColor: context.colors.tEXT_subDark,
                  fontSize: 12,
                ),
              ),
            if (enableTrail) Icon(Icons.chevron_right, color: context.colors.tEXT_subDark),
          ],
        ),
      ),
    );
  }
  Widget _buildMenuTileSwitch({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String image,
    bool switchValue = true,
    Function(bool value)? onSwitchChanged,
    Color? color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: context.colors.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CommonImage(src: image, imageColor: color ?? context.colors.tEXT_subDark, size: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  left: 10,
                  text: title,
                  fontSize: 16,
                  style: TextStyle(color: color ?? context.colors.tEXT_white),
                ),
                CommonText(
                  left: 10,
                  text: subtitle,
                  fontSize: 14,
                  maxLines: 3,
                  textAlign: .left,
                  style: TextStyle(color: color ?? context.colors.tEXT_subDark),
                ),
              ],
            ),
          ),

          Transform.scale(
            scale: 0.8,
            child: Switch(
              activeThumbColor: context.colors.successVerifiedPositivestats_freshGrass,
              value: switchValue,
              onChanged: onSwitchChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    Function() onTap,
  ) {
    return CommonButton(
      buttonColor: color.withValues(alpha: .06),
      borderColor: color,
      buttonWidth: double.infinity,
      prefix: Icon(icon, color: color),
      titleText: label,
      titleColor: color,
      
      titleWeight: .w700,
      titleSize: 16,
      onTap: onTap,
      borderWidth: 1,
    );
  }

  
  Widget _sigmentedButton({
    required Function(ThemeType) onTap,
    required ThemeType selectedTheme,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colors.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colors.bACKGROUND_darkCard, width: 1.2),
      ),

      child: Row(
        children: [
          _buildSegmentButton(
            themeType: ThemeType.light,
            selectedTheme: selectedTheme,
            onTap: onTap,
            context: context,
          ),
          _buildSegmentButton(
            themeType: ThemeType.dark,
            selectedTheme: selectedTheme,
            onTap: onTap,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentButton({
    required ThemeType themeType,
    required ThemeType selectedTheme,
    required Function(ThemeType) onTap,
    required BuildContext context,
  }) {
    const radious = 8.0;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(themeType),
        child: Container(
          decoration: BoxDecoration(
            color: selectedTheme == themeType
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
                themeType == ThemeType.light ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                size: 16,
                color: context.colors.tEXT_white,
              ),
              text: themeType.displayName,
              textColor: context.colors.tEXT_white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
