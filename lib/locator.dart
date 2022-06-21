import 'package:get_it/get_it.dart';
import 'package:moneylover/core/viewmodels/category/category_model.dart';
import 'package:moneylover/core/viewmodels/transaction/transaction_model.dart';
import 'package:moneylover/core/viewmodels/user/user_model.dart';
import 'core/services/moordatabase_service.dart';
import 'core/viewmodels/statistics/statistics_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //!SERVICES
  locator.registerLazySingleton(() => MoorDatabaseService());
  //!VIEWMODELS
  locator.registerFactory(() => UserModel());

  locator.registerFactory(() => CategoryModel());

  locator.registerFactory(() => TransactionModel());

  locator.registerFactory(() => StatisticsModel());
}
