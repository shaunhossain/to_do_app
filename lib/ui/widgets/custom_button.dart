import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/ui/themes/themes.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key, required this.onPress, required this.label}) : super(key: key);
  final Function() onPress;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: 100,
        height: 44,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
        ),
        onPressed: onPress,
      color: Get.isDarkMode ? Colors.deepPurple : Colors.blueAccent,
      child: Text(label,style: buttonLabelStyle,),
    );
  }
}
