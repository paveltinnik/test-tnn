import 'package:flutter/material.dart';
import 'package:moneylover/ui/shared/text_styles.dart';
import 'package:moneylover/ui/shared/ui_helpers.dart';

// Виджет доходы, расходы, баланс
class SummaryWidget extends StatelessWidget {
  final int income;
  final int expense;

  const SummaryWidget({required this.income, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text('Доходы', style: summaryTextStyle),
                  UIHelper.verticalSpaceSmall(),
                  Text(income.toString(), style: summaryNumberTextStyle)
                ],
              ),
              const Text(
                '|',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w200),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Расходы',
                    style: summaryTextStyle,
                  ),
                  UIHelper.verticalSpaceSmall(),
                  Text(expense.toString(), style: summaryNumberTextStyle)
                ],
              ),
              const Text(
                '|',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w200),
              ),
              Column(
                children: <Widget>[
                  const Text(
                    'Баланс',
                    style: summaryTextStyle,
                  ),
                  UIHelper.verticalSpaceSmall(),
                  Text((income - expense).toString(),
                      style: summaryNumberTextStyle)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
