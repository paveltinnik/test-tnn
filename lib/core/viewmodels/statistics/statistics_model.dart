import 'package:moneylover/core/viewmodels/base_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../../locator.dart';
import '../../database/moor_database.dart';
import '../../services/moordatabase_service.dart';

class StatisticsModel extends BaseModel {
  final MoorDatabaseService _moorDatabaseService = locator<MoorDatabaseService>();

  Map<String, double> dataMap = {};
  late List<GetUsersBalanceByTypeResult> usersIncome = [];
  late List<charts.Series<GetUsersBalanceByTypeResult, String>> series = [];

  String type = 'Приход';

  List<String> types = ["Приход", "Расход"];

  init() async {
    dataMap = await _moorDatabaseService.getCategoriesCount(type);

    usersIncome = await _moorDatabaseService.getUsersIncome();

    series = [
      charts.Series(
        id: "usersBalance",
        data: usersIncome,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (GetUsersBalanceByTypeResult series, _) => series.name,
        measureFn: (GetUsersBalanceByTypeResult series, x) => (series.sumtransactionsamount),
      )
    ];

    notifyListeners();
  }

  changeType(int val) async {
    // 0 => income
    // 1 => expense
    if (val == 0) {
      type = 'Приход';
    } else {
      type = 'Расход';
    }

    await init();
  }
}