import 'package:flutter/material.dart';

class OptionView extends StatelessWidget {
  String? titleOption;
  IconData? icon;
  Future<dynamic>? onTapFunction;

  OptionView(this.titleOption, this.icon, this.onTapFunction);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size(150, 80),
        child: Material(
          color: Colors.black12,
          child: InkWell(
            splashColor: Colors.grey,
            onTap: () {
              onTapFunction;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(icon), // <-- Icon
                Text(titleOption!), // <-- Text
              ],
            ),
          ),
        ),
        // ),
      ),
    );
  }
}