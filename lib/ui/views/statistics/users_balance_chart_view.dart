import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:moneylover/core/viewmodels/statistics/statistics_model.dart';

import '../base_view.dart';

class UsersBalanceChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<StatisticsModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Доходы пользователей'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    padding: const EdgeInsets.all(25),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Доходы пользователей",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Expanded(
                              child: charts.BarChart(
                                  model.series,
                                  animate: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class DeveloperSeries {
//   final String year;
//   final int developers;
//   final charts.Color barColor;
//
//   DeveloperSeries(
//       {
//         required this.year,
//         required this.developers,
//         required this.barColor
//       }
//       );
// }
