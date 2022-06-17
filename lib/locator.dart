import 'package:get_it/get_it.dart';
import 'package:moneylover/core/viewmodels/category/category_model.dart';
import 'package:moneylover/core/viewmodels/category/edit_category_model.dart';
import 'package:moneylover/core/viewmodels/transaction/transaction_model.dart';
import 'package:moneylover/core/viewmodels/user/edit_user_model.dart';
import 'package:moneylover/core/viewmodels/user/insert_user_model.dart';
import 'package:moneylover/core/viewmodels/user/user_model.dart';
import 'core/services/moordatabase_service.dart';
import 'core/viewmodels/category/insert_category_model.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  //!SERVICES
  // locator.registerLazySingleton(() => CategoryIconService());
  locator.registerLazySingleton(() => MoorDatabaseService());
  // locator.registerLazySingleton(() => NotificationService());
  // locator.registerLazySingleton(() => SharedPrefrencesService());
  //!VIEWMODELS
  locator.registerFactory(() => UserModel());
  locator.registerFactory(() => InsertUserModel());
  locator.registerFactory(() => EditUserModel());

  locator.registerFactory(() => CategoryModel());
  locator.registerFactory(() => InsertCategoryModel());
  locator.registerFactory(() => EditCategoryModel());

  locator.registerFactory(() => TransactionModel());


  // locator.registerSingleton<UserModel>(UserModel());
  // locator.registerFactory(() => DetailsModel());
  // locator.registerFactory(() => EditModel());
  // locator.registerFactory(() => NewTransactionModel());
  // locator.registerFactory(() => PieChartModel());
  // locator.registerFactory(() => ReminderModel());
}
