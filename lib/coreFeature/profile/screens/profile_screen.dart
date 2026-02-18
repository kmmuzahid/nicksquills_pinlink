import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/appbar/appbar_simple.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/app_string.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/navigation/widget/account_delete_widget.dart';
import 'package:pinlink/coreFeature/navigation/widget/logout_dailog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            surfaceTintColor: Colors.transparent,
            expandedHeight: 230.h,
            toolbarHeight: 230.h,
            pinned: true,
            floating: false,
            backgroundColor: Colors.transparent,
            leading: const SizedBox.shrink(),
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                // final top = constraints.biggest.height;
                // final isCollapsed = top <= MediaQuery.of(context).padding.top + kToolbarHeight;
                // return isCollapsed ? appBar() : _buildHeader();

                return FlexibleSpaceBar(
                  collapseMode: .pin,
                  title: const SizedBox.shrink(),
                  background: _buildHeader(),
                );
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildNotificationSwitch(),
                // _buildMenuTile(AppString.payment_history, () {
                //   if (authCubit.state.role == Role.EV_OWNER) {
                //     context.read<NavigationCubit>().changeIndex(2);
                //   }
                // }),
                _buildSectionTitle(AppString.account),
                _buildMenuTile(AppString.change_password, () {
                  appRouter.push(const ChangePasswordRoute());
                }),
                _buildMenuTile(AppString.personal_information, () {
                  appRouter.push(const PersonalInformationRoute());
                }),
                _buildMenuTile(AppString.faqs, () {
                  appRouter.push(const FaqRoute());
                }),
                _buildMenuTile(AppString.about_us, () {
                  appRouter.push(const AboutUsRoute());
                }),
                const SizedBox(height: 20),
                _buildActionButton(AppString.logout, Icons.logout_outlined, AppColor.textGray, () {
                  showDialog<Widget>(
                    context: context,
                    builder: (context) => const Dialog(child: LogoutAlertWidget()),
                  );
                }),
                15.height,
                _buildActionButton(
                  AppString.delete_account,
                  Icons.delete_outline,
                  AppColor.textGray,
                  () {
                    showDialog<Widget>(
                      context: context,
                      builder: (context) => const Dialog(child: AccountDeleteWidget()),
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

  Widget appBar() {
    return AppBarSimple(
      hideBack: true,
      titleWidget: Row(
        children: [
          10.width,
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: CommonImage(
              src: 'https://picsum.photos/id/1/200/300',
              size: 100,
              borderRadius: 100,
            ),
          ),
          10.width,
          const Text(
            "Mr's Alex",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Serif'),
          ),
          const SizedBox(width: 5),
          const Icon(Icons.edit, size: 16, color: Colors.white),
        ],
      ),
      actions: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.notifications_none, color: Colors.green),
        ),
      ],
      title: '',
    );
  }

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        const Positioned.fill(child: SizedBox(height: 230, width: double.infinity)),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 160.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColor.secondary, AppColor.primary],
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(50.r)),
            ),
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.notifications_none, color: Colors.green),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          child: Column(
            children: [
              Text(
                AppString.profile,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              10.height,
              const CommonImage(
                src: 'https://picsum.photos/id/28/200/300',
                borderRadius: 100,
                size: 100,
              ),
              const SizedBox(height: 10),
              const CommonText(
                text: "Mr's Alex",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                textColor: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
      ),
    );
  }

  Widget _buildNotificationSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          text: AppString.notification,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          textColor: Colors.black87,
        ),
        Transform.scale(
          scale: .7, // Increases the size by 50%
          child: Switch(
            value: true,
            onChanged: (val) {},
            activeThumbColor: Colors.cyan,
            inactiveThumbColor: AppColor.outlineColor,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuTile(String title, Function() onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: AppColor.listMenuColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.black54)),
        trailing: const Icon(Icons.chevron_right, color: Colors.blue),
        onTap: onTap,
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, Function() onTap) {
    return CommonButton(
      buttonColor: AppColor.background,
      borderColor: color,
      buttonWidth: double.infinity,
      prefix: Icon(icon, color: color),
      titleText: label,
      titleColor: color,
      onTap: onTap,
      borderWidth: 1,
    );
  }
}
