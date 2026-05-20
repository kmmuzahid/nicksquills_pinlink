import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:core_kit/utils/app_log.dart';

class LocalNotificationService {
  LocalNotificationService._();
  static final LocalNotificationService instance = LocalNotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    AppLogger.info('LocalNotificationService.init() started', tag: 'NotificationService');
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      defaultPresentAlert: true,
      defaultPresentSound: true,
      defaultPresentBadge: true,
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    try {
      final initialized = await _plugin.initialize(
        settings: initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) {
          AppLogger.info('LocalNotification clicked: payload = ${details.payload}', tag: 'NotificationService');
        },
      );
      AppLogger.info('LocalNotificationService initialization result: $initialized', tag: 'NotificationService');
    } catch (e, stack) {
      AppLogger.error('LocalNotificationService failed to initialize: $e\n$stack', tag: 'NotificationService');
    }
  }

  Future<void> requestPermissions() async {
    AppLogger.info('LocalNotificationService.requestPermissions() started', tag: 'NotificationService');
    
    try {
      final androidImplementation =
          _plugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (androidImplementation != null) {
        final androidGranted = await androidImplementation.requestNotificationsPermission();
        AppLogger.info('Android notification permissions granted status: $androidGranted', tag: 'NotificationService');
      } else {
        AppLogger.info('Android implementation was null, skipping Android permission request', tag: 'NotificationService');
      }
    } catch (e) {
      AppLogger.error('Error requesting Android notification permission: $e', tag: 'NotificationService');
    }

    try {
      final iosImplementation =
          _plugin.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      if (iosImplementation != null) {
        final iosGranted = await iosImplementation.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        AppLogger.info('iOS notification permissions granted status: $iosGranted', tag: 'NotificationService');
      } else {
        AppLogger.info('iOS implementation was null, skipping iOS permission request', tag: 'NotificationService');
      }
    } catch (e) {
      AppLogger.error('Error requesting iOS notification permission: $e', tag: 'NotificationService');
    }
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    AppLogger.info('LocalNotificationService.showNotification called (id: $id, title: "$title", body: "$body")', tag: 'NotificationService');
    
    const androidDetails = AndroidNotificationDetails(
      'pinlink_notifications',
      'Pinlink Notifications',
      channelDescription: 'Notification channel for Pinlink app',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    try {
      await _plugin.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: platformDetails,
      );
      AppLogger.info('LocalNotificationService.show completed successfully', tag: 'NotificationService');
    } catch (e, stack) {
      AppLogger.error('LocalNotificationService.show failed: $e\n$stack', tag: 'NotificationService');
      rethrow;
    }
  }
}
