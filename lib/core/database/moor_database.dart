import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 20)();
}

@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 3, max: 20)();
  TextColumn get type => text()();
}

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
  RealColumn get amount => real()();
  IntColumn get category => integer().nullable().references(Categories, #id)();
  IntColumn get user => integer().nullable().references(Users, #id)();
  DateTimeColumn get date => dateTime()();
}

class TransactionWithCategoryAndUser {
  final Transaction transaction;
  final User? user;
  final Category? category;

  TransactionWithCategoryAndUser(this.transaction, this.user, this.category);
}

@UseMoor(
    tables: [Transactions, Categories, Users],
    daos: [TransactionDao, CategoryDao, UserDao]
)
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: true));

  int get schemaVersion => 1;
}

@UseDao(tables: [Transactions, Categories, Users],
    queries: {
  'getTotalSum': 'SELECT sum(transactions.amount) from transactions left join categories on transactions.category = categories.id where categories.type = :type;'

    })
class TransactionDao extends DatabaseAccessor<AppDatabase> with _$TransactionDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  TransactionDao(this.db) : super(db);

  Future<List<TransactionWithCategoryAndUser>> getAllTransactions() async {
    final rows = await select(transactions).join([
      leftOuterJoin(categories, categories.id.equalsExp(transactions.category)),
      leftOuterJoin(users, transactions.user.equalsExp(users.id))
    ]).get();

    return rows.map((resultRow) {
      return TransactionWithCategoryAndUser(resultRow.readTable(transactions),
          resultRow.readTableOrNull(users), resultRow.readTableOrNull(categories));
    }).toList();
  }

  Future insertTransaction(Insertable<Transaction> transaction) =>
      into(transactions).insert(transaction);

  Future updateTransaction(Insertable<Transaction> transaction) =>
      update(transactions).replace(transaction);

  Future deleteTransaction(Insertable<Transaction> transaction) =>
      delete(transactions).delete(transaction);

  // Income
  // getTotalIncome() async {
  //   final rows = await select(transactions).join([
  //     innerJoin(categories, categories.id.equalsExp(transactions.category)),
  //     innerJoin(users, transactions.user.equalsExp(users.id))
  //   ]).get();
  // }
}

@UseDao(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  UserDao(this.db) : super(db);

  // All tables have getters in the generated class - we can select the tasks table
  Future<List<User>> getAllUsers() => select(users).get();

  // Moor supports Streams which emit elements when the watched data changes
  Stream<List<User>> watchAllUsers() => select(users).watch();

  Future insertUser(Insertable<User> user) => into(users).insert(user);

  Future updateUser(Insertable<User> user) => update(users).replace(user);

  Future deleteUser(Insertable<User> user) => delete(users).delete(user);
}

@UseDao(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase> with _$CategoryDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  CategoryDao(this.db) : super(db);

  // Categories
  Future getAllCategoriesByType(String transactionType) =>
      (select(categories)..where((c) => c.type.equals(transactionType))).get();

  Future deleteCategory(Insertable<Category> category) =>
      delete(categories).delete(category);

  Future insertCategory(Insertable<Category> category) =>
      into(categories).insert(category);

  Future updateCategory(Insertable<Category> category) =>
      update(categories).replace(category);
}
