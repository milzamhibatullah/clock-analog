import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService();

  final _service = FlutterLocalNotificationsPlugin();

  ///init the notification settings
  Future<void> init() async {
    try {
      ///settings for android
      const AndroidInitializationSettings androidInitializationSettings =
          AndroidInitializationSettings('notif_icon');

      ///settings for ios
      IOSInitializationSettings iosInitializationSettings =
          IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: iosDidReceive,
      );

      ///attach all settings
      InitializationSettings settings = InitializationSettings(
          android: androidInitializationSettings,
          iOS: iosInitializationSettings);

      await _service.initialize(settings,
          onSelectNotification: onNotificationSelect);
    } catch (e) {
      debugPrint('error on initialize : $e');
    }
  }

  /// method for receive notification ios
  void iosDidReceive(int id, String? title, String? body, String? payload) {
    try {
      print(title);
    } catch (e) {
      debugPrint('something wrong on ios receive :  $e');
    }
  }

  /// method for notification select
  void onNotificationSelect(String? payload) {
    try {
      print(payload);
    } catch (e) {
      debugPrint('error on select notification : $e');
    }
  }

  /// creating method for detail of notification that return Notification Detail
  Future<NotificationDetails> _details() async {
    ///details for android
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'id',
      'name',
      channelDescription: 'description',
      priority: Priority.max,
      playSound: true,
    );

    ///details for ios
    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();

    ///return the notification details
    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  ///create method to handle show notification for both platform
  showNotification (
      {required int id, required String title, required String body})async{
    final notificationDetails =await _details();
    await _service.show(id, title, body, notificationDetails);
  }

}
