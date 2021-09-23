import 'package:final_list/controllers/contact_controller.dart';
import 'package:final_list/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactController _controller = Get.find<ContactController>();

  @override
  void initState() {
    _controller.getAllContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getHeaderHomePage(),
      body: _getBodyHomePage(),
      floatingActionButton: _getAddContactPageButton(),
    );
  }

  _getHeaderHomePage() {
    return AppBar(
      title: Text("Lista de Contatos"),
      centerTitle: true,
    );
  }

  _getBodyHomePage() {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: _result(),
      ),
    );
  }

  _result() {
    return GetX<ContactController>(
      builder: (_) {
        if (_controller.getContactsList().isEmpty) {
          return _resultEmptyList();
        } else {
          return _resultNotEmptyList();
        }
      },
    );
  }

  _resultEmptyList() {
    return Center(
      child: Text("Nenhum usuário encontrado"),
    );
  }

  _resultNotEmptyList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _controller.getContactsList().length,
      itemBuilder: (_, index) {
        return _getContact(_controller.getContactsList().elementAt(index));
      },
    );
  }

  _getContact(ContactModel contact) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: Key(contact.getId().toString()),
      onDismissed: (direction) async {
        await _controller.deleteContact(contact);
        await _controller.getAllContacts();
      },
      background: Container(
        color: Colors.red,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              Text(
                "Remover",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
      child: Card(
        child: ListTile(
          onTap: () {
            ContactModel contactModel = Get.find<ContactModel>();
            _controller
                .getFormController()
                .setNameControllerText(contact.getName());
            _controller
                .getFormController()
                .setPhoneControllerText(contact.getPhone());
            contactModel.setId(contact.getId());
            Get.toNamed("/editContactPage");
          },
          leading: CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(contact.getName()),
          subtitle: Text("Tel:${contact.getPhone()}"),
          trailing: IconButton(
              icon: Icon(Icons.phone),
              onPressed: () async {
                await launch("tel:${contact.getPhone()}");
              }),
        ),
      ),
    );
  }

  _getAddContactPageButton() {
    return FloatingActionButton(
      child: Icon(Icons.person_add),
      onPressed: () {
        _controller.resetCurrentState();
        Get.toNamed("/addContactPage");
      },
    );
  }
}
