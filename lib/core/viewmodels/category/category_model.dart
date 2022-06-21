import 'package:flutter/material.dart';
import 'package:moneylover/locator.dart';
import 'package:moor/moor.dart';
import 'package:toast/toast.dart';
import '../../database/moor_database.dart';
import '../../enums/viewstate.dart';
import '../../services/moordatabase_service.dart';
import '../base_model.dart';

class CategoryModel extends BaseModel {
  final MoorDatabaseService _moorDatabaseService = locator<MoorDatabaseService>();
  ScrollController scrollController = ScrollController();
  TextEditingController nameController = TextEditingController();

  List<Category> categories = <Category>[];

  late Category? currentCategory;

  init({String? transactionType, Category? category, required bool isInsertView}) async {
    if (category != null) {
      currentCategory = category;
      nameController.text = category.name;
    } else if (category == null && !isInsertView) {
      categories = await _moorDatabaseService.getAllCategoriesByType(transactionType!);
    }

    notifyListeners();
  }

  Future addCategory(context, transactionType) async {
    String name = nameController.text;
    String type = transactionType;

    ToastContext().init(context);

    if (name.isEmpty) {
      Toast.show("Пожалуйста заполните все поля!", duration: Toast.lengthLong, gravity: Toast.bottom);
      return;
    }

    CategoriesCompanion newCategory = CategoriesCompanion(
      name: Value(nameController.text),
      type: Value(type),
    );

    // insert it!
    await _moorDatabaseService.insertCategory(newCategory);

    Toast.show("Добавлено удачно!", duration: Toast.lengthShort, gravity: Toast.bottom);

    // return to the home
    Navigator.of(context)
        .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);

    Navigator.of(context).pushNamed('categories', arguments: true);
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
        id: currentCategory!.id,
        name: name,
        type: type
    );

    // insert it!
    await _moorDatabaseService.updateCategory(newCategory);

    Toast.show("Добавлено удачно!", duration: Toast.lengthShort, gravity: Toast.bottom);

    // return to the home
    Navigator.of(context)
        .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);

    Navigator.of(context).pushNamed('categories', arguments: false);
  }

  void deleteCategory(Category category) async {
    await _moorDatabaseService.deleteCategory(category);
  }

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  TextFormField buildTextField(TextEditingController controller, String text,
      String helperText, IconData icon, isNumeric) {
    return TextFormField(
      cursorColor: Colors.black,
      maxLength: isNumeric ? 10 : 40,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        labelText: text,
        suffixIcon: InkWell(
          onTap: () {
            controller.clear();
          },
          child: const Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        labelStyle: const TextStyle(
          color: Color(0xFFFF000000),
        ),
        helperText: helperText,
      ),
    );
  }
}
