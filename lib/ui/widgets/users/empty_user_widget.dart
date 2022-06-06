import 'package:flutter/material.dart';
import '../../shared/ui_helpers.dart';

class EmptyUserWidget extends StatelessWidget {
  const EmptyUserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UIHelper.verticalSpaceLarge(),
        Icon(Icons.people_rounded, size: 50),
        UIHelper.verticalSpaceMedium(),
        const Text(
          'Нет пользователей\nНажмите + чтобы добавить.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      ],
    );
  }
}
