import 'package:eesa_braa/model/task.dart';

class User {
  final String userId;
  final String name;
  final String avatarUrl;
  List<Task> tasks;
  int get totalPoints {
    int sum = 0;
    for (var task in tasks) {
      sum += task.points * task.count;
    }
    return sum;
  }

  User({
    required this.userId,
    required this.name,
    required this.avatarUrl,
    List<Task>? tasks,
  }) : tasks = tasks ?? [];

  User.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        name = json['name'],
        avatarUrl = json['avatarUrl'],
        tasks = (json['tasks'] as List<dynamic>?)?.map((taskJson) => Task.fromJson(taskJson)).toList() ?? [];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'avatarUrl': avatarUrl,
        'tasks': tasks.map((task) => task.toJson()).toList(),
      };
}
