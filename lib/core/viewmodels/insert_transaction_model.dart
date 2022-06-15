// import 'package:flutter/material.dart';
// // import 'package:moneymanager/core/database/moor_database.dart';
// // import 'package:moneymanager/core/services/moordatabase_service.dart';
// import 'package:moneylover/core/viewmodels/base_model.dart';
// import 'package:toast/toast.dart';
//
// import '../../locator.dart';
// import 'base_model.dart';
//
// class InsertTransactionModel extends BaseModel {
//   TextEditingController memoController = TextEditingController();
//   TextEditingController amountController = TextEditingController();
//
//   // final MoorDatabaseService _moorDatabaseService = locator<MoorDatabaseService>();
//
//   List months = [
//     'Jan',
//     'Feb',
//     'Mar',
//     'Apr',
//     'May',
//     'Jun',
//     'Jul',
//     'Aug',
//     'Sep',
//     'Oct',
//     'Nov',
//     'Dec'
//   ];
//
//   late String selectedDay;
//   late String selectedMonth;
//   DateTime selectedDate = new DateTime.now();
//   late String type;
//   late int cateogryIndex;
//
//   Future selectDate(context) async {
//     // hide the keyboard
//     unFocusFromTheTextField(context);
//
//     DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDate,
//         firstDate: DateTime(2020),
//         lastDate: DateTime.now());
//
//     if (picked != null) {
//       selectedMonth = months[picked.month - 1];
//       selectedDay = picked.day.toString();
//       selectedDate = picked;
//
//       notifyListeners();
//     }
//   }
//
//   void init(int selectedCategory, int index) {
//     // initla values are current day and month
//     selectedMonth = months[DateTime.now().month - 1];
//     selectedDay = DateTime.now().day.toString();
//     type = (selectedCategory == 1) ? 'income' : 'expense';
//     cateogryIndex = index;
//   }
//
//   void unFocusFromTheTextField(context) {
//     FocusScope.of(context).requestFocus(new FocusNode());
//   }
//
//   String getSelectedDate() {
//     if (int.parse(selectedDay) == DateTime.now().day &&
//         DateTime.now().month == months.indexOf(selectedMonth) + 1) {
//       return 'Сегодня ' + selectedMonth + ',' + selectedDay;
//     } else {
//       return selectedMonth + ',' + selectedDay;
//     }
//   }
//
//   addTransaction(context) async {
//     String memo = memoController.text;
//     String amount = amountController.text;
//
//     // ToastContext.init(context);
//
//     if (memo.length == 0 || amount.length == 0) {
//       Toast.show("Пожалуйста, заполните все поля!", duration: Toast.lengthShort, gravity: Toast.bottom);
//       return;
//     }
//
//     // Transaction newTransaction = new Transaction(
//     //     type: type,
//     //     day: selectedDay,
//     //     month: selectedMonth,
//     //     memo: memoController.text,
//     //     amount: int.parse(amount),
//     //     categoryindex: cateogryIndex);
//     // // insert it!
//     // await _moorDatabaseService.insertTransaction(newTransaction);
//
//     Toast.show("Добавлено успешно", duration: Toast.lengthShort, gravity: Toast.bottom);
//     // return to the home
//     Navigator.of(context)
//         .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
//   }
// }
