import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Семейный бюджет'),
        ),
        // drawer: AppDrawer(context),
        body: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          childAspectRatio: 2,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('inserttransaction');
                  // simpleDialogWithOption(context);
                },
                icon: Icon(Icons.shopping_cart),
                label: Text('Добавить операцию'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('transactions');
                  // simpleDialogWithOption(context);
                },
                icon: Icon(Icons.wallet),
                label: Text('Книга учета'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('expense_book');
                  // simpleDialogWithOption(context);
                },
                icon: Icon(Icons.bar_chart),
                label: Text('Статистика'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('users', arguments: true);
                  // simpleDialogWithOption(context);
                },
                icon: const Icon(Icons.people_rounded),
                label: const Text('Пользователи'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('categories', arguments: true);
                  // simpleDialogWithOption(context);
                },
                icon: Icon(Icons.category),
                label: Text('Категории'),
              ),
            ),
          ]
        ),
      )
    );
  }
}