
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockbit_clock_test/service/notification_service.dart';
///base screen to display the clock
class BaseScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return BaseScreenState();
  }
}

class BaseScreenState extends State<BaseScreen>{
  final NotificationService _notificationService = NotificationService();
  @override
  void initState() {
    ///init the notification service
    _notificationService.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Center(
            child: ElevatedButton(
              onPressed: ()async{
                /// test the local service
               await _notificationService.showNotification(id: 0, title: 'this is test notification', body: 'Hiii this is the body');
              },
              child: const Text('TEST LOCAL NOTIF'),
            ),
          ),
        ),
      ) ,
    );
  }


}