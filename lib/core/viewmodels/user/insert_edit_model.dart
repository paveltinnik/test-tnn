import 'package:flutter/material.dart';

class InsertEditUserModel {
  TextEditingController nameController = TextEditingController();

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

// void init(int selectedCategory, int index) {
//   // initla values are current day and month
//   selectedMonth = months[DateTime.now().month - 1];
//   selectedDay = DateTime.now().day.toString();
//   type = (selectedCategory == 1) ? 'income' : 'expense';
//   cateogryIndex = index;
// }
}