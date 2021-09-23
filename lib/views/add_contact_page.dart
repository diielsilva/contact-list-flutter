import 'package:final_list/controllers/contact_controller.dart';
import 'package:final_list/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  ContactController _controller = Get.find<ContactController>();
  ContactModel _contact = ContactModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getHeaderAddContactPage(),
      body: _getBodyAddContactPage(),
    );
  }

  _getHeaderAddContactPage() {
    return AppBar(
      leading: _getBackRouteButton(),
      title: Text("Adicionar Contato"),
      centerTitle: true,
    );
  }

  _getBackRouteButton() {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        _controller.getFormController().resetFields();
        _controller.resetCurrentState();
        Get.back();
      },
    );
  }

  _getBodyAddContactPage() {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Form(
          key: _controller.getFormController().getFormKey(),
          child: Column(
            children: [
              _getNameField(),
              _getPhoneField(),
              _getSubmitButton(),
              _getCurrentState()
            ],
          ),
        ),
      ),
    );
  }

  _getNameField() {
    return TextFormField(
      controller: _controller.getFormController().getNameController(),
      validator: (value) =>
          _controller.getFormController().validateNameController(value),
      keyboardType: TextInputType.name,
      decoration: InputDecoration(labelText: "Nome"),
    );
  }

  _getPhoneField() {
    return TextFormField(
      controller: _controller.getFormController().getPhoneController(),
      validator: (value) =>
          _controller.getFormController().validatePhoneController(value),
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(labelText: "Telefone"),
    );
  }

  _getSubmitButton() {
    return Container(
      margin: EdgeInsets.all(15),
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: Text("Cadastrar"), margin: EdgeInsets.all(5)),
            Container(child: Icon(Icons.person_add), margin: EdgeInsets.all(5))
          ],
        ),
        onPressed: () async {
          _contact.setName(
              _controller.getFormController().getNameController().text);
          _contact.setPhone(
              _controller.getFormController().getPhoneController().text);
          await _controller.storeContact(_contact);
          await _controller.getAllContacts();
        },
      ),
    );
  }

  _getCurrentState() {
    return GetX<ContactController>(
      builder: (_) {
        switch (_controller.getCurrentState().value) {
          case "initial":
            return _getInitialState();
          case "loading":
            return _getLoadingState();
          case "sucess":
            return _getSuccessState();
          case "error":
            return _getErrorState();
          default:
            return _getInitialState();
        }
      },
    );
  }

  _getInitialState() {
    return Container();
  }

  _getLoadingState() {
    return Center(
      child: Container(
        child: LinearProgressIndicator(),
        margin: EdgeInsets.all(10),
      ),
    );
  }

  _getSuccessState() {
    return Center(
      child: Text(
        "Usuário cadastrado com sucesso!",
        style: TextStyle(color: Colors.green),
      ),
    );
  }

  _getErrorState() {
    return Center(
      child: Text(
        "Algo deu errado, tente novamente!",
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
