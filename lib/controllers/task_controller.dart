import 'package:get/get.dart';
import 'package:to_do_app/db/db_helper.dart';
import 'package:to_do_app/models/task.dart';

class TaskController extends GetxController{
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  Future<int?> addTask({required Task task})async {
    return await DBHelper.insert(task);
  }
}