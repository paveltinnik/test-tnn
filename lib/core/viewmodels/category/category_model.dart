import 'package:flutter/material.dart';
import 'package:moneylover/locator.dart';
import '../../database/moor_database.dart';
import '../../enums/viewstate.dart';
import '../../services/moordatabase_service.dart';
import '../base_model.dart';

class CategoryModel extends BaseModel {
  final MoorDatabaseService _moorDatabaseService = locator<MoorDatabaseService>();
  ScrollController scrollController = ScrollController();

  List<Category> categories = <Category>[];

  init(transactionType) async {
    categories = await _moorDatabaseService.getAllCategoriesByType(transactionType);

    // show the list
    setState(ViewState.Idle);
    notifyListeners();
  }

  void deleteCategory(Category category) async {
    await _moorDatabaseService.deleteCategory(category);
  }
}
