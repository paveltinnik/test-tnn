import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:toast/toast.dart';
import '../../../locator.dart';
import '../../database/moor_database.dart';
import '../../services/moordatabase_service.dart';
import '../base_model.dart';

class EditCategoryModel extends BaseModel {
  final MoorDatabaseService _moorDatabaseService = locator<MoorDatabaseService>();
  ScrollController scrollController = ScrollController(); // set controller on scrolling
  TextEditingController nameController = TextEditingController();

  late Category currentCategory;

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  init(Category category) {
    currentCategory = category;
    nameController.text = category.name;
    notifyListeners();
  }

  Future updateCategory(context, transactionType) async {
    String name = nameController.text;
    String type = transactionType;

    ToastContext().init(context);

    if (name.isEmpty) {
      Toast.show("Пожалуйста заполните все поля!", duration: Toast.lengthLong, gravity: Toast.bottom);
      return;
    }

    Category newCategory = Category(
        id: currentCategory.id,
        name: name,
        type: type
    );

    // insert it!
    await _moorDatabaseService.updateCategory(newCategory);

    Toast.show("Добавлено удачно!", duration: Toast.lengthShort, gravity: Toast.bottom);

    // return to the home
    Navigator.of(context)
        .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);

    Navigator.of(context).pushNamed('categories');
  }
}