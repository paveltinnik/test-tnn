import 'package:flutter/material.dart';
import 'package:moneylover/router.dart';
// import 'package:moneylover/ui/widgets/app_bar.dart';
import 'package:moneylover/ui/widgets/home_view/option_view.dart';

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
          children: <Widget>[
            Center(
              child: SizedBox.fromSize(
                size: Size(150, 80),
                  child: Material(
                    color: Colors.black12,
                    child: InkWell(
                      splashColor: Colors.grey,
                      onTap: () {
                        Navigator.of(context).pushNamed('inserttransaction');

                        // simpleDialogWithOption(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.shopping_cart), // <-- Icon
                          Text("Добавить операцию"), // <-- Text
                        ],
                      ),
                    ),
                  ),
                // ),
              ),
            ),
            Center(
              child: SizedBox.fromSize(
                size: Size(150, 80),
                child: Material(
                  color: Colors.black12,
                  child: InkWell(
                    splashColor: Colors.grey,
                    onTap: () {
                      Navigator.of(context).pushNamed('expense_book');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.wallet), // <-- Icon
                        Text("Книга учета"), // <-- Text
                      ],
                    ),
                  ),
                ),
                // ),
              ),
            ),
            Center(
              child: SizedBox.fromSize(
                size: Size(150, 80),
                child: Material(
                  color: Colors.black12,
                  child: InkWell(
                    splashColor: Colors.grey,
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.bar_chart), // <-- Icon
                        Text("Статистика"), // <-- Text
                      ],
                    ),
                  ),
                ),
                // ),
              ),
            ),
            Center(
              child: SizedBox.fromSize(
                size: Size(150, 80),
                child: Material(
                  color: Colors.black12,
                  child: InkWell(
                    splashColor: Colors.grey,
                    onTap: () {
                      Navigator.of(context).pushNamed('users');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.people_rounded), // <-- Icon
                        Text("Пользователи"), // <-- Text
                      ],
                    ),
                  ),
                ),
                // ),
              ),
            ),
            Center(
              child: SizedBox.fromSize(
                size: Size(150, 80),
                child: Material(
                  color: Colors.black12,
                  child: InkWell(
                    splashColor: Colors.grey,
                    onTap: () {
                      Navigator.of(context).pushNamed('categories');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.category), // <-- Icon
                        Text("Категории"), // <-- Text
                      ],
                    ),
                  ),
                ),
                // ),
              ),
            ),
          ]
        ),
      )
    );
  }

  simpleDialogWithOption(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Добавить операцию'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pushNamed('expense_book');
                },
                child: Text('Приход'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pushNamed('expense_book');
                },
                child: Text('Расход'),
              ),
            ],
          );
        });
  }
}