import 'package:flutter/material.dart';
import 'package:moneylover/locator.dart';
import 'package:toast/toast.dart';
import '../../database/moor_database.dart';
import '../../services/moordatabase_service.dart';
import '../base_model.dart';
import 'package:moor/moor.dart';

class UserModel extends BaseModel {
  final MoorDatabaseService _moorDatabaseService = locator<MoorDatabaseService>();
  ScrollController scrollController = ScrollController(); // set controller on scrolling
  TextEditingController nameController = TextEditingController();

  List<User> users = <User>[];

  late User? currentUser;

  init({User? user, required bool isInsertView}) async {
    if (user != null) {
      currentUser = user;
      nameController.text = user.name;
    } else if (user == null && !isInsertView) {
      users = await _moorDatabaseService.getAllUsers();
    }

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

    Navigator.of(context).pushNamed('users', arguments: true);
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
    Navigator.of(context).pushNamed('users', arguments: true);
  }

  void deleteUser(User user) async {
    await _moorDatabaseService.deleteUser(user);
  }

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
