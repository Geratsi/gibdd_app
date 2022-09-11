import 'package:flutter/material.dart';

class ValueListener<T> extends ChangeNotifier {
  ValueListener({
    this.value,
  });

  T? value;

  T? get getValue => value;

  set setValue(T val) {
    value = val;
    notifyListeners();
  }
}
