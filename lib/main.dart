import 'package:flutter/material.dart';
import 'package:moneylover/locator.dart';
import 'package:moneylover/router.dart';
import 'package:provider/provider.dart';

import 'core/database/users_database.dart';

void main() {
  // setupLocator();
  runApp(
      Provider<AppDatabase>(
        create: (context) => AppDatabase(),
        child: MyApp(),
        dispose: (context, db) => db.close(),
      )
  );
      // const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Family budget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'home',
      onGenerateRoute: MyRouter.generateRoute,
    );
  }
}

