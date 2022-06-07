import 'package:flutter/material.dart';
import 'package:moneylover/ui/shared/ui_helpers.dart';
import 'package:moneylover/ui/views/category/categories_view.dart';
import 'package:provider/provider.dart';

import '../../../core/database/users_database.dart';
import '../../../core/viewmodels/insert_transaction_model.dart';

class InsertCategoryView extends StatefulWidget {
  const InsertCategoryView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InsertCategoryViewState();
}

class _InsertCategoryViewState extends State<InsertCategoryView> {
  var model = InsertCategoryModel();
  String transactionType = 'Приход';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить категорию'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              buildTextField(model.nameController, 'Категория:',
                  "Введите название категории", Icons.edit, false),
              UIHelper.verticalSpaceMedium(),
              Padding(
                padding: EdgeInsets.fromLTRB(1, 1, 8, 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.request_quote_outlined),
                    UIHelper.horizontalSpace(25),
                    DropdownButton(
                      value: transactionType,
                      items: const [
                        DropdownMenuItem(value: 'Приход', child: Text('Приход')),
                        DropdownMenuItem(value: 'Расход', child: Text('Расход')),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          transactionType = newValue!;
                          // model.setType(newValue!);
                        });
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                    child: Text(
                      'Добавить',
                      style: TextStyle(fontSize: 16),
                    ),
                    // color: backgroundColor,
                    // textColor: Colors.black,
                    onPressed: () {
                      setState(() {
                        UsersCompanion.insert(name: model.nameController.text);

                        // AppDatabase().insertUser(User(
                        //   name: model.nameController.text,
                        // ));
                        model.nameController.clear();
                        Navigator.pop(context);
                      });
                    }
                  // await model.addTransaction(context);
                ),
              )
            ],
          ),
        ),
      ),
    );
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

class InsertCategoryModel {
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
