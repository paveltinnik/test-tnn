import 'package:flutter/material.dart';
import 'package:moneylover/ui/views/category/categories_view.dart';
import 'package:moneylover/ui/views/category/choose_category_view.dart';
import 'package:moneylover/ui/views/category/insert_category_view.dart';
import 'package:moneylover/ui/views/expense_book/expense_book_view.dart';
import 'package:moneylover/ui/views/home/home_view.dart';
import 'package:moneylover/ui/views/transactions/edit_transaction_view.dart';
import 'package:moneylover/ui/views/transactions/insert_transaction_view.dart';
import 'package:moneylover/ui/views/users/edit_user_view.dart';
import 'package:moneylover/ui/views/users/insert_user_view.dart';
import 'package:moneylover/ui/views/users/users_view.dart';



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
        return MaterialPageRoute(builder: (_) => ChooseCategoryView());
      case 'users':
        return MaterialPageRoute(builder: (_) => UsersView());
      case 'newuser':
        return MaterialPageRoute(builder: (_) => InsertUserView());
      case 'edituser':
        return MaterialPageRoute(builder: (_) => EditUserView());
      case 'edittransaction':
        return MaterialPageRoute(builder: (_) => EditTransactionView());
      case 'categories':
        return MaterialPageRoute(builder: (_) => CategoriesView());
      case 'newcategory':
        return MaterialPageRoute(builder: (_) => InsertCategoryView());
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
