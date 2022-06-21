import 'package:flutter/material.dart';
import 'package:moneylover/ui/shared/ui_helpers.dart';

import '../../../core/viewmodels/category/category_model.dart';
import '../base_view.dart';

class InsertCategoryView extends StatelessWidget {
  InsertCategoryView({Key? key}) : super(key: key);

  String transactionType = 'Приход';

  @override
  Widget build(BuildContext context) {
    return BaseView<CategoryModel>(
        onModelReady: (model) async => await model.init(isInsertView: true),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: const Text('Добавить категорию'),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: <Widget>[
                      model.buildTextField(model.nameController, 'Категория:',
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
}