// import 'package:eesa_braa/model/user.dart';
// import 'package:eesa_braa/view/users_list.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:get_storage/get_storage.dart';

// class UsersController extends GetxController {
//   final _users = <User>[].obs;
//   List<User> get users => _users.toList();

//   final _localStorage = GetStorage();

//   @override
//   void onInit() {
//     super.onInit();
//     // Load users from local storage when the controller is initialized
//     _loadUsers();
//   }

//   void _loadUsers() {
//     final List<dynamic>? usersData = _localStorage.read<List<dynamic>>('users');
//     if (usersData != null) {
//       _users.assignAll(usersData.map((data) => User.fromJson(data)).toList());
//     }
//   }

//   void _saveUsers() {
//     _localStorage.write('users', _users.toList());
//   }

//   void addUser(User user) {
//     _users.add(user);
//     _saveUsers();
//   }

//   void removeUser(User user) {
//     _users.remove(user);
//     _saveUsers();
//   }
// }
