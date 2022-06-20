import 'dart:developer';

import '../database/moor_database.dart';

class MoorDatabaseService {
  final AppDatabase _database = AppDatabase();

  // getAllTransactions(String month) async {
  //   List<Transaction> allTrans = List<Transaction>();
  //
  //   TransactionDao transactionDao = _database.transactionDao;
  //
  //   allTrans = await transactionDao.getTransactionForMonth(month).get();
  //   return allTrans;
  // }

  // getIncomeSum(String month) async {
  //   List<int> list = await _database.transactionDao
  //       .sumTheMoneyForMonth(month, "income")
  //       .get();
  //
  //   int sumOfIncome = 0;
  //
  //   if (list == null && list.length == 0) {
  //     return 0;
  //   }
  //
  //   list.forEach((element) {
  //     if (element == null) {
  //       return;
  //     }
  //     sumOfIncome += element;
  //   });
  //
  //   return sumOfIncome;
  // }

  // getExpenseSum(String month) async {
  //   List<int> list = await _database.transactionDao
  //       .sumTheMoneyForMonth(month, "expense")
  //       .get();
  //
  //   int sumOfExpense = 0;
  //
  //   if (list == null && list.length == 0) {
  //     return 0;
  //   }
  //
  //   list.forEach((element) {
  //     if (element == null) {
  //       return;
  //     }
  //     sumOfExpense += element;
  //   });
  //
  //   return sumOfExpense;
  // }

  // Users
  Future getAllUsers() async {
    return await _database.userDao.getAllUsers();
  }

  Future insertUser(UsersCompanion user) async {
    return await _database.userDao.insertUser(user);
  }

  Future updateUser(User user) async {
    return await _database.userDao.updateUser(user);
  }

  Future deleteUser(User user) async {
    return await _database.userDao.deleteUser(user);
  }

  // Categories
  Future getAllCategoriesByType(String transactionType) async {
    return await _database.categoryDao.getAllCategoriesByType(transactionType);
  }

  Future insertCategory(CategoriesCompanion category) async {
    return await _database.categoryDao.insertCategory(category);
  }

  Future updateCategory(Category category) async {
    return await _database.categoryDao.updateCategory(category);
  }

  Future deleteCategory(Category category) async {
    return await _database.categoryDao.deleteCategory(category);
  }

  // Transactions
  Future insertTransaction(TransactionsCompanion transaction) async {
    return await _database.transactionDao.insertTransaction(transaction);
  }

  Future getAllTransactions() async {
    return await _database.transactionDao.getAllTransactions();
  }

  Future updateTransaction(Transaction transaction) async {
    return await _database.transactionDao.updateTransaction(transaction);
  }

  Future deleteTransaction(Transaction transaction) async {
    return await _database.transactionDao.deleteTransaction(transaction);
  }

  getTotalIncome() async {
    try {
      List<int> list = await _database.transactionDao
          .getTotalSum('Приход')
          .get();

      int sumOfIncome = 0;

      if (list == null && list.length == 0) {
        return 0;
      }

      for (var element in list) {
        if (element == null) {
          continue;
        }
        sumOfIncome += element;
      }

      return sumOfIncome;
    } catch(e, s) {
      print('Exception in getTotalExpense(): $e');
      print('Stack: $s');

      return 0;
    }
  }

  getTotalExpense() async {
    try {
      List<int> list = await _database.transactionDao
          .getTotalSum('Расход')
          .get();

      int sumOfExpense = 0;

      if (list == null && list.length == 0) {
        return 0;
      }

      for (var element in list) {
        if (element == null) {
          continue;
        }
        sumOfExpense += element;
      }

      return sumOfExpense;
    } catch (e, s) {
      print('Exception in getTotalExpense(): $e');
      print('Stack: $s');

      return 0;
    }
  }

  getCategoriesCount(type) async {
    Map<String, double> map = {};

    try {
      List list = await _database.statisticsDao.getCategoriesCount(type).get();

      for (var i in list) {
        if (i == null) {
          continue;
        }

        map[i.name] = (i.countcategoriesname).toDouble();
      }

      return map;
    } catch (e, s) {
      print('Exception in getCategoriesCount(type): $e');
      print('Stack: $s');
    }
  }
}
