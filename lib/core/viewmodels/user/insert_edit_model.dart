import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:toast/toast.dart';
import '../../../locator.dart';
import '../../database/moor_database.dart';
import '../../services/moordatabase_service.dart';
import '../base_model.dart';

class InsertUserModel extends BaseModel {
  final MoorDatabaseService _moorDatabaseService = locator<MoorDatabaseService>();

  ScrollController scrollController = ScrollController(); // set controller on scrolling

  TextEditingController nameController = TextEditingController();

  bool show = true;
  bool isCollapsed = false;

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  init() {
    notifyListeners();
  }

  Future addUser(context) async {
    String name = nameController.text;

    ToastContext().init(context);

    if (name.isEmpty) {
      Toast.show("Пожалуйста заполните все поля!", duration: Toast.lengthLong, gravity: Toast.bottom);
      return;
    }

    UsersCompanion newUser = UsersCompanion(
        name: Value(nameController.text),
        );

    // insert it!
    await _moorDatabaseService.insertUser(newUser);

    Toast.show("Добавлено удачно!", duration: Toast.lengthShort, gravity: Toast.bottom);

    // return to the home
    Navigator.of(context)
        .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);

    Navigator.of(context).pushNamed('users');
  }
}