import 'package:car_online/Config.dart';
import 'package:flutter/material.dart';

class MainButton extends StatefulWidget {
  const MainButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.bgColor,
    required this.labelColor,
    this.padding,
    this.labelSize,
    this.labelAlignment,
    this.child,
  }) : super(key: key);

  final String label;
  final Function? onPressed;
  final Color bgColor;
  final Color labelColor;
  final EdgeInsets? padding;
  final double? labelSize;
  final MainAxisAlignment? labelAlignment;
  final Widget? child;

  @override
  _MainButtonState createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.bgColor,
      borderRadius: BorderRadius.circular(Config.activityBorderRadius),
      child: InkWell(
        splashColor: Config.primaryLightColor,
        borderRadius: BorderRadius.circular(Config.activityBorderRadius),
        child: Padding(
          padding: widget.padding == null
              ? EdgeInsets.symmetric(vertical: Config.padding, horizontal: Config.padding / 2)
              : widget.padding!,
          child: widget.child != null
              ? widget.child
              : Row(
            mainAxisAlignment: widget.labelAlignment ?? MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    color: widget.labelColor,
                    fontSize: widget.labelSize == null ? Config.textMediumSize : widget.labelSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
        },
      ),
    );
  }
}
