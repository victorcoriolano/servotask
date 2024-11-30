import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:help/auth_service.dart';
import 'package:help/creation_page.dart';
import 'package:help/db_service.dart';
import 'package:help/task_model.dart';
import 'package:help/task_service.dart';
import 'package:help/task_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  FirebaseService dbService = FirebaseService();

  late final tsProvider = Provider.of<TaskService>(context, listen: false);
  late final tsConsumer = Provider.of<TaskService>(context);

  Future<void> _loadTasks() async {
    await tsProvider.refreshTasksList();
  }

  @override
  void initState() {
    super.initState();

    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          onPressed: onPressed1, child: const Icon(Icons.add)),
      appBar: AppBar(
          title: Text('Gerenciador de Tarefas - ${authService.user!.name}'),
          centerTitle: true,
          titleSpacing: 2.0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 600,
                width: 400,
                child: _buildTaskList(tsConsumer.getTaskList),
              ))
        ],
      ),
    );
  }

  _buildTaskList(List<TaskModel> tasks) {
    return tasks.isEmpty
        ? const Center(child: Text('Nada por aqui ainda.'))
        : ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Card(
                  borderOnForeground: false,
                  margin: const EdgeInsetsDirectional.symmetric(
                      vertical: 4.0, horizontal: 5.5),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: TaskWidget(
                    task: task,
                    deleteMethod: deleteTask,
                  ));
            });
  }

  void deleteTask(String title) async {
    await dbService.deleteTask(title);
    tsProvider.notify();
    await tsConsumer.refreshTasksList();
    return;
  }

  void onPressed1() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CreationPage()));
  }
}
