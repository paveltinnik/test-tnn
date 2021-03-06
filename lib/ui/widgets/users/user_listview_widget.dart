import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../core/database/moor_database.dart';
import '../../../core/viewmodels/user/user_model.dart';

class UsersListView extends StatefulWidget {
  final List<User> users;
  final UserModel model;

  const UsersListView(
    this.users,
    this.model,
  );

  @override
  _UsersListViewState createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        // controller: widget.model.scrollController,
        padding: const EdgeInsets.all(8),
        children: widget.users.map((user) {
          return Card(
            child: Slidable(
              // Specify a key if the Slidable is dismissible.
              key: UniqueKey(),

              // The start action pane is the one at the left or the top side.
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),

                // A pane can dismiss the Slidable.
                dismissible: DismissiblePane(onDismissed: () {
                  widget.model.deleteUser(user);
                  widget.users.remove(user);
                }),

                // All actions are defined in the children parameter.
                children: [
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed: (context) {
                      widget.model.deleteUser(user);
                      widget.users.remove(user);
                    },
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Удалить',
                  ),
                ],
              ),

              // The end action pane is the one at the right or the bottom side.
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      Navigator.of(context).pushNamed('edituser', arguments: user);
                    },
                    backgroundColor: Color(0xFF0392CF),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Редактировать',
                  ),
                ],
              ),

              // The child of the Slidable is what the user sees when the
              // component is not dragged.
              // child: ListTile(title: Text(user.name)),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue.withOpacity(.1),
                        child: const Icon(Icons.man),
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