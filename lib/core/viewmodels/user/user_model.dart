import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:moneylover/locator.dart';

// import '../../locator.dart';
import '../../database/moor_database.dart';
import '../../enums/viewstate.dart';
import '../../services/moordatabase_service.dart';
import '../base_model.dart';

class UserModel extends BaseModel {
  // final MoorDatabaseService _moorDatabaseService = locator<MoorDatabaseService>();
  final MoorDatabaseService _moorDatabaseService = locator<MoorDatabaseService>();

  ScrollController scrollController = ScrollController(); // set controller on scrolling
  bool show = true;

  List<User> users = <User>[];
  bool isCollapsed = false;

  init() async {
    handleScroll();

    // show the loading bar
    // setState(ViewState.Busy);
    // notifyListeners();

    users = await _moorDatabaseService.getAllUsers();

    // show the list
    setState(ViewState.Idle);
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
}
