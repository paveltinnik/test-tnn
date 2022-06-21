import 'package:flutter/material.dart';
import 'package:moneylover/ui/shared/ui_helpers.dart';
import '../../../core/viewmodels/user/user_model.dart';
import '../base_view.dart';

class InsertUserView extends StatelessWidget {
  const InsertUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<UserModel>(
        onModelReady: (model) async => await model.init(user: null, isInsertView: true),
        builder: (context, model, child) =>
            Scaffold(
              appBar: AppBar(
                title: const Text('Добавить пользователя'),
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
                              'Добавить',
                              style: TextStyle(fontSize: 16),
                            ),
                            // color: backgroundColor,
                            // textColor: Colors.black,
                            onPressed: () {
                              model.addUser(context);
                            }
                          // await model.addTransaction(context);
                        ),
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