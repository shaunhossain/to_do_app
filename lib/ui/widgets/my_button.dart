import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton(
      {Key? key, required this.pressOnButton, required this.title}) : super(key: key);

  final Function() pressOnButton;
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(height: 44, minWidth: 100, onPressed: pressOnButton);
  }
}

