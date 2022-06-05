import 'package:moor_flutter/moor_flutter.dart';

part 'users_database.g.dart';

class Users extends Table {
  TextColumn get name => text()();
  IntColumn get id => integer().autoIncrement()();
}

@UseMoor(tables: [Users])
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

  Future insertUser(User user) => into(users).insert(user);

  // Updates a User with a matching primary key
  Future updateUser(User user) => update(users).replace(user);

  Future deleteUser(User user) => delete(users).delete(user);
}