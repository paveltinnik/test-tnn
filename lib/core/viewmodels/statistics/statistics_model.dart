import 'package:moneylover/core/viewmodels/base_model.dart';

import '../../../locator.dart';
import '../../services/moordatabase_service.dart';

class StatisticsModel extends BaseModel {
  final MoorDatabaseService _moorDatabaseService = locator<MoorDatabaseService>();

  Map<String, double> dataMap = {};

  String type = 'Приход';

  List<String> types = ["Приход", "Расход"];

  init() async {
    dataMap = await _moorDatabaseService.getCategoriesCount(type);

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