import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

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
      print('notifcation is select');
      print(payload);
    } catch (e) {
      debugPrint('error on select notification : $e');
    }
  }

  /// creating method for detail of notification that return Notification Detail
  Future<NotificationDetails> _details() async {
    ///details for android
    const int insistentFlag = 4;
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'id',
        'name',
        channelDescription: 'description',
        priority: Priority.max,
        playSound: true,
        importance: Importance.max,
        ticker: 'ticker',
        additionalFlags: Int32List.fromList(<int>[insistentFlag]));

        ///details for ios
        const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();

    ///return the notification details
    return  NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  ///create method to scheduled alarm notification
  setAlarmNotification(
      {required int id, required String title, required String body}) async {
    ///initialize DATE TIME now
    final notificationDetails = await _details();
    // await _service.show(id, title, body, notificationDetails);
    await _service.zonedSchedule(
        0,
        title,
        body,
        _alarmTime(
            hour: tz.TZDateTime
                .now(tz.local)
                .hour,
            minute: tz.TZDateTime
                .now(tz.local)
                .minute + 1),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime);
  }

  /// set alarm time
  tz.TZDateTime _alarmTime({required hour, required minute}) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime scheduledTime =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    return scheduledTime;
  }
}
