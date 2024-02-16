import 'dart:math';

import 'package:eesa_braa/controller/tasks_controller.dart';
import 'package:eesa_braa/model/user.dart';
import 'package:eesa_braa/view/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersScreen extends StatelessWidget {
  final TodoController controller = Get.put(TodoController());

  UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 200, bottom: 20),
        child: GetBuilder<TodoController>(
          builder: (usersController) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: usersController.users.map((user) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                          child: InkWell(
                            onTap: () => Get.to(() => TodoScreen(
                                  user: user,
                                )),
                            child: Card(
                              color: user.name == "عيسى" ? Colors.blue : Colors.pink,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20), // Increase the radius as desired
                                side: BorderSide(color: user.name == "عيسى" ? Colors.blue : Colors.pink, width: 2),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    user.name == "عيسى" ? "assets/eesaa.jpg" : "assets/braa.jpg",
                                  ),
                                ),
                                title: Text(
                                  user.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  'مجموع النقاط: ${user.totalPoints} | المهام: ${user.tasks.length}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showAddUserDialog(context);
                  },
                  child: const Text('إضافه'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showAddUserDialog(BuildContext context) {
    String userName = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New User'),
          content: TextField(
            decoration: const InputDecoration(labelText: 'User Name'),
            onChanged: (value) {
              userName = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (userName.isNotEmpty) {
                  controller.addUser(
                      User(name: userName, avatarUrl: 'assets/default_avatar.jpg', userId: Random.secure().toString()));
                  Navigator.pop(context);
                } else {
                  // Show error message or handle invalid input
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
