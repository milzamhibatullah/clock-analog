import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockbit_clock_test/service/notification_service.dart';

///base screen to display the clock
class BaseScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BaseScreenState();
  }
}

class BaseScreenState extends State<BaseScreen> {
  final NotificationService _notificationService=NotificationService();

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
                /// test the local service
                await _notificationService.setAlarmNotification(
                    id: 0,
                    title: 'ALARM',
                    body:
                        '${DateTime.now().hour} : ${DateTime.now().minute + 2}');
              },
              child: const Text('TEST LOCAL NOTIF'),
            ),
          ),
        ),
      ),
    );
  }
}
