import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/services/notification_services.dart';
import 'package:to_do_app/services/theme_service.dart';
import 'package:to_do_app/ui/add_task_page.dart';
import 'package:to_do_app/ui/themes/themes.dart';
import 'package:to_do_app/ui/widgets/custom_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late NotificationServices notificationServices;
  DateTime _selectedDate = DateTime.now();

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
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
          icon: Icon(Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round ,color: Get.isDarkMode ? Colors.red : Colors.blue,), onPressed: () {
            ThemeService().switchTheme();
            notificationServices.displayNotification(title: "title", body: Get.isDarkMode?"active light mode " : "active dark mode");
            notificationServices.scheduledNotification();
        },
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Get.isDarkMode ? Colors.white : Colors.white,
            child: Icon(Icons.person,color: Get.isDarkMode ? Colors.red : Colors.blue,),
          )
        ],
      ),
      body: Column(
        children: [
          _addTask(),
          _addDateBar()
        ],
      ),
    );
  }
  _addDateBar(){
    return(
        Container(
          margin: const EdgeInsets.only(left: 10,top: 20),
          child: DatePicker(
            DateTime.now(),
            height: 100,
            width: 80,
            initialSelectedDate: DateTime.now(),
            selectionColor: Colors.deepPurple,
            selectedTextColor: Get.isDarkMode ? Colors.white : Colors.white,
            dateTextStyle: dateTimeStyle,
            dayTextStyle: dayTimeStyle,
            monthTextStyle: monthTimeStyle,
            onDateChange: (date){
              _selectedDate = date;
            },
          ),
        )
    );
  }
  _addTask(){
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat.yMMMMd().format(DateTime.now()),style: subHeadingStyle,),
              Text("Today",style: headingStyle,),
            ],
          ),
          CustomButton(onPress: () => Get.to(const AddTaskPage()), label: "+ add task")
        ],
      ),
    );
  }
}
