import 'package:flutter/material.dart';

// Кнопка добавить категорию
class AppFabCategory extends StatelessWidget {
  const AppFabCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed("newcategory");
      },
      child: Icon(Icons.add, color: Colors.black38),
    );
  }
}
