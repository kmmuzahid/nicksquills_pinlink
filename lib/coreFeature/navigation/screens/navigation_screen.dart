/*
 * @Author: Km Muzahid
 * @Date: 2026-02-18 09:39:56
 * @Email: km.muzahid@gmail.com
 */
/*
 * @Author: Km Muzahid
 * @Date: 2026-02-01 09:37:24
 * @Email: km.muzahid@gmail.com
 */
/*
 * @Author: Km Muzahid
 * @Date: 2026-01-12 16:57:56
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/bloc/cubit_scope_value.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/coreFeature/navigation/cubit/navigation_cubit.dart';
import 'package:pinlink/coreFeature/navigation/cubit/navigation_state.dart';
import 'package:pinlink/coreFeature/navigation/nav_utils/navigator_item.dart';
import 'package:pinlink/features/course_comparision/screens/add_course_screen.dart';
import 'package:pinlink/features/golf_map/screens/golf_map_screen.dart';
import 'package:pinlink/features/leaderboard/screens/leaderboard_screen.dart';
import 'package:pinlink/features/profile/screens/profile_screen.dart';
import 'package:pinlink/features/social/screens/social_screen.dart';
import 'package:pinlink/gen/assets.gen.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

@RoutePage()
class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  List<NavigatorItem> getpage() {
    final evItems = <NavigatorItem>[
      NavigatorItem(
        imagePath: Assets.navigators.social,
        screen: const SocialScreen(),
        label: 'Socia',
      ),
      NavigatorItem(
        imagePath: Assets.navigators.leaderboard,
        screen: const LeaderboardScreen(),
        label: 'Leaderboard',
      ),

      centerItem(),

      NavigatorItem(imagePath: Assets.navigators.map, screen: const GolfMapScreen(), label: 'Map'),
      NavigatorItem(
        imagePath: Assets.navigators.profile,
        screen: const ProfileScreen(),
        label: 'My Profile',
      ),
    ];

    return evItems;
  }

  NavigatorItem centerItem() => NavigatorItem(
    imagePath: Assets.navigators.addCourse,
    screen: const AddCourseScreen(enableSafeArea: false, isInNavigation: true),
    label: 'Add Course',
  );

  @override
  Widget build(BuildContext context) {
    return CubitScopeValue(
      cubit: context.read<NavigationCubit>(),
      builder: (context, cubit, state) {
        var title = '';
        if (state.currentIndex == 0) {
          title = 'Friends Feed';
        } else if (state.currentIndex == 1) {
          title = 'Leaderboard';
        } else if (state.currentIndex == 2) {
          title = 'Rank Your Courses';
        } else if (state.currentIndex == 3) {
          title = 'Golf Map';
        } else if (state.currentIndex == 4) {
          title = 'Profile';
        }
        return SimpleBackground(
          key: scaffoldKey,
          appBar: _appbar(title),

          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),

            transitionBuilder: (child, animation) {
              return SlideTransition(
                position: Tween(
                  begin: const Offset(0.2, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: KeyedSubtree(
              key: ValueKey(state.currentIndex),
              child: Align(alignment: .topStart, child: currentPage(state.currentIndex, context)),
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: state.currentIndex,
            onTap: (index) => cubit.changeIndex(index),
            items: getpage(),
            onCenterTap: () {
              cubit.changeIndex(2);
            },
          ),
          // drawer: const DrawerWidget(),
        );
      },
    );
  }

  CommonAppBar _appbar(String title) {
    return CommonAppBar(
      disableBack: true,
      hideBack: true,
      title: title,
      appbarConfig: AppbarConfig(
        titleAlignment: .centerLeft,
        height: 70,
        titleSpacing: 16,
        actions: [
          IconButton(
            onPressed: () {
              appRouter.push(const SettingRoute());
            },
            icon: SizedBox(
              width: 25,
              height: 25,
              child: CommonImage(src: Assets.images.settingIcon),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SizedBox(
              width: 25,
              height: 25,
              child: Badge.count(count: 1, child: CommonImage(src: Assets.images.notificationIcon)),
            ),
          ),
        ],
      ),
    );
  }

  Widget currentPage(int index, BuildContext context) {
    final screen = getpage()[index].screen;
    AppLogger.info('Switched to -> ${screen.runtimeType.toString()}', tag: 'Navigation');
    return screen;
  }

  BottomNavigationBarItem _navBuilder({
    required int index,
    required String image,
    required NavigationState state,
    required BuildContext context,
  }) {
    final isSelected = index == state.currentIndex;

    final icon = AnimatedScale(
      scale: isSelected ? 1.05 : 1.0,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutBack,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        padding: isSelected ? const EdgeInsets.all(8) : EdgeInsets.zero,
        margin: const EdgeInsets.only(top: 2),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
          color: isSelected ? context.colors.tEXT_white : context.colors.tEXT_sub,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.colors.pRIMARY_priLight.withOpacity(0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: CommonImage(
          size: isSelected ? 25 : 30,
          fill: BoxFit.contain,
          src: image,
          imageColor: isSelected ? Colors.white : Colors.grey,
        ),
      ),
    );

    return BottomNavigationBarItem(label: '', icon: icon);
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final List<NavigatorItem> items;
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onCenterTap;
  

  const CustomBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    required this.onCenterTap,
  });

  @override
  Widget build(BuildContext context) {
    // Colors based on your images
    final activeColor = context.colors.navActiveColor;
    final inactiveColor = context.colors.tEXT_sub;
    final navBgColor = context.colors.bACKGROUND_darkCard;
    const glowColor = Color(0xFF1E9C6E);

    // Split the list of items into two halves
    final leftItems = items.sublist(0, 2);
    final rightItems = items.sublist(3, 5);

    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width - 8,
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // The Custom Background Shape
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width - 8, 110),
              painter: WaveNavBarPainter(
                color: navBgColor,
                borderColor: context.colors.bACKGROUND_darkCardBoarder,
              ),

              child: Container(
                height: 100,

                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  crossAxisAlignment: .end,
                  children: [
                    ..._buildNavGroup(leftItems, 0, activeColor, inactiveColor),
                    const SizedBox(width: 80), // Space for center button
                    ..._buildNavGroup(rightItems, 3, activeColor, inactiveColor),
                  ],
                ),
              ),
            ),

            // The Floating Center Action Button
            Positioned(
              top: 10,
              child: GestureDetector(
                onTap: onCenterTap,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: navBgColor,
                    boxShadow: [
                      BoxShadow(color: glowColor.withOpacity(0.5), blurRadius: 20, spreadRadius: 2),
                    ],
                  ),
                  child: Icon(
                    Icons.golf_course,
                    color: currentIndex == 2 ? activeColor : inactiveColor,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNavGroup(
    List<NavigatorItem> group,
    int startIndex,
    Color active,
    Color inactive,
  ) {
    return group.asMap().entries.map((entry) {
      final actualIndex = startIndex + entry.key;
      final isActive = currentIndex == actualIndex;

      return Expanded(
        child: InkWell(
          onTap: () => onTap(actualIndex),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonImage(
                src: entry.value.imagePath,
                imageColor: isActive ? active : inactive,
                size: 24,
              ),
              const SizedBox(height: 4),
              CommonText(
                text: entry.value.label,
                style: TextStyle(
                  color: isActive ? active : inactive,
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}

// Custom Painter for the specific "Wave" notch shape
class WaveNavBarPainter extends CustomPainter {
  final Color color;
  final Color borderColor;
  WaveNavBarPainter({required this.color, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    const border = 2.0;
    const padding = 20.0;

    draw(
      canvas: canvas,
      size: size,
      color: borderColor,
      reduction: 0,
      offset: 0,
      radius: padding + border,
    );
    draw(
      canvas: canvas,
      size: size,
      color: color,
      reduction: border * 2,
      offset: border,
      radius: padding,
    );
  }

  void draw({
    required Canvas canvas,
    required Size size,
    required Color color,
    required double reduction,
    required double offset,
    required double radius,
  }) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    final h = size.height - reduction;
    final w = size.width - reduction;

    path.moveTo(offset + radius, offset);

    path.lineTo(offset + w - radius, offset);
    path.arcToPoint(Offset(offset + w, offset + radius), radius: Radius.circular(radius));

    path.lineTo(offset + w, offset + h - radius);
    path.arcToPoint(Offset(offset + w - radius, offset + h), radius: Radius.circular(radius));

    path.lineTo(offset + radius, offset + h);
    path.arcToPoint(Offset(offset, offset + h - radius), radius: Radius.circular(radius));

    path.lineTo(offset, offset + radius);
    path.arcToPoint(Offset(offset + radius, offset), radius: Radius.circular(radius));

    // your custom curve
    path.quadraticBezierTo(offset + w * .5, offset + h - 40, offset + w - radius, offset);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
