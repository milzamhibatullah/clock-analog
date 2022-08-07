import 'package:flutter/material.dart';

class CustomText {
  Widget text({required text, size = 14.0, align = TextAlign.start}) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: size,
      ),
    );
  }
}

var ct = CustomText();
