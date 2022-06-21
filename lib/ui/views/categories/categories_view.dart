import 'package:flutter/material.dart';
import 'package:moneylover/ui/widgets/category/category_listview_widget.dart';

import '../../../core/viewmodels/category/category_model.dart';
import '../../shared/ui_helpers.dart';
import '../../widgets/category/app_add_category.dart';
import '../../widgets/category/choose_category_listview_widget.dart';
import '../base_view.dart';

class CategoriesView extends StatefulWidget {
  late bool isFromHomeView;

  CategoriesView(this.isFromHomeView, {Key? key}) : super(key: key);

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  String transactionType = 'Приход';

  @override
  Widget build(BuildContext context) {
    return BaseView<CategoryModel>(
        onModelReady: (model) async => await model.init(
            transactionType: transactionType, isInsertView: false),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: const Text('Категории'),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 8, 8, 8),
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
                            setState(() {
                              transactionType = newValue!;
                              model.init(
                                  transactionType: transactionType,
                                  isInsertView: false);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  buildListView(model),
                ],
              ),
              floatingActionButton: const Visibility(
                child: AppFabCategory(),
              ),
            ));
  }

  Widget buildListView(model) {
    if (widget.isFromHomeView) {
      return CategoriesListView(model.categories, model);
    } else {
      return ChooseCategoriesListView(model.categories, model);
    }
  }
}
