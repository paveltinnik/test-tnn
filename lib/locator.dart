import 'package:get_it/get_it.dart';
import 'package:moneylover/core/viewmodels/category/category_model.dart';
import 'package:moneylover/core/viewmodels/user/edit_user_model.dart';
import 'package:moneylover/core/viewmodels/user/insert_user_model.dart';
import 'package:moneylover/core/viewmodels/user/user_model.dart';
import 'package:moneylover/ui/views/category/insert_category_view.dart';
// import 'package:moneymanager/core/services/notification_service.dart';
// import 'package:moneymanager/core/services/sharedprefs_service.dart';
// import 'package:moneymanager/core/viewmodels/details_model.dart';
// import 'package:moneymanager/core/viewmodels/edit_model.dart';
// import 'package:moneymanager/core/viewmodels/insert_transaction_model.dart';
// import 'package:moneymanager/core/viewmodels/new_transcation_model.dart';
// import 'package:moneymanager/core/viewmodels/piechart_model.dart';
// import 'package:moneymanager/core/viewmodels/reminder_model.dart';
//
// import 'core/services/category_icon_service.dart';
// import 'core/services/moordatabase_service.dart';
// import 'core/viewmodels/user_model.dart';
import 'core/services/moordatabase_service.dart';
import 'core/viewmodels/category/insert_category_model.dart';
import 'core/viewmodels/insert_transaction_model.dart';

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



  // locator.registerSingleton<UserModel>(UserModel());
  // locator.registerFactory(() => DetailsModel());
  // locator.registerFactory(() => EditModel());
  // locator.registerFactory(() => NewTransactionModel());
  locator.registerFactory(() => InsertTransactionModel());
  // locator.registerFactory(() => PieChartModel());
  // locator.registerFactory(() => ReminderModel());
}
