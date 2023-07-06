import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockbit_clock_test/controller/alarm_controller.dart';

class MinuteHand extends StatelessWidget {
  final AlarmController _alarmController = Get.find<AlarmController>();
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 2,
      child: Obx(() => Transform.rotate(
            angle: _alarmController.minuteAngle.value,
            child: Transform.translate(
              offset: const Offset(0, 30),
              child: Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanUpdate: (details) {
                    ///setup minutes angle when clock hands is drag
                    _alarmController.setUpMinuteAngle(
                        direction: details.localPosition.direction);
                  },
                  child: Container(
                    height: Get.height / 3,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
