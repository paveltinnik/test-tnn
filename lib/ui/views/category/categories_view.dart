import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moneylover/ui/widgets/category/category_listview_widget.dart';
import 'package:moneylover/ui/widgets/users/app_add_user.dart';
import 'package:moneylover/ui/widgets/users/empty_user_widget.dart';
import 'package:moneylover/ui/widgets/users/user_listview_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/database/users_database.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State {
  late AppDatabase _database;

  @override
  Widget build(BuildContext context) {
    _database = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Категории'),
      ),
      body: Column(
        children: [
          CategoriesListView(),
        ],
      ),
      // body: _buildGoalItemView(User(name: 'name', id: 1)),
      floatingActionButton: Visibility(
        child: AppFabUser(),
      ),
    );
  }

// StreamBuilder<List<User>> _buildGoalsListView(BuildContext context) {
//   return StreamBuilder(
//     stream: _database.watchAllUsers(),
//     builder: (context, AsyncSnapshot<List<User>> snapshot) {
//       if (snapshot.hasData) {
//         final users = snapshot.data;
//         return ListView.builder(
//           itemCount: users!.length,
//           itemBuilder: (BuildContext context, int position) {
//             return _buildGoalItemView(users[position]);
//           },
//         );
//       } else {
//         return Center(
//           child: Text('Пользователи не найдены'),
//         );
//       }
//     },
//   );
// }

// Widget _buildGoalItemView(User user) {
//   return Slidable(
//     // Specify a key if the Slidable is dismissible.
//     key: const ValueKey(0),
//
//     // The start action pane is the one at the left or the top side.
//     startActionPane: ActionPane(
//       // A motion is a widget used to control how the pane animates.
//       motion: const ScrollMotion(),
//
//       // A pane can dismiss the Slidable.
//       dismissible: DismissiblePane(onDismissed: () {}),
//
//       // All actions are defined in the children parameter.
//       children: const [
//         // A SlidableAction can have an icon and/or a label.
//         SlidableAction(
//           onPressed: null,
//           backgroundColor: Color(0xFFFE4A49),
//           foregroundColor: Colors.white,
//           icon: Icons.delete,
//           label: 'Delete',
//         ),
//       ],
//     ),
//
//     // The end action pane is the one at the right or the bottom side.
//     endActionPane: const ActionPane(
//       motion: ScrollMotion(),
//       children: [
//         SlidableAction(
//           onPressed: null,
//           backgroundColor: Color(0xFF0392CF),
//           foregroundColor: Colors.white,
//           icon: Icons.edit,
//           label: 'Edit',
//         ),
//       ],
//     ),
//
//     // The child of the Slidable is what the user sees when the
//     // component is not dragged.
//     // child: ListTile(title: Text(user.name)),
//     child: ListTile(title: Text(user.name)),

// endActionPane: SlidableDrawerActionPane(),
// secondaryActions: <Widget>[
//   IconSlideAction(
//     caption: 'Edit',
//     color: Colors.blue,
//     icon: Icons.edit,
//     onTap: () => Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => UpdateGoalSceen(
//           goal: goal,
//         ),
//       ),
//     ),
//   ),
//   IconSlideAction(
//     caption: 'Delete',
//     color: Colors.red,
//     icon: Icons.delete,
//     onTap: () => _database.deleteGoal(goal),
//   ),
// ],
// child: Container(
//   padding: EdgeInsets.all(16),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Text(goal.name),
//       Text("Total Goal ${goal.amount.toString()}"),
//     ],
//   ),
// ),
//   );
// }

// buildList(context) {
//   return users.length == 0
//       ? EmptyUserWidget()
//       : UsersListView(users, model);
// }

}