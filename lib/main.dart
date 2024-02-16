import 'package:eesa_braa/view/users_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'عيسى وبراءه',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black), // Optional: Specify text color
        // Set text direction to right-to-left
      ),
      home: Directionality(
        textDirection: TextDirection.rtl, // Set text direction to right-to-left
        child: UsersScreen(),
      ),
    );
  }
}
