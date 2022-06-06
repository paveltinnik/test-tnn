import 'package:flutter/material.dart';
import 'package:moneylover/ui/widgets/users_view/app_add_user.dart';
import 'package:moneylover/ui/widgets/users_view/empty_user_widget.dart';
import 'package:provider/provider.dart';

import '../../core/database/users_database.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UsersViewState();
}

class _UsersViewState extends State {
  late AppDatabase _database;



  @override
  Widget build(BuildContext context) {
    _database = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Пользователи'),
      ),
      body: _buildGoalsListView(context),
      floatingActionButton: Visibility(
        child: AppFabUser(),
      ),
    );
  }

  // buildList(List<User> users) {
  //   return users.length == 0
  //       ? EmptyUserWidget()
  //       : ;
  // }

  StreamBuilder<List<User>> _buildGoalsListView(BuildContext context) {
    return StreamBuilder(
      stream: _database.watchAllUsers(),
      builder: (context, AsyncSnapshot<List<User>> snapshot) {
        if (snapshot.hasData) {
          final users = snapshot.data;
          return ListView.builder(
            itemCount: users!.length,
            itemBuilder: (BuildContext context, int position) {
              return _buildGoalItemView(users[position]);
            },
          );
        } else {
          return Center(
            child: Text('Пользователи не найдены'),
          );
        }
      },
    );
  }

  Widget _buildGoalItemView(User goal) {
    return Text(goal.name);

    // return Slidable(
    //   actionPane: SlidableDrawerActionPane(),
    //   secondaryActions: <Widget>[
    //     IconSlideAction(
    //       caption: 'Edit',
    //       color: Colors.blue,
    //       icon: Icons.edit,
    //       onTap: () => Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => UpdateGoalSceen(
    //             goal: goal,
    //           ),
    //         ),
    //       ),
    //     ),
    //     IconSlideAction(
    //       caption: 'Delete',
    //       color: Colors.red,
    //       icon: Icons.delete,
    //       onTap: () => _database.deleteGoal(goal),
    //     ),
    //   ],
    //   child: Container(
    //     padding: EdgeInsets.all(16),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         Text(goal.name),
    //         Text("Total Goal ${goal.amount.toString()}"),
    //       ],
    //     ),
    //   ),
    // );
  }

  // buildList(context) {
  //   return users.length == 0
  //       ? EmptyUserWidget()
  //       : UsersListView(users, model);
  // }

  // StreamBuilder<List<User>> _buildUserList(BuildContext context1) {
  //   final database = Provider.of<AppDatabase>(context1);
  //
  //   return StreamBuilder(
  //       stream: database.watchAllTasks(),
  //       builder: (context, AsyncSnapshot<List<User>> snapshot) {
  //         final users = snapshot.data ?? [];
  //
  //         return ListView.builder(
  //           itemCount: users.length,
  //           itemBuilder: (_, index) {
  //             final itemTask = users[index];
  //             return _buildListItem(itemTask, database);
  //           },
  //         );
  //       });
  // }
  //
  // Widget _buildListItem(User itemUser, AppDatabase database)
  //   {
  //     return TextButton(
  //         onPressed: null,
  //         child: TextButton(
  //           style: TextButton.styleFrom(
  //             textStyle: const TextStyle(fontSize: 20),
  //           ),
  //           onPressed: () {
  //             // Navigator.of(context).pushNamed('users');
  //                 () => database.deleteTask(itemUser);
  //           },
  //           child: Text(itemUser.name),
  //         )
  //     );
  //
  //   }
  }