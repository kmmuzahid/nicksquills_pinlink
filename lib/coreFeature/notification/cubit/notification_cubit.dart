/*
 * @Author: Km Muzahid
 * @Date: 2026-01-17 11:10:37
 * @Email: km.muzahid@gmail.com
 */
import 'dart:async';
import 'package:core_kit/utils/app_log.dart';
import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/coreFeature/notification/cubit/notification_state.dart';
import 'package:pinlink/coreFeature/notification/local_notification_service.dart';
import 'package:pinlink/coreFeature/notification/model/notification_model.dart';
import 'package:pinlink/coreFeature/socket/socket_service.dart';

class NotificationCubit extends SafeCubit<NotificationState> {
  NotificationCubit() : super(const NotificationState());

  Future<void> init() async {
    await LocalNotificationService.instance.requestPermissions();

    SocketService.instance.streamController.stream.listen((notification) {
      addNotification(notification);

      final currentRouteName = appRouter.current.name;

      if (currentRouteName != NotificationRoute.name) {
        LocalNotificationService.instance.showNotification(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          title: notification.title ?? 'New Notification',
          body: notification.message ?? '',
        );
      }
    });
    fetch();
    getUnreadCount();
  }

  Future<void> addNotification(NotificationModel notification) async {
    if (appRouter.current.route.name == NotificationRoute.name) {
      emit(
        state.copyWith(notifications: [...state.notifications, notification]),
      );
    } else {
      emit(state.copyWith(unreadCount: state.unreadCount + 1));
    }
  }

  Future<void> getUnreadCount() async {
    final result = await DioService.instance.request<int>(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.notification,
        method: .GET,
        queryParams: {'page': 1, 'limit': 1},
      ),
      responseBuilder: (data) {
        return data['unReadCount']?.toInt();
      },
    );
    emit(state.copyWith(unreadCount: result.data ?? 0));
  }

  Future<void> fetch({bool isRefresh = false, int page = 1}) async {
    emit(state.copyWith(isLoading: true, notifications: isRefresh ? [] : null));

    final result = await DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.notification,
        method: .GET,
        queryParams: {'page': page, 'limit': 20},
      ),
      responseBuilder: (data) {
        return List<NotificationModel>.from(
          data['result'].map((x) => NotificationModel.fromJson(x)),
        );
      },
    );

    emit(
      state.copyWith(
        isLoading: false,
        notifications: [
          if (!isRefresh) ...state.notifications,
          ...result.data ?? [],
        ],
      ),
    );
  }

  Future<void> notificationReadAll() async {
    final result = await DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.notificationAllRead,
        method: .POST,
      ),
      responseBuilder: (data) => data,
    );
    if (result.isSuccess) {
      emit(
        state.copyWith(
          unreadCount: 0,
          notifications: state.notifications
              .map((e) => e.copyWith(isRead: true))
              .toList(),
        ),
      );
    }
  }

  Future<void> notificationReadSingle({required String notificationId}) async {
    final notificationIndex = state.notifications.indexWhere(
      (e) => e.id == notificationId && e.isRead == false,
    );
    if (notificationIndex == -1) {
      return;
    }

    final result = await DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.notificationReadSingle,
        method: .PATCH,
        pathParams: [notificationId],
      ),
      responseBuilder: (data) => data,
    );
    if (result.isSuccess) {
      final notification = List<NotificationModel>.from(state.notifications);
      notification[notificationIndex] = state.notifications[notificationIndex]
          .copyWith(isRead: true);
      emit(
        state.copyWith(
          notifications: notification,
          unreadCount: state.unreadCount - 1,
        ),
      );
    }
  }

  Future<void> acceptFriendRequest({required int index}) async {
    final notificationModel = state.notifications[index];
    final result = await DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.acceptFriendRequest,
        method: .POST,
        jsonBody: {
          'friendRequestId': notificationModel.friendRequestId,
          'notificationId': notificationModel.id,
        },
      ),
      responseBuilder: (data) => data,
    );

    if (result.isSuccess) {
      final list = List<NotificationModel>.from(state.notifications);
      list.removeAt(index);
      emit(
        state.copyWith(notifications: list, unreadCount: state.unreadCount - 1),
      );
    }
  }

  Future<void> rejectFriendRequest({required int index}) async {
    final notificationModel = state.notifications[index];
    final result = await DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.rejectFriendRequest,
        method: .POST,
        jsonBody: {
          'friendRequestId': notificationModel.friendRequestId,
          'notificationId': notificationModel.id,
        },
      ),
      responseBuilder: (data) => data,
    );
    if (result.isSuccess) {
      final list = List<NotificationModel>.from(state.notifications);
      list.removeAt(index);
      emit(
        state.copyWith(notifications: list, unreadCount: state.unreadCount - 1),
      );
    }
  }
}
