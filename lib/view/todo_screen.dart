import 'package:eesa_braa/controller/tasks_controller.dart';
import 'package:eesa_braa/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eesa_braa/model/task.dart';

class TodoScreen extends StatelessWidget {
  final TodoController controller = Get.put(TodoController());
  final User user;

  TodoScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(builder: (todoController) {
      return Scaffold(
        appBar: AppBar(
          title: Text('مهام : ${user.name}'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'مجموع النقاط: ${user.totalPoints}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      _showAddTaskDialog(context, false);
                    },
                    color: Colors.red,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      _showAddTaskDialog(context, true);
                    },
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: user.tasks.length,
                itemBuilder: (context, index) {
                  Task task = user.tasks[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Increase the radius as desired
                        side: BorderSide(
                            color: task.isGood ? Colors.blue : Colors.red, width: 2), // Add border color and width
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            task.name,
                            style: const TextStyle(fontSize: 18),
                          ),
                          leading: Text(
                            task.points.toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  controller.decrementTaskCount(user, index);
                                },
                              ),
                              Text(
                                task.count.toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  controller.incrementTaskCount(user, index);
                                },
                              ),
                            ],
                          ),
                          onLongPress: () {
                            controller.removeTaskFromUser(user, task);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  void _showAddTaskDialog(BuildContext context, bool isGood) {
    String taskName = '';
    int taskPoints = 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('إضافه مهمه جديده'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'إسم المهمه'),
                onChanged: (value) {
                  taskName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'عدد النقاط'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  taskPoints = int.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                if (taskName.isNotEmpty) {
                  controller.addTaskToUser(
                      user,
                      Task(
                          name: taskName,
                          points: isGood ? taskPoints : taskPoints * -1,
                          userId: user.userId,
                          isGood: isGood));
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
