import 'package:car_online/Config.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    Key? key,
    required this.checked,
    required this.onPressed,
    this.containerWidth = 25,
    this.containerHeight = 25,
    this.containerBgColor,
  }) : super(key: key);

  final bool checked;
  final Function onPressed;
  final double? containerWidth;
  final double? containerHeight;
  final Color? containerBgColor;

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.containerWidth,
      height: widget.containerHeight,
      decoration: BoxDecoration(
        color: widget.containerBgColor == null
            ? Config.activityBackColor
            : widget.containerBgColor,
        borderRadius: BorderRadius.circular(Config.activityBorderRadius),
      ),
      child: Checkbox(
        value: widget.checked,
        onChanged: (value) {
          widget.onPressed(value);
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder( // BeveledRectangleBorder for rectangle border, not circle
          borderRadius: BorderRadius.circular(Config.activityBorderRadius),
        ),
      ),
    );
  }
}

