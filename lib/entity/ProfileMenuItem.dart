
import 'package:flutter/cupertino.dart';

class ProfileMenuItem {
  late String itemLabel;
  late Widget itemImageSource;
  late Widget itemWidget;

  ProfileMenuItem(itemLabel, itemImageSource, itemWidget) {
    this.itemLabel = itemLabel;
    this.itemImageSource = itemImageSource;
    this.itemWidget = itemWidget;
  }
}
