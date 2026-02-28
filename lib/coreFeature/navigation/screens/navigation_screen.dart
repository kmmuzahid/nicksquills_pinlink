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
import 'package:pinlink/coreFeature/navigation/cubit/navigation_cubit.dart';
import 'package:pinlink/coreFeature/navigation/cubit/navigation_state.dart';
import 'package:pinlink/coreFeature/navigation/nav_utils/navigator_item.dart';
import 'package:pinlink/coreFeature/profile/screens/profile_screen.dart';
import 'package:pinlink/features/course_comparision/screens/add_course_screen.dart';
import 'package:pinlink/gen/assets.gen.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

@RoutePage()
class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key}); 

  List<NavigatorItem> getpage() {
    final evItems = <NavigatorItem>[
      NavigatorItem(imagePath: Assets.navigators.social, screen: Container(), label: 'Socia'),
      NavigatorItem(
        imagePath: Assets.navigators.leaderboard,
        screen: Container(),
        label: 'Leaderboard',
      ),

      NavigatorItem(imagePath: Assets.navigators.map, screen: Container(), label: 'Map'),
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
    screen: const AddCourseScreen(enableSafeArea: false),
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
          title = 'Add Courses';
        } else if (state.currentIndex == 3) {
          title = 'Golf Map';
        } else if (state.currentIndex == 4) {
          title = 'Profile';
        }
        return SimpleBackground(
          key: scaffoldKey,
 
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
              child: currentPage(state.currentIndex, context),
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: state.currentIndex,
            onTap: (index) => cubit.changeIndex(index),
            items: getpage(),
            onCenterTap: () {},
          ),
          // drawer: const DrawerWidget(),
        );
      },
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
    const activeColor = Colors.white;
    const inactiveColor = Color(0xFF7A8D86);
    const navBgColor = Color(0xFF052018);
    const glowColor = Color(0xFF1E9C6E);

    // Split the list of items into two halves
    final halfLength = (items.length / 2).floor();
    final leftItems = items.sublist(0, halfLength);
    final rightItems = items.sublist(halfLength);

    return Container(
      height: 110,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // The Custom Background Shape
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 100),
            painter: WaveNavBarPainter(color: navBgColor),
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
                child: const Icon(Icons.golf_course, color: Colors.white, size: 30),
              ),
            ),
          ),

          // The Navigation Items Row
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ..._buildNavGroup(leftItems, 0, activeColor, inactiveColor),
                const SizedBox(width: 80), // Space for center button
                ..._buildNavGroup(rightItems, halfLength, activeColor, inactiveColor),
              ],
            ),
          ),
        ],
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
  WaveNavBarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final h = size.height;
    final w = size.width;

    // Starting point on the left edge (slightly down from the top)
    path.moveTo(0, -10);

    // 1. Left Hump
    // Control point at 1/4 width (at y=0 for the peak)
    // End point at 40% width (where the center dip begins)
    path.quadraticBezierTo(w * 0.20, 0, w * 0.5, 20);

    // 2. Center Dip (The Notch)
    // This creates the hollow space for your action button
    // path.arcToPoint(Offset(w * 0.60, 20), radius: const Radius.circular(30), clockwise: false);

    // 3. Right Hump (Mirror of the Left)
    // Control point at 3/4 width (matching the left hump's height)
    // End point at the far right edge
    path.quadraticBezierTo(w * 0.80, 0, w, -h * 0.1);

    // 4. Complete the shape
    path.lineTo(w, h); // Down to bottom right
    path.lineTo(0, h); // Across to bottom left
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
