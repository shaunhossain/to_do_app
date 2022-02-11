import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/services/notification_services.dart';
import 'package:to_do_app/services/theme_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late NotificationServices notificationServices;

  @override
  void initState() {
    notificationServices = NotificationServices();
    notificationServices.initializeNotification();
    notificationServices.requestIOSPermissions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.wb_sunny_outlined), onPressed: () {
            ThemeService().switchTheme();
            notificationServices.displayNotification(title: "title", body: Get.isDarkMode?"active dark mode " : "active light mode");
            notificationServices.scheduledNotification();
        },
        ),
      ),
      body: Column(
        children: const [
          Text("theme data",
          style: TextStyle(
            fontSize: 30
          ),)
        ],
      ),
    );
  }
}
