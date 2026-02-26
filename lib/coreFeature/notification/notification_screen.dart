/*
 * @Author: Km Muzahid
 * @Date: 2026-01-17 09:48:40
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/config/bloc/cubit_scope_value.dart';
import 'package:pinlink/constant/app_string.dart';
import 'package:pinlink/coreFeature/notification/cubit/notification_cubit.dart';
import 'package:pinlink/coreFeature/notification/widget/notification_item_widget.dart';

@RoutePage()
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: AppString.notifications,
        appbarConfig: AppbarConfig(
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.checklist_rtl))],
        ),
      ),
      body: CubitScopeValue(
        cubit: context.read<NotificationCubit>()..init(),
        builder: (context, cubit, state) {
          return SmartListLoader(
            itemCount: state.notifications.length,
            isLoading: state.isLoading,
            limit: state.notifications.length,
            onRefresh: () {
              cubit.fetch(isRefresh: true);
            },
            onLoadMore: (int page) {
              cubit.fetch(page: page);
            },
            itemBuilder: (context, int index) {
              return NotificationItemWidget(
                title: state.notifications[index].title,
                message: state.notifications[index].message,
                time: state.notifications[index].time,
                isUnread: state.notifications[index].isUnread,
              );
            },
          );
        }
      ),
    );
  }
}
