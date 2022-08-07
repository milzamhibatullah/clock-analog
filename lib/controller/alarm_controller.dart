import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockbit_clock_test/service/notification_service.dart';

class AlarmController extends GetxController {
  var graphIsLoading = false.obs;
  var seconds = 0.obs;

  ///setUpAlarm
  Future<void> setUpAlarm(
      {required hours,
      required minute,
      required NotificationService service}) async {
    int convertedHours = _parseHours(hours: hours);
    return await service.setAlarmNotification(
      id: 0,
      title: 'ALARM',
      body:
          '${convertedHours < 10 ? '0$convertedHours' : convertedHours}:$minute PM',
      payload:
          '${convertedHours < 10 ? '0$convertedHours' : convertedHours}:$minute:PM',
    );
  }

  ///this method for converting payload string to secons data
  convertPayload({required String payload}) async {
    try {
      ///setup loading
      graphIsLoading.value = true;
      if (payload.isNotEmpty) {
        var hours = int.parse(payload.split(':')[0].contains('0')
                ? payload.split(':')[0].replaceAll('0', '')
                : payload.split(':')[0]) *
            3600;
        var minute = int.parse(payload.split(':')[1]) * 60;
        seconds.value = hours + minute;

        ///if done convert to seconds, give delayed to ui
        Future.delayed(const Duration(milliseconds: 300),
            () => graphIsLoading.value = false);
      }
    } catch (e) {
      debugPrint('error when setup : $e');
    }
  }

  ///convert hours to am/pm hours
  int _parseHours({required hours}) {
    var parsed;
    if (int.parse(hours.toString()) > 12) {
      switch (hours) {
        case 13:
          parsed = 1;
          break;
        case 14:
          parsed = 2;
          break;
        case 15:
          parsed = 3;
          break;
        case 16:
          parsed = 4;
          break;
        case 17:
          parsed = 5;
          break;
        case 18:
          parsed = 6;
          break;
        case 19:
          parsed = 7;
          break;
        case 20:
          parsed = 8;
          break;
        case 21:
          parsed = 9;
          break;
        case 22:
          parsed = 10;
          break;
        case 23:
          parsed = 11;
          break;
      }
    } else {
      parsed = hours;
    }

    return parsed;
  }
}
