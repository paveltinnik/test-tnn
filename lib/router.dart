import 'package:flutter/material.dart';
import 'package:moneylover/ui/views/category/categories_view.dart';
import 'package:moneylover/ui/views/category/edit_category_view.dart';
import 'package:moneylover/ui/views/category/insert_category_view.dart';
import 'package:moneylover/ui/views/transactions/transactions_view.dart';
import 'package:moneylover/ui/views/home/home_view.dart';
import 'package:moneylover/ui/views/transactions/edit_transaction_view.dart';
import 'package:moneylover/ui/views/transactions/insert_transaction_view.dart';
import 'package:moneylover/ui/views/users/edit_user_view.dart';
import 'package:moneylover/ui/views/users/insert_user_view.dart';
import 'package:moneylover/ui/views/users/users_view.dart';

import 'core/database/moor_database.dart';


class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (context) => HomeView());

      case 'expense_book':
        return MaterialPageRoute(builder: (context) => ExpenseBook());
      case 'inserttransaction':
        return MaterialPageRoute(builder: (_) => InsertTransactionView());
      // case 'choosecategory':
      //   return MaterialPageRoute(builder: (_) => Categor`());

      case 'users':
        var isFromHomeView = settings.arguments as bool;
        return MaterialPageRoute(builder: (_) => UsersView(isFromHomeView));
      case 'newuser':
        return MaterialPageRoute(builder: (_) => InsertUserView());
      case 'edituser':
        var user = settings.arguments as User;
        return MaterialPageRoute(builder: (_) => EditUserView(user));

      case 'edittransaction':
        return MaterialPageRoute(builder: (_) => EditTransactionView());

      case 'categories':
        var isFromHomeView = settings.arguments as bool;
        return MaterialPageRoute(builder: (_) => CategoriesView(isFromHomeView));
      case 'newcategory':
        return MaterialPageRoute(builder: (_) => InsertCategoryView());
      case 'editcategory':
        var category = settings.arguments as Category;
        return MaterialPageRoute(builder: (_) => EditCategoryView(category));


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
