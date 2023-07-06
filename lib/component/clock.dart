import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockbit_clock_test/component/custom_text.dart';
import 'package:stockbit_clock_test/component/hours_hand.dart';
import 'package:stockbit_clock_test/component/minute_hand.dart';
import 'package:stockbit_clock_test/controller/alarm_controller.dart';
import 'package:stockbit_clock_test/service/notification_service.dart';

class Clock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ClockState();
  }
}

class ClockState extends State<Clock> {
  bool alarmSet = false;
  final NotificationService _notificationService = NotificationService();
  final AlarmController _alarmController = Get.put(AlarmController());

  @override
  void initState() {
    super.initState();

    ///initial notification service
    _notificationService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// display alarm time setup
          /// ct => CustomText instance
          Align(
            alignment: Alignment.topCenter,
            child: Obx(
              () => ct.text(
                text:
                    '${_alarmController.getHours()}:${_alarmController.getMinute()}',
                size: 24.0,
              ),
            ),
          ),

          ///clock body
          Container(
            height: Get.height / 2,
            width: Get.width,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 5.0,
                      spreadRadius: 5.0,
                      color: Color.fromRGBO(0, 0, 0, 0.08))
                ]),
          ),
          Transform.rotate(
            angle: 0.0,
            child: Image.asset(
              'images/clock_number.png',
              height: Get.height / 2,
            ),
          ),

          ///display hour hand widget
          HourHand(),

          ///display minute hand widget
          MinuteHand(),

          ///save alarm button
          Align(
            alignment: Alignment.bottomCenter,
            child: OutlinedButton(
              onPressed: () async {
                ///setup alarm
                await _alarmController.setUpAlarm(
                    service: _notificationService);

                ///display snackbar
                Get.snackbar(
                  'Alarm',
                  'Success setup alarm',
                  backgroundColor: Colors.black,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: ct.text(text: 'Save Alarm'),
            ),
          )
        ],
      ),
    );
  }
}
