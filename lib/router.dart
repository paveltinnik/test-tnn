import 'package:flutter/material.dart';
import 'package:moneylover/ui/views/category_view.dart';
import 'package:moneylover/ui/views/expense_book.dart';
import 'package:moneylover/ui/views/home_view.dart';
import 'package:moneylover/ui/views/insert_transaction_view.dart';
import 'package:moneylover/ui/views/insert_user_view.dart';
import 'package:moneylover/ui/views/users_view.dart';



class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (context) => HomeView());
      case 'expense_book':
        return MaterialPageRoute(builder: (context) => ExpenseBook());
      case 'inserttransaction':
        return MaterialPageRoute(builder: (_) => InsertTransactionView());
      case 'choosecategory':
        return MaterialPageRoute(builder: (_) => CategoryView());
      case 'users':
        return MaterialPageRoute(builder: (_) => UsersView());
      case 'newuser':
        return MaterialPageRoute(builder: (_) => InsertUserView());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}
