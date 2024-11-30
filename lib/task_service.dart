import 'package:flutter/material.dart';
import 'package:help/db_service.dart';
import 'package:help/task_model.dart';

class TaskService extends ChangeNotifier {
  FirebaseService dbService = FirebaseService();

  List<TaskModel> _tasks = [];
  List<TaskModel> get getTaskList => _tasks;

  void notify() {
    notifyListeners();
  }

  Future<void> createTask(String title, String description, String uid) async {
    await dbService.createTask(title, description, uid);
    refreshTasksList();
  }

  Future<void> refreshTasksList() async {
    final taskfromDb = await dbService.getAllTasks();
    _tasks = taskfromDb;
    notifyListeners();
  }
}
