import 'package:flutter/material.dart';
import 'package:moneylover/ui/shared/ui_helpers.dart';
import 'package:moneylover/ui/views/category/categories_view.dart';

import '../users/users_view.dart';

class InsertTransactionView extends StatefulWidget {
  const InsertTransactionView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InsertTransactionViewState();
}

class _InsertTransactionViewState extends State<InsertTransactionView> {
  var model = InsertTransactionModel(
    InsertTransactionModel.months[DateTime.now().month - 1],
    DateTime.now().day.toString()
    // (selectedCategory == 1) ? 'income' : 'expense',
    // category.index
  );

  String transactionType = 'Приход';
  String categoryText = 'Не выбрана';
  String userText = 'Не выбран';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить транзакцию'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              buildTextField(model.memoController, 'Описание:',
                  "Введите описание транзакции", Icons.edit, false),
              UIHelper.verticalSpaceMedium(),
              buildTextField(model.amountController, 'Сумма:',
                  "Введите сумму для транзакции", Icons.attach_money, true),

              UIHelper.verticalSpaceMedium(),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.category),
                  UIHelper.horizontalSpaceMedium(),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _awaitReturnValueFromCategoryView(context);
                    },
                    child: Text(categoryText),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UIHelper.horizontalSpace(50),
                  RichText(
                    text: TextSpan(
                      text: "Категория",
                      style: TextStyle(
                          fontSize: 12, color: Colors.black.withOpacity(0.6)),
                    ),
                  )
                  // Text('Категория'),
                ],
              ),
              UIHelper.verticalSpaceMedium(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.people_rounded),
                  UIHelper.horizontalSpaceMedium(),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _awaitReturnValueFromUsersView(context);
                    },
                    child: Text(userText),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UIHelper.horizontalSpace(50),
                  RichText(
                    text: TextSpan(
                      text: "Пользователь",
                      style: TextStyle(
                          fontSize: 12, color: Colors.black.withOpacity(0.6)),
                    ),
                  )
                  // Text('Категория'),
                ],
              ),
              UIHelper.verticalSpaceMedium(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Выберите дату:',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Container(
                width: 20,
                height: 50,
                child: ElevatedButton(
                  child: Text(model.getSelectedDate()),
                  onPressed: () async {
                    await model.selectDate(context);
                  },
                ),
              ),
              UIHelper.verticalSpaceLarge(),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  child: Text(
                    'Добавить',
                    style: TextStyle(fontSize: 16),
                  ),
                  // color: backgroundColor,
                  // textColor: Colors.black,
                  onPressed: () async {
                    // await model.addTransaction(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _awaitReturnValueFromCategoryView(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoriesView(false),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      categoryText = result;
    });
  }

  void _awaitReturnValueFromUsersView(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UsersView(false),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      userText = result;
    });
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
          child: Icon(
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

class InsertTransactionModel {
  TextEditingController memoController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String selectedDay = '';
  String selectedMonth = '';
  DateTime selectedDate = new DateTime.now();
  String type = 'Приход';
  int cateogryIndex = 0;

  InsertTransactionModel(this.selectedMonth, this.selectedDay);

  static List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  Future selectDate(context) async {
    // hide the keyboard
    unFocusFromTheTextField(context);

    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());

    if (picked != null) {
      selectedMonth = months[picked.month - 1];
      selectedDay = picked.day.toString();
      selectedDate = picked;

      // notifyListeners();
    }
  }

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  String getSelectedDate() {
    if (int.parse(selectedDay) == DateTime.now().day &&
        DateTime.now().month == months.indexOf(selectedMonth) + 1) {
      return 'Сегодня ' + selectedMonth + ',' + selectedDay;
    } else {
      return selectedMonth + ',' + selectedDay;
    }
  }

  String getType() {
    return type;
  }

  void setType(String newType) {
    this.type = newType;
  }
}