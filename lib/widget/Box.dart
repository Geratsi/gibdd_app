import 'package:flutter/widgets.dart';

class Box extends StatelessWidget {
  Widget child;
  EdgeInsets padding = EdgeInsets.all(0);

  Box(EdgeInsets this.padding, Widget this.child);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
        Padding(
          padding: padding,
          child: child
        )
    );
  }

}



