/*
 * @Author: Km Muzahid
 * @Date: 2026-01-12 17:24:24
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/image/common_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/config/bloc/cubit_scope_value.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/coreFeature/notification/cubit/notification_cubit.dart';
import 'package:pinlink/gen/assets.gen.dart';

class NotificationIconWidget extends StatelessWidget {
  const NotificationIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CubitScopeValue(
      cubit: context.read<NotificationCubit>(),
      builder: (context, cubit, state) {
        return GestureDetector(
          onTap: () {
            appRouter.push(const NotificationRoute());
          },
          child: SizedBox(
            width: 25,
            height: 25,
            child: state.unreadCount > 0
                ? Badge(
                    label: Text(state.unreadCount.toString()),
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    child: CommonImage(
                      src: Assets.images.notificationIcon,
                      fill: .contain,
                    ),
                  )
                : CommonImage(
                    src: Assets.images.notificationIcon,
                    fill: .contain,
                  ),
          ),
        );
      },
    );
  }
}
