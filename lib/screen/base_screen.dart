import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stockbit_clock_test/component/clock.dart';
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


  @override
  void initState() {
    super.initState();
    ///setup screen to portrait only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Clock(),
        ),
      ),
    );
  }
}
