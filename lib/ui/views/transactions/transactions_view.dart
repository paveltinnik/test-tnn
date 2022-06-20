import 'package:flutter/material.dart';
import 'package:moneylover/ui/widgets/transactions/summary_widget.dart';
import 'package:moneylover/ui/widgets/transactions/transaction_listview_widget.dart';

import '../../../core/viewmodels/transaction/transaction_model.dart';
import '../base_view.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<TransactionModel>(
        onModelReady: (model) async => await model.init(null),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Книга учета'),
          ),
          body: Column(
            children: <Widget>[
              // Виджет с дооходами, расходами, балансом
              SummaryWidget(income: model.totalIncome, expense: model.totalExpense),
              // Виджет с листом из транзакций
              TransactionsListView(model.listOfTransactionsData, model),
            ],
          ),
        )
    );
  }
}