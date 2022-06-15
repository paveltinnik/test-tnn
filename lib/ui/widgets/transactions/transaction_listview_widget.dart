import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/database/moor_database.dart';
import '../../../core/viewmodels/transaction/transaction_model.dart';

class TransactionsListView extends StatefulWidget {
  late List<Transaction> transactions;
  late TransactionModel model;

  TransactionsListView(
      this.transactions,
      this.model,
      {Key? key}) : super(key: key);

  @override
  _TransactionsListViewState createState() => _TransactionsListViewState();
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
                  key: UniqueKey(),

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
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.of(context).pushNamed('edittransaction');
                        },
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
                                transaction.category.type + ": " +
                                    transaction.amount.toString(),
                                style: const TextStyle(fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.blue.withOpacity(.1),
                              child: const Icon(Icons.description),
                            ),
                            title: Text(transaction.description),
                            trailing: transaction.category.type.toLowerCase() == 'расход'
                                ? Text('- ' + transaction.amount.toString(),
                                style: TextStyle(fontSize: 20))
                                : Text(transaction.amount.toString(),
                                style: TextStyle(fontSize: 20)),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.blue.withOpacity(.1),
                              child: Icon(Icons.man),
                            ),
                            title: Text(transaction.user.toString()),
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
