import 'package:flutter/material.dart';
import 'package:moneylover/locator.dart';
import '../../database/moor_database.dart';
import '../../enums/viewstate.dart';
import '../../services/moordatabase_service.dart';
import '../base_model.dart';

class TransactionModel extends BaseModel {
  final MoorDatabaseService _moorDatabaseService = locator<MoorDatabaseService>();
  ScrollController scrollController = ScrollController();

  List<Transaction> transactions = <Transaction>[];

  init(transactionType) async {
    transactions = await _moorDatabaseService.getAllTransactions();
    notifyListeners();
  }

  void deleteCategory(Category category) async {
    await _moorDatabaseService.deleteCategory(category);
  }
}
