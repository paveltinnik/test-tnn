import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moneylover/ui/widgets/category/category_listview_widget.dart';
import 'package:moneylover/ui/widgets/users/app_add_user.dart';
import 'package:moneylover/ui/widgets/users/empty_user_widget.dart';
import 'package:moneylover/ui/widgets/users/user_listview_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/database/users_database.dart';
import '../../shared/ui_helpers.dart';
import '../../widgets/category/app_add_category.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State {
  late AppDatabase _database;

  String transactionType = 'Приход';

  @override
  Widget build(BuildContext context) {
    _database = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(50, 8, 8, 8),
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
          CategoriesListView(transactionType),
        ],
      ),
      // body: _buildGoalItemView(User(name: 'name', id: 1)),
      floatingActionButton: Visibility(
        child: AppFabCategory(),
      ),
    );
  }
}
