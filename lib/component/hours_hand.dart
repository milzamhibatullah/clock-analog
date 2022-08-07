
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockbit_clock_test/controller/alarm_controller.dart';

class HourHand extends StatelessWidget{
  AlarmController _alarmController=Get.find<AlarmController>();
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 2,
      child: Obx(()=>Transform.rotate(
        angle: _alarmController.hoursAngle.value,
        child: Transform.translate(
          offset: const Offset(0, 20),
          child: Center(
            child: Container(
              height: Get.height/16,
              width: 4,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(32),
              ),
              child: GestureDetector(
                onPanEnd: (details){
                  Future.delayed(Duration(microseconds: 100),(){
                    _alarmController.setUpHoursAngle();
                  });
                },
              ),
            ),
          ),
        ),
      )),
    );
  }
}