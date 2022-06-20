import 'package:flutter/material.dart';
import 'package:moneylover/ui/views/categories/categories_view.dart';
import 'package:moneylover/ui/views/categories/edit_category_view.dart';
import 'package:moneylover/ui/views/categories/insert_category_view.dart';
import 'package:moneylover/ui/views/statistics/statistics_view.dart';
import 'package:moneylover/ui/views/transactions/transactions_view.dart';
import 'package:moneylover/ui/views/home/home_view.dart';
import 'package:moneylover/ui/views/transactions/edit_transaction_view.dart';
import 'package:moneylover/ui/views/transactions/insert_transaction_view.dart';
import 'package:moneylover/ui/views/users/edit_user_view.dart';
import 'package:moneylover/ui/views/users/insert_user_view.dart';
import 'package:moneylover/ui/views/users/users_view.dart';

import 'core/database/moor_database.dart';
import 'core/viewmodels/statistics/pie_chart_view.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (context) => HomeView());

      case 'transactions':
        return MaterialPageRoute(builder: (context) => TransactionsView());
      case 'inserttransaction':
        return MaterialPageRoute(builder: (_) => InsertTransactionView());
      case 'edittransaction':
        var data = settings.arguments as TransactionWithCategoryAndUser;
        return MaterialPageRoute(builder: (_) => EditTransactionView(data));

      case 'users':
        var isFromHomeView = settings.arguments as bool;
        return MaterialPageRoute(builder: (_) => UsersView(isFromHomeView));
      case 'newuser':
        return MaterialPageRoute(builder: (_) => InsertUserView());
      case 'edituser':
        var user = settings.arguments as User;
        return MaterialPageRoute(builder: (_) => EditUserView(user));

      case 'categories':
        var isFromHomeView = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (_) => CategoriesView(isFromHomeView));
      case 'newcategory':
        return MaterialPageRoute(builder: (_) => InsertCategoryView());
      case 'editcategory':
        var category = settings.arguments as Category;
        return MaterialPageRoute(builder: (_) => EditCategoryView(category));

      case 'statistics':
        return MaterialPageRoute(builder: (_) => StatisticsView());
      case 'piechart':
        return MaterialPageRoute(builder: (_) => PieChartView());

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
