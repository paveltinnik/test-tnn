import 'package:flutter/material.dart';

class ChooseCategoryView extends StatefulWidget {
  const ChooseCategoryView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChooseCategoryViewState();
}

class _ChooseCategoryViewState extends State<ChooseCategoryView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Категория'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      String textToSendBack = 'Зарплата';
                      Navigator.pop(context, textToSendBack);
                    },
                    child: const Text('Зарплата'),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      String textToSendBack = 'Подарок';
                      Navigator.pop(context, textToSendBack);
                      // Navigator.of(context).pushNamed('inserttransaction');
                    },
                    child: const Text('Подарок'),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      String textToSendBack = 'Вознаграждение';
                      Navigator.pop(context, textToSendBack);
                      // Navigator.of(context).pushNamed('inserttransaction');
                    },
                    child: const Text('Вознаграждение'),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }

// void _sendDataBack(BuildContext context) {
//   String textToSendBack = textFieldController.text;
//   Navigator.pop(context, textToSendBack);
// }


}