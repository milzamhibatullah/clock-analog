import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockbit_clock_test/controller/alarm_controller.dart';
import 'package:stockbit_clock_test/service/notification_service.dart';
import 'package:timezone/timezone.dart' as tz;

///base screen to display the clock
class BaseScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BaseScreenState();
  }
}

class BaseScreenState extends State<BaseScreen> {
  final NotificationService _notificationService = NotificationService();
  final AlarmController _alarmController = Get.put(AlarmController());

  @override
  void initState() {
    super.initState();

    ///init the notification service
    _notificationService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Center(
            child: ElevatedButton(
              onPressed: () async {
                tz.TZDateTime now = tz.TZDateTime.now(tz.local);
                await _alarmController.setUpAlarm(
                    hours: now.hour,
                    minute: now.minute,
                    service: _notificationService);

                //Get.toNamed('/detail');
              },
              child: const Text('TEST LOCAL NOTIF'),
            ),
          ),
        ),
      ),
    );
  }
}
