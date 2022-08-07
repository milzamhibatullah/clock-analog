
import 'package:flutter/material.dart';
import 'package:get/get.dart';
///base screen to display the clock
class BaseScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return BaseScreenState();
  }
}

class BaseScreenState extends State<BaseScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
        ),
      ) ,
    );
  }
}