import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clock_test/service/notification_service.dart';

class AlarmController extends GetxController {
  var graphIsLoading = false.obs;
  var seconds = 0.obs;
  var hoursAngle = (0.0).obs;
  var minuteAngle = (0.0).obs;

  ///setUpAlarm
  Future<void> setUpAlarm({required NotificationService service}) async {
    // int convertedHours = _parseHours(hours: hoursAngle.value * 10 * 12 ~/ 60);
    var hours = hoursAngle.value * 10 * 12 ~/ 60;
    print(hours);
    var parsedHours;
    print('hours : ${hours.toInt()}');
    switch (hours.toInt()) {
      case -6:
        parsedHours = 6;
        break;
      case -5:
        parsedHours = 7;
        break;
      case -4:
        parsedHours = 8;
        break;
      case -3:
        parsedHours = 9;
        break;
      case -2:
        parsedHours = 10;
        break;
      case -1:
        parsedHours = 11;
        break;
      case -0:
        parsedHours = 12;
        break;
      default:
        parsedHours = hours;
    }
    return await service.setAlarmNotification(
      id: 0,
      title: 'ALARM',
      hours: parsedHours,
      minute: minuteAngle.value == 0 ? 0 : int.parse(getMinute()),
      body:
          '${parsedHours < 10 ? '0$parsedHours' : parsedHours}:${minuteAngle.value == 0 ? '00' : getMinute()}',
      payload:
          '${parsedHours < 10 ? '0$parsedHours' : parsedHours}:${getMinute()}',
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

  setUpHoursAngle({required double direction}) {
    // print('direction $direction');

    hoursAngle.value = direction;
  }

  setUpMinuteAngle({required direction}) {
    minuteAngle.value = direction;
  }

  ///conver hours angle to hours string
  String getHours() {
    var hours = hoursAngle.value * 10 * 12 / 60;
    var parsedHours;
    print('hours : ${hours.toInt()}');
    switch (hours.toInt()) {
      case -6:
        parsedHours = 6;
        break;
      case -5:
        parsedHours = 7;
        break;
      case -4:
        parsedHours = 8;
        break;
      case -3:
        parsedHours = 9;
        break;
      case -2:
        parsedHours = 10;
        break;
      case -1:
        parsedHours = 11;
        break;
      case -0:
        parsedHours = 12;
        break;
      default:
        parsedHours = hours;
    }
    return parsedHours < 10
        ? '0${parsedHours.toString().split('.')[0]}'
        : parsedHours.toString().split('.')[0];
  }

  ///convert minute angle to minutes string
  String getMinute() {
    return minuteAngle.value == 0
        ? '00'
        : minuteAngle.value < 0
            ? (60 - (minuteAngle.value * 10).abs()).toString().split('.')[0]
            : minuteAngle * 10 < 10
                ? '0${(minuteAngle.value * 10).toString().split('.')[0]}'
                : (minuteAngle.value * 10).toString().split('.')[0];
  }
}
