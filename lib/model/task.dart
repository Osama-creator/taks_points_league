import 'package:get/get.dart';

class Task extends GetxController {
  String name;
  int points;
  int count;
  bool isGood;
  String userId;

  Task({required this.name, required this.points, this.count = 0, required this.userId, this.isGood = true});

  Task.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        points = json['points'],
        count = json['count'],
        userId = json['userId'],
        isGood = json['isGood'];

  Map<String, dynamic> toJson() => {'name': name, 'points': points, 'count': count, 'userId': userId, 'isGood': isGood};
}
