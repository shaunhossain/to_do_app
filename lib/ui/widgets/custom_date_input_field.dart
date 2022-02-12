import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/ui/themes/themes.dart';

class CustomDateInputField extends StatelessWidget {
  const CustomDateInputField(
      {Key? key,
        required this.title,
        required this.hint,
        //required this.controller,
        required this.widget
      })
      : super(key: key);
  final String title;
  final String hint;
  //final TextEditingController controller;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleTextStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            //onChanged: (value) => controller,
            //controller: controller,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              fillColor: Get.isDarkMode ? Colors.grey.shade400 : Colors.white,
              filled: true,
              errorStyle: const TextStyle(
                color: Colors.redAccent,
                fontSize: 14,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Get.isDarkMode ? Colors.redAccent : Colors.black,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Get.isDarkMode ? Colors.redAccent : Colors.black,
                  style: BorderStyle.solid,
                  width: 1,
                ),
              ),
              isDense: true,
              contentPadding: const EdgeInsets.only(
                  left: 16, bottom: 16, top: 16, right: 16),
              suffixIcon: widget,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
