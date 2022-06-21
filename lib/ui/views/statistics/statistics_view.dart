import 'package:flutter/material.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text('Статистика'),
          ),
          body: GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              childAspectRatio: 2,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed('piechart');
                      // simpleDialogWithOption(context);
                    },
                    icon: Icon(Icons.pie_chart),
                    label: Text('Диаграмма по категориям'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed('usersbalancechart');
                      // simpleDialogWithOption(context);
                    },
                    icon: const Icon(Icons.balance),
                    label: const Text('Доходы пользователей'),
                  ),
                )
              ]
          ),
    );
  }
}