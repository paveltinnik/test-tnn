import 'package:flutter/material.dart';
import 'package:moneylover/locator.dart';
import '../../database/moor_database.dart';
import '../../enums/viewstate.dart';
import '../../services/moordatabase_service.dart';
import '../base_model.dart';

class UserModel extends BaseModel {
  final MoorDatabaseService _moorDatabaseService = locator<MoorDatabaseService>();
  ScrollController scrollController = ScrollController(); // set controller on scrolling

  List<User> users = <User>[];

  init() async {
    users = await _moorDatabaseService.getAllUsers();

    // show the list
    setState(ViewState.Idle);
    notifyListeners();
  }

  void deleteUser(User user) async {
    await _moorDatabaseService.deleteUser(user);
  }
}
