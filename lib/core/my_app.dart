import 'package:final_list/controllers/contact_controller.dart';
import 'package:final_list/helpers/database_helper.dart';
import 'package:final_list/models/contact_model.dart';
import 'package:final_list/views/add_contact_page.dart';
import 'package:final_list/views/edit_contact_page.dart';
import 'package:final_list/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DatabaseHelper _dbHelper = Get.put<DatabaseHelper>(DatabaseHelper());
  ContactController _contactController =
      Get.put<ContactController>(ContactController());
  ContactModel _contactModel = Get.put<ContactModel>(ContactModel());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      getPages: _getRoutes(),
    );
  }

  _getRoutes() {
    return [
      GetPage(name: "/", page: () => HomePage()),
      GetPage(name: "/addContactPage", page: () => AddContactPage()),
      GetPage(name: "/editContactPage", page: () => EditContactPage())
    ];
  }
}
