import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool isInitialized = false; // initially

  bool get getIsInitialized => isInitialized; // getter for isInitialized

  // Initialization -- android only
  Future<void> initNotifications() async {
    if (isInitialized) return; // if already initialized

    const initAndroidSetting = AndroidInitializationSettings(
        '@mipmap/ic_launcher'); // preparing android init settings using default icon

    const initSettings =
        InitializationSettings(android: initAndroidSetting); // init settings

    await notificationsPlugin.initialize(initSettings); // initializing plugin
    isInitialized = true; // set initialized to true
  }

  // Notifications setup -- android only
  NotificationDetails notiDetails() {
    const androidNotificationsDetails = AndroidNotificationDetails(
      'daily_notifications_id',
      'Daily Notifications',
      channelDescription: 'Daily Notifications Channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const generalnotificationDetails =
        NotificationDetails(android: androidNotificationsDetails);

    return generalnotificationDetails;
  }

  // Show notification
  Future<void> showNotifications(
      {int id = 0, String? title, String? body}) async {
    return notificationsPlugin.show(id, title, body,
        notiDetails()); // Use notiDetails() for notification details
  }
}
