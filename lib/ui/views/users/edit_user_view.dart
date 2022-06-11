import 'package:flutter/material.dart';
import 'package:moneylover/core/viewmodels/user/edit_user_model.dart';
import 'package:moneylover/ui/shared/ui_helpers.dart';

import '../../../core/database/moor_database.dart';
import '../base_view.dart';

class EditUserView extends StatelessWidget {
  final User user;

  const EditUserView(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<EditUserModel>(
        onModelReady: (model) async => await model.init(user),
        builder: (context, model, child) => Scaffold(
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
                            child: const Text(
                              'Сохранить',
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () async {
                              await model.editUser(context, user.id);
                            }),
                      )
                    ],
                  ),
                ),
              ),
            )
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
        border: const OutlineInputBorder(),
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        labelText: text,
        suffixIcon: InkWell(
          onTap: () {
            controller.clear();
          },
          child: const Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        labelStyle: const TextStyle(
          color: Color(0xFFFF000000),
        ),
        helperText: helperText,
      ),
    );
  }
}