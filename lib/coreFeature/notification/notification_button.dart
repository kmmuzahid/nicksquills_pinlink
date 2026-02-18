/*
 * @Author: Km Muzahid
 * @Date: 2026-01-12 17:24:24
 * @Email: km.muzahid@gmail.com
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/config/bloc/cubit_scope_value.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/coreFeature/notification/cubit/notification_cubit.dart';

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
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: state.unreadCount > 0
                ? Badge(
                    label: Text(state.unreadCount.toString()),
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    child: Icon(Icons.notifications_outlined, color: AppColor.primary),
                  )
                : Icon(Icons.notifications_outlined, color: AppColor.primary),
          ),
        );
      },
    );
  }
}
