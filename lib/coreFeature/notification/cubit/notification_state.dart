/*
 * @Author: Km Muzahid
 * @Date: 2026-01-17 11:10:46
 * @Email: km.muzahid@gmail.com
 */
import 'package:equatable/equatable.dart';
import 'package:pinlink/coreFeature/notification/model/notification_model.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.notifications = const [],
    this.isLoading = false,
    this.unreadCount = 0,
  });

  final List<NotificationModel> notifications;
  final bool isLoading;
  final int unreadCount;

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
    int? unreadCount,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object?> get props => [notifications, isLoading, unreadCount];
}
