import 'package:flutter/material.dart';
import 'package:moneylover/core/enums/viewstate.dart';

class BaseModel extends ChangeNotifier {
  void setState() {
    notifyListeners();
  }
}
