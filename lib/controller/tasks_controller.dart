import 'package:eesa_braa/model/task.dart';
import 'package:eesa_braa/model/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TodoController extends GetxController {
  final _users = <User>[];
  List<User> get users => _users.toList();

  void addUser(User user) {
    _users.add(user);
    _saveUsers();
  }

  void removeUser(User user) {
    _users.remove(user);
    _saveUsers();
  }

  void addTaskToUser(User user, Task task) {
    user.tasks.add(task);
    _saveUsers();
  }

  void removeTaskFromUser(User user, Task task) {
    user.tasks.remove(task);
    _saveUsers();
  }

  void incrementTaskCount(User user, int index) {
    user.tasks[index].count++;
    _saveUsers();
  }

  void decrementTaskCount(User user, int index) {
    if (user.tasks[index].count > 0) {
      user.tasks[index].count--;
      _saveUsers();
    }
  }

  void _saveUsers() {
    final box = GetStorage();
    box.write('users', _users.map((user) => user.toJson()).toList());
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _loadUsers();
  }

  void _loadUsers() {
    final box = GetStorage();
    final List<dynamic>? usersData = box.read<List<dynamic>>('users');
    if (usersData != null) {
      _users.assignAll(usersData.map((data) => User.fromJson(data)).toList());
    }
    update();
  }
}
