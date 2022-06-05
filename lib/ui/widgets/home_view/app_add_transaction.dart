import 'package:flutter/material.dart';

import 'package:moneylover/ui/shared/app_colors.dart';

// Кнопка добавить транзакцию
class AppFAB extends StatelessWidget {
  final Function closeMonthPicker;

  const AppFAB(this.closeMonthPicker);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        closeMonthPicker();
        Navigator.of(context).pushNamed("newtransaction");
      },
      child: Icon(Icons.add, color: Colors.black38),
      backgroundColor: backgroundColor,
    );
  }
}
