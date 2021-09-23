import 'package:final_list/controllers/form_controller.dart';
import 'package:final_list/helpers/database_helper.dart';
import 'package:final_list/models/contact_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class ContactController extends GetxController {
  FormController? _formController;
  RxString? _currentState;
  RxList? _contactsList;

  ContactController() {
    _formController = FormController();
    _currentState = "initial".obs;
    _contactsList = [].obs;
  }

  Future<void> storeContact(ContactModel contact) async {
    if (_formController!.getFormKey().currentState!.validate()) {
      _currentState!.value = "loading";
      DatabaseHelper dbHelper = Get.find<DatabaseHelper>();
      Database database = await dbHelper.openConnection();
      int result = await database.rawInsert(
          "INSERT INTO contacts (id, name, phone) VALUES (NULL,?,?)",
          [contact.getName(), contact.getPhone()]);
      await Future.delayed(Duration(seconds: 3));
      if (result == 0) {
        _currentState!.value == "error";
      } else {
        _currentState!.value = "sucess";
      }
      await database.close();
    } else {
      _currentState!.value = "error";
    }
  }

  Future<void> updateContact(ContactModel contact) async {
    if (_formController!.getFormKey().currentState!.validate()) {
      _currentState!.value = "loading";
      DatabaseHelper dbHelper = Get.find<DatabaseHelper>();
      Database database = await dbHelper.openConnection();
      int result = await database.rawUpdate(
          "UPDATE contacts SET name = ?, phone = ? WHERE id = ?",
          [contact.getName(), contact.getPhone(), contact.getId()]);
      await Future.delayed(Duration(seconds: 3));
      if (result == 0) {
        _currentState!.value = "error";
      } else {
        _currentState!.value = "sucess";
      }
      await database.close();
    } else {
      _currentState!.value = "error";
    }
  }

  Future<void> deleteContact(ContactModel contact) async {
    _currentState!.value = "loading";
    DatabaseHelper dbHelper = Get.find<DatabaseHelper>();
    Database database = await dbHelper.openConnection();
    int result = await database
        .rawDelete("DELETE FROM contacts WHERE id = ?", [contact.getId()]);
    if (result == 0) {
      _currentState!.value = "error";
    } else {
      _currentState!.value = "sucess";
    }
    await database.close();
  }

  Future<void> getAllContacts() async {
    _contactsList!.clear();
    DatabaseHelper dbHelper = Get.find<DatabaseHelper>();
    Database database = await dbHelper.openConnection();
    List<Map<String, Object?>> resultQuery =
        await database.rawQuery("SELECT * FROM contacts");
    for (Map<String, Object?> element in resultQuery) {
      _contactsList!.add(ContactModel.fromMap(element));
    }
    await database.close();
  }

  RxString getCurrentState() {
    return _currentState!;
  }

  RxList getContactsList() {
    return _contactsList!;
  }

  FormController getFormController() {
    return _formController!;
  }

  void resetCurrentState() {
    _currentState!.value = "initial";
  }
}
