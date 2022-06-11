import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../../locator.dart';
import '../../database/moor_database.dart';
import '../../services/moordatabase_service.dart';
import '../base_model.dart';

class EditUserModel extends BaseModel {
  final MoorDatabaseService _moorDatabaseService = locator<MoorDatabaseService>();

  ScrollController scrollController = ScrollController(); // set controller on scrolling
  TextEditingController nameController = TextEditingController();

  late User currentUser;

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  init(User user) {
    currentUser = user;
    nameController.text = user.name;

    notifyListeners();
  }

  Future editUser(context, id) async {
    String currentName = nameController.text;

    ToastContext().init(context);

    if (currentName.isEmpty) {
      Toast.show("Пожалуйста заполните все поля!", duration: Toast.lengthLong, gravity: Toast.bottom);
      return;
    }

    User newUser = User(name: currentName, id: id);

    // insert it!
    await _moorDatabaseService.updateUser(newUser);

    Toast.show("Изменено успешно!", duration: Toast.lengthShort, gravity: Toast.bottom);

    // return to the home
    Navigator.of(context)
        .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);

    // return back to users
    Navigator.of(context).pushNamed('users');
  }
}