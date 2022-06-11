import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:moor/moor.dart';
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

  // late String currentName;
  bool show = true;
  bool isCollapsed = false;

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  init(User user) {
    currentUser = user;
    nameController.text = user.name;

    // handleScroll();
    notifyListeners();
  }

  void handleScroll() async {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideFloationButton();
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showFloationButton();
      }
    });
  }

  void showFloationButton() {
    show = true;
    notifyListeners();
  }

  void hideFloationButton() {
    show = false;
    notifyListeners();
  }

  Future editUser(context, id) async {
    String currentName = nameController.text;

    ToastContext().init(context);

    if (currentName.isEmpty) {
      Toast.show("Please fill all the fields!", duration: Toast.lengthLong, gravity: Toast.bottom);
      return;
    }

    User newUser = User(name: currentName, id: id);

    // insert it!
    await _moorDatabaseService.updateUser(newUser);

    Toast.show("Edited successfully!", duration: Toast.lengthShort, gravity: Toast.bottom);

    // return to the home
    Navigator.of(context)
        .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);

    Navigator.of(context).pushNamed('users');
  }
}