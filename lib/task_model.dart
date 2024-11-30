import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String uid;
  final String title;
  final String description;
  final String createdDate;
  final bool isCompleted;

  TaskModel(this.title, this.description, this.createdDate, this.isCompleted, this.uid);

  factory TaskModel.fromJson(DocumentSnapshot json) {
    return TaskModel(
      json['title'],
      json['description'],
      json['createdDate'],
      json['isCompleted'],
      json['uid'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'description': description,
        'createdDate': createdDate,
        'isCompleted': isCompleted,
        'uid': uid
      };

  @override
  String toString() {
    return 'Task de $title, description: $description, created at: $createdDate, is completed: $isCompleted';
  }
}
