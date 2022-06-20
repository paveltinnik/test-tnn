import 'package:flutter/material.dart';
import 'package:moneylover/core/viewmodels/category/insert_category_model.dart';
import 'package:moneylover/ui/shared/ui_helpers.dart';
import 'package:moneylover/ui/views/categories/categories_view.dart';
import 'package:provider/provider.dart';

import '../../../core/database/moor_database.dart';
import '../base_view.dart';

class InsertCategoryView extends StatelessWidget {
  InsertCategoryView({Key? key}) : super(key: key);

  String transactionType = 'Приход';

  @override
  Widget build(BuildContext context) {
    return BaseView<InsertCategoryModel>(
        onModelReady: (model) async => await model.init(),
        builder: (context, model, child) => Scaffold(
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
                        padding: const EdgeInsets.fromLTRB(1, 1, 8, 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.request_quote_outlined),
                            UIHelper.horizontalSpace(25),
                            DropdownButton(
                              value: transactionType,
                              items: const [
                                DropdownMenuItem(
                                    value: 'Приход', child: Text('Приход')),
                                DropdownMenuItem(
                                    value: 'Расход', child: Text('Расход')),
                              ],
                              onChanged: (String? newValue) {
                                transactionType = newValue!;
                                model.notifyListeners();
                              },
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                            child: const Text(
                              'Добавить',
                              style: TextStyle(fontSize: 16),
                            ),
                            // color: backgroundColor,
                            // textColor: Colors.black,
                            onPressed: () {
                              model.addCategory(context, transactionType);
                            }
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
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