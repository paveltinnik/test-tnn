import 'package:flutter/material.dart';
import 'package:moneylover/core/viewmodels/user/user_model.dart';
import 'package:moneylover/ui/widgets/users/app_add_user.dart';
import 'package:moneylover/ui/widgets/users/user_listview_widget.dart';

import '../base_view.dart';

class UsersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<UserModel>(
        onModelReady: (model) async => await model.init(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: const Text('Пользователи'),
              ),
              body: Column(
                children: [
                  UsersListView(model.users, model),
                ],
              ),
              floatingActionButton: const Visibility(
                child: AppFabUser(),
              ),
            )
    );
  }
}
