class ContactModel {
  int? _id;
  String? _name;
  String? _phone;

  ContactModel() {}

  ContactModel.fromMap(Map<String, dynamic> map) {
    _id = map["id"];
    _name = map["name"];
    _phone = map["phone"];
  }

  void setId(int id) {
    _id = id;
  }

  int getId() {
    return _id!;
  }

  void setName(String name) {
    _name = name;
  }

  String getName() {
    return _name!;
  }

  void setPhone(String phone) {
    _phone = phone;
  }

  String getPhone() {
    return _phone!;
  }
}
