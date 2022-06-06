import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/viewmodels/expense_book/expense_book_model.dart';
import '../../../core/viewmodels/user/user_model.dart';
// import 'package:moneymanager/core/database/moor_database.dart';
// import 'package:moneymanager/core/viewmodels/user_model.dart';

class UsersListView extends StatefulWidget {
  final List<User> users = [User(), User()];
  final UserModel model = UserModel();

  // const TransactionsListView(
  //   this.transactions,
  //   this.model,
  // );

  @override
  _UsersListViewState createState() => _UsersListViewState();
}

class User {
  String name = 'name';
}

class _UsersListViewState extends State<UsersListView> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        // controller: widget.model.scrollController,
        padding: EdgeInsets.all(8),
        children: widget.users.map((user) {
          return Card(
            child: Slidable(
              // Specify a key if the Slidable is dismissible.
              key: const ValueKey(0),

              // The start action pane is the one at the left or the top side.
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),

                // A pane can dismiss the Slidable.
                dismissible: DismissiblePane(onDismissed: () {}),

                // All actions are defined in the children parameter.
                children: const [
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed: null,
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),

              // The end action pane is the one at the right or the bottom side.
              endActionPane: const ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: null,
                    backgroundColor: Color(0xFF0392CF),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                ],
              ),

              // The child of the Slidable is what the user sees when the
              // component is not dragged.
              // child: ListTile(title: Text(user.name)),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue.withOpacity(.1),
                        child: Icon(Icons.man),
                      ),
                      title: Text(user.name),
                    ),
                  ],
                )
              ),
            )
          );
      }).toList(),
    ));
  }
}