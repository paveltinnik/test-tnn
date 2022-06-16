import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moor/moor.dart';
import 'package:toast/toast.dart';

import '../../../locator.dart';
import '../../../ui/views/category/categories_view.dart';
import '../../../ui/views/users/users_view.dart';
import '../../database/moor_database.dart';
import '../../services/moordatabase_service.dart';
import '../base_model.dart';

class InsertTransactionModel extends BaseModel {
  final MoorDatabaseService _moorDatabaseService = locator<MoorDatabaseService>();
  ScrollController scrollController = ScrollController(); // set controller on scrolling
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  late Category category;
  late String categoryName = 'Не выбрана';
  late User user;
  late String userName = 'Не выбран';
  DateTime date = DateTime.now();
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  init() {
    notifyListeners();
  }

  Future addTransaction(context) async {
    String description = descriptionController.text;
    String amount = amountController.text;

    ToastContext().init(context);

    if (description.isEmpty || amount.isEmpty || categoryName == 'Не выбрана' || userName == 'Не выбран') {
      Toast.show("Пожалуйста заполните все поля!", duration: Toast.lengthLong, gravity: Toast.bottom);
      return;
    }

    TransactionsCompanion newTransaction = TransactionsCompanion(
      description: Value(descriptionController.text),
      amount: Value(double.parse(amountController.text)),
      category: Value(category.id),
      user: Value(user.id),
      date: Value(date)
    );

    // insert it!
    await _moorDatabaseService.insertTransaction(newTransaction);

    Toast.show("Добавлено удачно!", duration: Toast.lengthShort, gravity: Toast.bottom);

    // return to the home
    Navigator.of(context)
        .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
  }

  Future<Category> _awaitReturnValueFromCategoryView(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoriesView(false),
        ));

    return result as Category;
  }

  Future<User> _awaitReturnValueFromUsersView(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UsersView(false),
        ));

    return result;
  }

  setCategoryName(context) async {
    await _awaitReturnValueFromCategoryView(context)
        .then((value) => category = value);

    categoryName = category.name;

    notifyListeners();
  }

  setUserName(context) async {
    await _awaitReturnValueFromUsersView(context)
        .then((value) => user = value);

    userName = user.name;

    notifyListeners();
  }

  String getSelectedDate() {
    return '${date.day.toString().padLeft(2,'0')}'
        '.${date.month.toString().padLeft(2,'0')}'
        '.${date.year.toString()}';
  }

  Future selectDate(context) async {
    // hide the keyboard
    unFocusFromTheTextField(context);

    date = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now()))!;

    notifyListeners();
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
        labelStyle: TextStyle(
          color: Color(0xFFFF000000),
        ),
        helperText: helperText,
      ),
    );
  }
}