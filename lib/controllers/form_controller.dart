import 'package:flutter/material.dart';

class FormController {
  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  GlobalKey<FormState>? _formKey;

  FormController() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  TextEditingController getNameController() {
    return _nameController!;
  }

  TextEditingController getPhoneController() {
    return _phoneController!;
  }

  GlobalKey<FormState> getFormKey() {
    return _formKey!;
  }

  String? validateNameController(String? value) {
    if (value!.isEmpty) {
      return "Preencha o campo corretamente!";
    }
  }

  String? validatePhoneController(String? value) {
    if (value!.isEmpty) {
      return "Preencha o campo corretamente!";
    }
  }

  void setNameControllerText(String name) {
    _nameController!.text = name;
  }

  void setPhoneControllerText(String phone) {
    _phoneController!.text = phone;
  }

  void resetFields() {
    _nameController!.text = "";
    _phoneController!.text = "";
    _formKey = GlobalKey<FormState>();
  }
}
