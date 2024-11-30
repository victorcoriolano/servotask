import 'package:flutter/material.dart';
import 'package:help/task_model.dart';

class TaskWidget extends StatefulWidget {
  final TaskModel task;
  final void Function(String title) deleteMethod;
  const TaskWidget({super.key, required this.task, required this.deleteMethod});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  MediaQueryData? mediaQueryData;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                  width: mediaQueryData!.size.width * 0.4,
                  height: mediaQueryData!.size.height * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 228, 226, 121),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(widget.task.title),
                        Text(widget.task.description,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        Text(widget.task.createdDate),
                      ],
                    ),
                  )),
            ),
            Positioned(
                left: 5,
                child: Container(
                  width: mediaQueryData!.size.width * 0.4,
                  height: mediaQueryData!.size.height * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 214, 214, 214),
                  ),
                  child: Center(
                      child: Checkbox(
                          value: widget.task.isCompleted,
                          onChanged: (value) {
                            bool valor = value!;
                            setState(() {
                              value = !valor;
                            });
                          })),
                )),
            Positioned(
              right: 5,
              child: Container(
                width: mediaQueryData?.size.width ?? 80,
                height: mediaQueryData?.size.height ?? 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 168, 42, 42),
                ),
                child: Center(
                    child: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    widget.deleteMethod;
                  },
                )),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
