class TaskModel {
  final String title;
  final String description;
  final DateTime createdDate = DateTime.now();
  final bool isCompleted = false;

  TaskModel(this.title, this.description);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      json['title'],
      json['description'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'description': description,
        'createdDate': createdDate,
        'isCompleted': isCompleted
      };

  @override
  String toString() {
    return 'Task de $title, description: $description, created at: $createdDate, is completed: $isCompleted';
  }
}
