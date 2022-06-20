import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:moneylover/core/viewmodels/statistics/statistics_model.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../ui/views/base_view.dart';

class PieChartView extends StatelessWidget {
  const PieChartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<StatisticsModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Диаграмма по категориям'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Column(
                children: <Widget>[
                  ChipsChoice<int>.single(
                    value: model.type == 'Приход' ? 0 : 1,
                    onChanged: (val) => model.changeType(val),
                    choiceItems: C2Choice.listFrom<int, String>(
                        source: model.types,
                        value: (i, v) => i,
                        label: (i, v) => v),
                    choiceActiveStyle: const C2ChoiceStyle(
                      color: Color.fromARGB(255, 54, 57, 244),
                      borderColor: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    choiceStyle: const C2ChoiceStyle(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    wrapped: true,
                  ),
                  model.dataMap.isEmpty
                      ? Container(child: Text('Нет данных'),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                  )
                      : PieChart(
                    dataMap: model.dataMap,
                    chartValuesOptions: ChartValuesOptions(
                    showChartValuesInPercentage: true,
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
