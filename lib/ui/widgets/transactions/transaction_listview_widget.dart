import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/viewmodels/expense_book/expense_book_model.dart';
// import 'package:moneymanager/core/database/moor_database.dart';
// import 'package:moneymanager/core/viewmodels/user_model.dart';

class TransactionsListView extends StatefulWidget {
  final List<Transaction> transactions = [Transaction(), Transaction()];
  final ExpenseBookModel model = ExpenseBookModel();

  // const TransactionsListView(
  //   this.transactions,
  //   this.model,
  // );

  @override
  _TransactionsListViewState createState() => _TransactionsListViewState();
}

class Transaction {
  String type = 'type';
  String day = '01';
  String month = '02';
  String amount = '100';
  String memo  = 'memo';
}

class _TransactionsListViewState extends State<TransactionsListView> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        controller: widget.model.scrollController,
        padding: EdgeInsets.all(8),
        children: widget.transactions.map((transaction) {
          return Card(
            child: Slidable(
              // Specify a key if the Slidable is dismissible.
              key: const ValueKey(0),

              // The start action pane is the one at the left or the top side.
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),

                // A pane can dismiss the Slidable.
                dismissible: DismissiblePane(onDismissed: () {}),

                // All actions are defined in the children parameter.
                children: const [
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed: null,
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),

              // The end action pane is the one at the right or the bottom side.
              endActionPane: const ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: null,
                    backgroundColor: Color(0xFF0392CF),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                ],
              ),

              // The child of the Slidable is what the user sees when the
              // component is not dragged.
              // child: ListTile(title: Text(user.name)),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          transaction.day + ', ' + transaction.month,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        Text(
                          transaction.type + ": " + transaction.amount.toString(),
                          style: TextStyle(fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue.withOpacity(.1),
                        // child: widget.model.getIconForCategory(
                        //     transaction.categoryindex, transaction.type),
                      ),
                      title: Text(transaction.memo),
                      trailing: transaction.type == 'expense'
                          ? Text('- ' + transaction.amount.toString(),
                          style: TextStyle(fontSize: 20))
                          : Text(transaction.amount.toString(),
                          style: TextStyle(fontSize: 20)),
                    ),
                  ],
                )
              ),
            )
          );
      }).toList(),
    ));
  }
}
