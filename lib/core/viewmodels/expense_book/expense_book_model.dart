import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:moneymanager/core/database/moor_database.dart';
// import 'package:moneymanager/core/services/moordatabase_service.dart';

// import '../../locator.dart';
import '../../enums/viewstate.dart';
import '../base_model.dart';

class ExpenseBookModel extends BaseModel {
  // final MoorDatabaseService _moorDatabaseService = locator<MoorDatabaseService>();

  ScrollController scrollController = new ScrollController(); // set controller on scrolling
  bool show = true;

  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  // List<Transaction> transactions = List<Transaction>();
  bool isCollapsed = false;
  String appBarTitle = ''; // selected month
  String selectedYear = '2022';
  int selectedMonthIndex = 2; // from month list above

  int expenseSum = 0;
  int incomeSum = 0;

  monthClicked(String clickedMonth) async {
    selectedMonthIndex = months.indexOf(clickedMonth);
    appBarTitle = clickedMonth;
    // transactions = await _moorDatabaseService.getAllTransactions(appBarTitle);
    // expenseSum = await _moorDatabaseService.getExpenseSum(appBarTitle);
    // incomeSum = await _moorDatabaseService.getIncomeSum(appBarTitle);
    titleClicked();
  }

  titleClicked() {
    isCollapsed = !isCollapsed;
    notifyListeners();
  }

  getColor(month) {
    int monthIndex = months.indexOf(month);
    // color the selected month with
    if (monthIndex == selectedMonthIndex) {
      return Colors.orange;
    } else {
      return Colors.black;
    }
  }

  void closeMonthPicker() {
    isCollapsed = false;
    notifyListeners();
  }

  init() async {
    handleScroll();

    selectedMonthIndex = DateTime.now().month - 1;
    appBarTitle = months[selectedMonthIndex];

    // expenseSum = await _moorDatabaseService.getExpenseSum(appBarTitle);
    // incomeSum = await _moorDatabaseService.getIncomeSum(appBarTitle);

    print("Expense : $expenseSum");
    print("Income : $incomeSum");
    // show the loading bar
    setState(ViewState.Busy);
    notifyListeners();

    // transactions = await _moorDatabaseService.getAllTransactions(appBarTitle);
    // show the list
    setState(ViewState.Idle);
    notifyListeners();
  }

  void handleScroll() async {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideFloationButton();
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showFloationButton();
      }
    });
  }

  void showFloationButton() {
    show = true;
    notifyListeners();
  }

  void hideFloationButton() {
    show = false;
    notifyListeners();
  }
}
