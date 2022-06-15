import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../core/database/moor_database.dart';
import '../../../core/viewmodels/user/user_model.dart';

class ChooseUsersListView extends StatefulWidget {
  final List<User> users;
  final UserModel model;

  const ChooseUsersListView(this.users, this.model, {Key? key})
      : super(key: key);

  @override
  _ChooseUsersListViewState createState() => _ChooseUsersListViewState();
}

class _ChooseUsersListViewState extends State<ChooseUsersListView> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: ListView(
          controller: widget.model.scrollController,
          padding: const EdgeInsets.all(8),
          children: widget.users.map((user) {
            return Card(
                child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.blue.withOpacity(.1),
                            child: Icon(Icons.man),
                          ),
                          title: Text(user.name),
                          onTap: () {
                            Navigator.pop(context, user);
                          },
                        ),
                      ],
                    )
                )
            );
          }).toList(),
        ));
  }
}
