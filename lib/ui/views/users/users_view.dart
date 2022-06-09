import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moneylover/ui/widgets/users/app_add_user.dart';
import 'package:moneylover/ui/widgets/users/empty_user_widget.dart';
import 'package:moneylover/ui/widgets/users/user_listview_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/database/moor_database.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UsersViewState();
}

class _UsersViewState extends State {

  @override
  Widget build(BuildContext context) {
    AppDatabase _database = Provider.of<AppDatabase>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Пользователи'),
      ),
      body: Column(
        children: [
          // UsersListView(),
        ],
      ),
      floatingActionButton: const Visibility(
        child: AppFabUser(),
      ),
    );
  }
}