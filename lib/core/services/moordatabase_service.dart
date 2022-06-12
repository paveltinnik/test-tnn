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

  Future getAllUsers() async {
    return await _database.getAllUsers();
  }

  Future deleteUser(User user) async {
    return await _database.deleteUser(user);
  }

  Future insertUser(UsersCompanion user) async {
    return await _database.insertUser(user);
  }

  Future updateUser(User user) async {
    return await _database.updateUser(user);
  }

  Future getAllCategoriesByType(String transactionType) async {
    return await _database.getAllCategoriesByType(transactionType);
  }

  Future deleteCategory(Category category) async {
    return await _database.deleteCategory(category);
  }

  Future insertCategory(CategoriesCompanion category) async {
    return await _database.insertCategory(category);
  }

  // getAllTransactionsForType(String month, String type) async {
  //   return await _database.transactionDao
  //       .getAllTransactionsForType(month, type)
  //       .get();
  // }

}
