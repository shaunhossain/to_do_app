import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/controllers/task_controller.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/ui/themes/themes.dart';
import 'package:to_do_app/ui/widgets/custom_button.dart';
import 'package:to_do_app/ui/widgets/custom_date_input_field.dart';
import 'package:to_do_app/ui/widgets/custom_text_input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now());

  String _endTime = DateFormat('hh:mm a').format(DateTime.now());
  int _selectReminder = 5;
  List<int> reminderList = [5, 10, 15, 20];
  String _selectRepeat = "None";
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.red : Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Get.isDarkMode ? Colors.white : Colors.white,
            child: Icon(
              Icons.person,
              color: Get.isDarkMode ? Colors.red : Colors.blue,
            ),
          )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Task',
                  style: headingStyle,
                ),
                CustomTextInputField(
                  title: "Title",
                  hint: "Enter your title",
                  controller: _titleController,
                ),
                CustomTextInputField(
                  title: "Note",
                  hint: "Enter your notes ",
                  controller: _noteController,
                ),
                CustomDateInputField(
                    title: "Date",
                    hint: DateFormat.yMd().format(_selectedDate),
                    widget: IconButton(
                      icon: Icon(
                        Icons.calendar_today_rounded,
                        color: Get.isDarkMode ? Colors.redAccent : Colors.black,
                      ),
                      onPressed: () {
                        _getDateFromUser();
                      },
                    )),
                Row(
                  children: [
                    Expanded(
                      child: CustomDateInputField(
                          title: "Time",
                          hint: _startTime.toString(),
                          widget: IconButton(
                            icon: Icon(
                              Icons.access_time,
                              color: Get.isDarkMode
                                  ? Colors.redAccent
                                  : Colors.black,
                            ),
                            onPressed: () {
                              _getTimeFromUser(isStartTime: true);
                            },
                          )),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: CustomDateInputField(
                          title: "Time",
                          hint: _endTime.toString(),
                          widget: IconButton(
                            icon: Icon(
                              Icons.access_time,
                              color: Get.isDarkMode
                                  ? Colors.redAccent
                                  : Colors.black,
                            ),
                            onPressed: () {
                              _getTimeFromUser(isStartTime: false);
                            },
                          )),
                    )
                  ],
                ),
                CustomDateInputField(
                    title: 'Remind',
                    hint: '$_selectReminder minutes early',
                    widget: DropdownButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 32,
                      ),
                      elevation: 4,
                      underline: Container(
                        height: 0,
                      ),
                      items:
                          reminderList.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                            value: value.toInt(),
                            child: Text(value.toString()));
                      }).toList(),
                      onChanged: (int? value) {
                        setState(() {
                          _selectReminder = value!;
                        });
                      },
                    )),
                CustomDateInputField(
                    title: 'Repeat',
                    hint: _selectRepeat,
                    widget: DropdownButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 32,
                      ),
                      elevation: 4,
                      underline: Container(
                        height: 0,
                      ),
                      items: repeatList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value.toString()));
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectRepeat = value!;
                        });
                      },
                    )),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorPellete(),
                    CustomButton(
                        onPress: () => _validateData(), label: 'Create task')
                  ],
                ),
                const SizedBox(
                  height: 32,
                )
              ],
            ),
          )),
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDataBase();
      Get.back();
    } else if (_titleController.text.isEmpty && _noteController.text.isEmpty) {
      Get.snackbar('Required', "All the fields are required",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          icon: const Icon(Icons.warning_amber_outlined));
    }
  }

  _colorPellete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: titleTextStyle,
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
            children: List<Widget>.generate(3, (int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectColor = index;
                //log(index.toString());
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 14,
                backgroundColor: index == 0
                    ? Colors.pinkAccent
                    : index == 1
                        ? Colors.deepPurple
                        : Colors.amber,
                child: _selectColor == index
                    ? const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 18,
                      )
                    : Container(),
              ),
            ),
          );
        }))
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickDateTime = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));
    if (!_pickDateTime.isNull) {
      setState(() {
        _selectedDate = _pickDateTime!;
      });
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? _pickTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0])),
    );
    String? _formatedTime = _pickTime?.format(context);
    //log("pickTime : ${_formatedTime}");
    if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime!;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime!;
      });
    }
  }

  Future<void> _addTaskToDataBase() async {
    await _taskController.addTask(task: Task(
        id: 1,
        title: _titleController.text,
        note: _noteController.text,
        isCompleted: 0,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        color: _selectColor,
        remind: _selectReminder,
        repeat: _selectRepeat)
    );
  }
}
