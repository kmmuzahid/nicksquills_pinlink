/*
 * @Author: Km Muzahid
 * @Date: 2026-01-17 11:10:37
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/coreFeature/notification/cubit/notification_state.dart';
import 'package:pinlink/coreFeature/notification/model/notification_model.dart';

class NotificationCubit extends SafeCubit<NotificationState> {
  NotificationCubit() : super(const NotificationState());

  Future<void> init() async {
    fetch();
    getUnreadCount();
   
  }

  Future<void> addNotification(NotificationModel notification) async {
    if (appRouter.current.route.name == NotificationRoute.name) {
      emit(state.copyWith(notifications: [...state.notifications, notification]));
    } else {
      emit(state.copyWith(unreadCount: state.unreadCount + 1));
    }
  }

  Future<void> getUnreadCount() async {
    emit(state.copyWith(unreadCount: 0));
  }

  Future<void> fetch({bool isRefresh = false, int page = 1}) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 500));

    emit(
      state.copyWith(
        isLoading: false,
        notifications: [
          if (!isRefresh) ...state.notifications,
          ...List.generate(
            20,
            (index) => NotificationModel(
              title: 'Slots Booked!',
              message: 'JAN 12 2026 10:00 AM -12:00 PM have been booked',
              time: DateTime.now()
                  .subtract(Duration(minutes: state.notifications.length * 10))
                  .checkTime,
              isUnread: index % 2 == 0,
            ),
          ),
        ],
      ),
    );
  }
}
