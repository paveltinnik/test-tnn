import 'package:flutter/material.dart';
import 'package:moneylover/ui/widgets/expense_book/summary_widget.dart';
import 'package:moneylover/ui/widgets/transactions/transaction_listview_widget.dart';

class ExpenseBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Книга учета'),
      ),
      body: Column(
        children: <Widget>[
          // Виджет с дооходами, расходами, балансом
          SummaryWidget(income: 0, expense: 0),
          // Виджет с листом из транзакций
          TransactionsListView(),
        ],
      ),
    );

  }
}