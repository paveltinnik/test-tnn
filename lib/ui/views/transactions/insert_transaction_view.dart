import 'package:flutter/material.dart';
import 'package:moneylover/core/viewmodels/transaction/transaction_model.dart';
import 'package:moneylover/ui/shared/ui_helpers.dart';

import '../base_view.dart';

class InsertTransactionView extends StatefulWidget {
  const InsertTransactionView({Key? key}) : super(key: key);

  @override
  _InsertTransactionViewState createState() => _InsertTransactionViewState();
}

class _InsertTransactionViewState extends State<InsertTransactionView> {
  @override
  Widget build(BuildContext context) {

    return BaseView<TransactionModel>(
        onModelReady: (model) async => await model.init(null),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Добавить транзакцию'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  model.getDescriptionTextField(),
                  UIHelper.verticalSpaceMedium(),
                  model.getAmountTextField(),
                  UIHelper.verticalSpaceMedium(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.category),
                      UIHelper.horizontalSpaceMedium(),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () async {
                          await model.setCategoryName(context);
                        },
                        child: Text(model.categoryName),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UIHelper.horizontalSpace(50),
                      RichText(
                        text: TextSpan(
                          text: "Категория",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                      )
                    ],
                  ),
                  UIHelper.verticalSpaceMedium(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.people_rounded),
                      UIHelper.horizontalSpaceMedium(),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () async {
                          await model.setUserName(context);
                        },
                        child: Text(model.userName),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UIHelper.horizontalSpace(50),
                      RichText(
                        text: TextSpan(
                          text: "Пользователь",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                      )
                      // Text('Категория'),
                    ],
                  ),
                  UIHelper.verticalSpaceMedium(),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Выберите дату:',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 16),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Container(
                    width: 20,
                    height: 50,
                    child: ElevatedButton(
                      child: Text(model.getSelectedDate()),
                      onPressed: () async {
                        await model.selectDate(context);
                      },
                    ),
                  ),
                  UIHelper.verticalSpaceLarge(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      child: const Text(
                        'Добавить',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () async {
                        await model.addTransaction(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}