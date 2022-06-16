import 'package:flutter/material.dart';
import 'package:moneylover/core/viewmodels/category/insert_category_model.dart';
import 'package:moneylover/ui/shared/ui_helpers.dart';
import 'package:moneylover/ui/views/category/categories_view.dart';
import 'package:provider/provider.dart';

import '../../../core/database/moor_database.dart';
import '../../../core/viewmodels/category/edit_category_model.dart';
import '../base_view.dart';

class EditCategoryView extends StatelessWidget {
  late Category category;
  late String transactionType;

  EditCategoryView(this.category, {Key? key}) : super(key: key) {
    transactionType = category.type;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<EditCategoryModel>(
        onModelReady: (model) async => await model.init(category),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Редактировать категорию'),
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
                          'Сохранить',
                          style: TextStyle(fontSize: 16),
                        ),
                        // color: backgroundColor,
                        // textColor: Colors.black,
                        onPressed: () {
                          model.updateCategory(context, transactionType);
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
        labelStyle: TextStyle(
          color: Color(0xFFFF000000),
        ),
        helperText: helperText,
      ),
    );
  }
}