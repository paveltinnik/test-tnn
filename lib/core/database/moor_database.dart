import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Users extends Table {
  TextColumn get name => text()();

  IntColumn get id => integer().autoIncrement()();
}

@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get type => text()();
}

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get description => text()();

  RealColumn get amount => real()();

  IntColumn get category => integer().references(Categories, #id)();

  IntColumn get user => integer().references(Users, #id)();

  DateTimeColumn get date => dateTime()();
}

class TransactionWithCategoryAndUser {
  final Transaction transaction;
  final User user;
  final Category category;

  TransactionWithCategoryAndUser(this.transaction, this.user, this.category);
}

@UseMoor(tables: [Users, Categories, Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      // Specify the location of the database file
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          // Good for debugging - prints SQL in the console
          logStatements: true,
        )));

  // Bump this when changing tables and columns.
  // Migrations will be covered in the next part.
  @override
  int get schemaVersion => 1;

  // All tables have getters in the generated class - we can select the tasks table
  Future<List<User>> getAllUsers() => select(users).get();

  // Moor supports Streams which emit elements when the watched data changes
  Stream<List<User>> watchAllUsers() => select(users).watch();

  Future insertUser(UsersCompanion user) => into(users).insert(user);

  Future updateUser(User user) => update(users).replace(user);

  Future deleteUser(User user) => delete(users).delete(user);

  // Categories
  Future getAllCategoriesByType(String transactionType) =>
      (select(categories)..where((c) => c.type.equals(transactionType))).get();

  Future deleteCategory(Category category) =>
      delete(categories).delete(category);

  Future insertCategory(CategoriesCompanion category) =>
      into(categories).insert(category);

  Future updateCategory(Category category) =>
      update(categories).replace(category);

  // Transactions
  Future<List<TransactionWithCategoryAndUser>> getAllTransactions() async {
    final rows = await select(transactions).join([
      innerJoin(categories, categories.id.equalsExp(transactions.category)),
      innerJoin(users, transactions.user.equalsExp(users.id))
    ]).get();

    return rows.map((resultRow) {
      return TransactionWithCategoryAndUser(
          resultRow.readTable(transactions),
          resultRow.readTable(users),
          resultRow.readTable(categories)
      );
    }).toList();
  }

  Future insertTransaction(TransactionsCompanion transaction) =>
      into(transactions).insert(transaction);

  Future updateTransaction(Transaction transaction) =>
      update(transactions).replace(transaction);

  Future deleteTransaction(Transaction transaction) =>
      delete(transactions).delete(transaction);
}
