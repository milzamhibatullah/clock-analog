import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockbit_clock_test/screen/base_screen.dart';

void main() async{

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
        GetPage(name: '/', page: ()=>BaseScreen())
      ],
      defaultTransition: Transition.fadeIn,
    ),
  );

}


