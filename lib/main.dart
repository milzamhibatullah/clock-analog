import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockbit_clock_test/screen/base_screen.dart';
import 'package:stockbit_clock_test/screen/detail_alarm_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  var id = tz.getLocation('Asia/Jakarta');
  tz.setLocalLocation(id);

  return runApp(
    GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.yellow,
        useMaterial3: true,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=>BaseScreen()),
        GetPage(name: '/detail', page: ()=>DetailAlarmScreen())
      ],
      defaultTransition: Transition.fadeIn,
    ),
  );

}


