import 'package:flutter/material.dart';

// Кнопка добавить транзакцию
class AppFabUser extends StatelessWidget {
  const AppFabUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed("newuser");
      },
      child: Icon(Icons.add, color: Colors.black38),
    );
  }
}
