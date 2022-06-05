import 'package:flutter/material.dart';
import 'package:moneylover/ui/shared/ui_helpers.dart';

class EmptyTransactionsWidget extends StatelessWidget {
  const EmptyTransactionsWidget({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UIHelper.verticalSpaceLarge(),
        Image.asset(
          'assets/icons/no-money.png',
          width: 120,
          height: 120,
        ),
        UIHelper.verticalSpaceMedium(),
        Text(
          'Нет транзакций\nНажмите + чтобы добавить.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      ],
    );
  }
}
