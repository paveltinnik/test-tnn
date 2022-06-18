import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../core/database/moor_database.dart';
import '../../../core/viewmodels/transaction/transaction_model.dart';

class TransactionsListView extends StatefulWidget {
  late List<TransactionWithCategoryAndUser> listOfTransactionsData;
  late TransactionModel model;

  TransactionsListView(
      this.listOfTransactionsData,
      this.model,
      {Key? key}) : super(key: key);

  @override
  _TransactionsListViewState createState() => _TransactionsListViewState();
}

  final DateFormat formatter = DateFormat('dd.MM.yyyy');
  class _TransactionsListViewState extends State<TransactionsListView> {

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: ListView(
          controller: widget.model.scrollController,
          padding: const EdgeInsets.all(8),
          children: widget.listOfTransactionsData.map((data) {
            return Card(
                child: Slidable(
                  // Specify a key if the Slidable is dismissible.
                  key: UniqueKey(),

                  // The start action pane is the one at the left or the top side.
                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    dismissible: DismissiblePane(onDismissed: () {
                      widget.model.deleteTransaction(data.transaction);
                      widget.listOfTransactionsData.remove(data);
                    }),

                    // All actions are defined in the children parameter.
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: (context) {
                          widget.model.deleteTransaction(data.transaction);
                          widget.listOfTransactionsData.remove(data);
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Удалить',
                      ),
                    ],
                  ),

                  // The end action pane is the one at the right or the bottom side.
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.of(context).pushNamed('edittransaction', arguments: data);
                        },
                        backgroundColor: Color(0xFF0392CF),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Редактировать',
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
                              // TODO Изменить дату с помощью formatter
                              Text('${data.transaction.date.day.toString().padLeft(2,'0')}'
                                  '.${data.transaction.date.month.toString().padLeft(2,'0')}'
                                  '.${data.transaction.date.year.toString()}',
                                style: const TextStyle(fontWeight: FontWeight.w300),
                              ),
                              // Text(
                              //   "${data.category.type}: ${data.transaction.amount}",
                              //   style: const TextStyle(fontWeight: FontWeight.w300),
                              // )
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
                            title: Text(data.transaction.description),
                            trailing: data.category?.type.toLowerCase() == 'расход'
                                ? Text('- ${data.transaction.amount}',
                                style: const TextStyle(fontSize: 20))
                                : Text(data.transaction.amount.toString(),
                                style: const TextStyle(fontSize: 20)),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.blue.withOpacity(.1),
                              child:const Icon(Icons.category),
                            ),
                            title: Text(data.category?.name ?? 'Не выбрана'),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.blue.withOpacity(.1),
                              child: const Icon(Icons.man),
                            ),
                            title: Text(data.user?.name ?? 'Не выбран'),
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
