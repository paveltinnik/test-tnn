import 'package:flutter/material.dart';
import 'package:moneylover/ui/shared/ui_helpers.dart';
import 'package:provider/provider.dart';

import '../../../core/database/moor_database.dart';
import '../../../core/viewmodels/user/insert_edit_model.dart';

class EditUserView extends StatefulWidget {
  const EditUserView(User user, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditUserViewState();
}

class _EditUserViewState extends State<EditUserView> {
  var model = InsertEditUserModel();
  String username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать пользователя'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              buildTextField(model.nameController, 'Имя:',
                  "Введите имя пользователя", Icons.edit, false),
              UIHelper.verticalSpaceMedium(),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  child: Text(
                    'Сохранить',
                    style: TextStyle(fontSize: 16),
                  ),
                  // color: backgroundColor,
                  // textColor: Colors.black,
                  onPressed: () {
                    setState(() {
                      UsersCompanion.insert(name: model.nameController.text);

                      // AppDatabase().insertUser(User(
                      //   name: model.nameController.text,
                      // ));
                      model.nameController.clear();
                      Navigator.pop(context);
                    });
                  }
                    // await model.addTransaction(context);
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildTextField(TextEditingController controller, String text,
      String helperText, IconData icon, isNumeric) {
    return TextFormField(
      cursorColor: Colors.black,
      maxLength: isNumeric ? 10 : 40,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        labelText: text,
        suffixIcon: InkWell(
          onTap: () {
            controller.clear();
          },
          child: Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(
          color: Color(0xFFFF000000),
        ),
        helperText: helperText,
      ),
    );
  }
}
