import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneylover/locator.dart';
import 'package:moneylover/ui/widgets/common/text_form_field_widget.dart';
import 'package:moor/moor.dart';
import 'package:toast/toast.dart';
import '../../../ui/views/category/categories_view.dart';
import '../../../ui/views/users/users_view.dart';
import '../../database/moor_database.dart';
import '../../enums/viewstate.dart';
import '../../services/moordatabase_service.dart';
import '../base_model.dart';

class TransactionModel extends BaseModel {
  CustomTextFormField customTextFormField = CustomTextFormField();
  final MoorDatabaseService _moorDatabaseService = locator<MoorDatabaseService>();
  ScrollController scrollController = ScrollController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  List<TransactionWithCategoryAndUser> listOfTransactionsData = <TransactionWithCategoryAndUser>[];

  late Transaction transaction;
  late Category category;
  late User user;

  late String categoryName = 'Не выбрана';
  late String userName = 'Не выбран';
  DateTime date = DateTime.now();
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  init(TransactionWithCategoryAndUser? singleTransactionData) async {
    if (singleTransactionData != null) {      // For editTransactionView
      category = singleTransactionData.category;
      user = singleTransactionData.user;
      transaction = singleTransactionData.transaction;

      categoryName = category.name;
      userName = user.name;
      date = transaction.date;
      descriptionController.text = transaction.description;
      amountController.text = transaction.amount.toString();
    } else {      // For transactionsView
      listOfTransactionsData = await _moorDatabaseService.getAllTransactions();
    }

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

  void updateTransaction(context) async {
    // String newDescription = descriptionController.text;
    // String newAmount = amountController.text;

    ToastContext().init(context);

    if (descriptionController.text.isEmpty || amountController.text.isEmpty) {
      Toast.show("Пожалуйста заполните все поля!", duration: Toast.lengthLong, gravity: Toast.bottom);
      return;
    }

    Transaction newTransaction = Transaction(
        id: transaction.id,
        description: descriptionController.text,
        amount: double.parse(amountController.text),
        category: category.id,
        user: user.id,
        date: date
    );

    // insert it!
    await _moorDatabaseService.updateTransaction(newTransaction);

    Toast.show("Добавлено удачно!", duration: Toast.lengthShort, gravity: Toast.bottom);

    // return to the home
    Navigator.of(context)
        .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);

    Navigator.of(context).pushNamed('transactions');
  }

  void deleteTransaction(Transaction transaction) async {
    await _moorDatabaseService.deleteTransaction(transaction);
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
    unFocusFromTheTextField(context);

    date = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now()))!;

    notifyListeners();
  }

  getDescriptionTextField() {
    return customTextFormField.buildTextField(
        descriptionController,
        'Описание:',
        "Введите описание транзакции",
        Icons.edit,
        false
    );
  }

  getAmountTextField() {
    return customTextFormField.buildTextField(
        amountController,
        'Сумма:',
        "Введите сумму для транзакции",
        Icons.attach_money,
        true
    );
  }

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
