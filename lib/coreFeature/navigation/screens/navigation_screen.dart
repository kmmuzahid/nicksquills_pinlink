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
import 'package:pinlink/gen/assets.gen.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

@RoutePage()
class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  List<NavigatorItem> getpage() {
    final evItems = <NavigatorItem>[
      NavigatorItem(imagePath: Assets.navigators.social, screen: Container()),
      NavigatorItem(imagePath: Assets.navigators.leaderboard, screen: Container()),
      NavigatorItem(imagePath: Assets.navigators.addCourse, screen: Container()),
      NavigatorItem(imagePath: Assets.navigators.map, screen: Container()),
      NavigatorItem(imagePath: Assets.navigators.profile, screen: const ProfileScreen()),
    ];

    return evItems;
  }

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
          // appBar: AppBarSimple(
          //   title: title,
          //   hideBack: true,
          //   disableBack: true,
          //   actions: [const NotificationIconWidget()],
          // ), 
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
              child: currentPage(state.currentIndex),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
            backgroundColor: AppColor.bACKGROUND_darkCard,
            onTap: (index) => cubit.changeIndex(index),
            items: getpage()
                .asMap()
                .map(
                  (index, value) => MapEntry(
                    index,
                    _navBuilder(index: index, image: value.imagePath, state: state),
                  ),
                )
                .values
                .toList(),
          ),
          // drawer: const DrawerWidget(),
        );
      },
    );
  }

  Widget currentPage(int index) {
    final screen = getpage()[index].screen;
    AppLogger.info('Switched to -> ${screen.runtimeType.toString()}', tag: 'Navigation');
    return screen;
  }

  BottomNavigationBarItem _navBuilder({
    required int index,
    required String image,
    required NavigationState state,
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
          color: isSelected ? AppColor.tEXT_white : AppColor.tEXT_sub,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColor.pRIMARY_priLight.withOpacity(0.35),
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
