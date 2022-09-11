import 'package:flutter/material.dart';

import '../Config.dart';

class InputText extends StatefulWidget {
  String name;
  TextInputType type;
  TextEditingController controller;

  Function()? onTap;
  bool readOnly;
  Color? color;
  Color errorColor;
  bool isPassword;
  String? validEmptyText;
  EdgeInsetsGeometry? margin;
  int? minLines;
  String? hintText;
  bool disableLabel;

  InputText(
    this.name,
    this.type,
    this.controller,
    {
      this.onTap,
      this.readOnly = false,
      this.color,
      this.errorColor = Colors.red,
      this.isPassword = false,
      this.validEmptyText,
      this.margin,
      this.minLines,
      this.hintText,
      this.disableLabel = false,
    });

  @override
  ActivityState createState() => ActivityState();
}

class ActivityState extends State<InputText> with WidgetsBindingObserver{

  Color currentColor = Colors.grey;

  @override
  initState(){
    currentColor = widget.color==null ? Config.primaryColor : widget.color!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin==null ? EdgeInsets.fromLTRB(0, 0, 0, Config.padding) : widget.margin!,
      child: TextFormField(
        obscureText: widget.isPassword,
        maxLines: widget.isPassword ? 1 : null,
        minLines: widget.minLines ?? null,
        readOnly: widget.readOnly,
        controller: widget.controller,
        validator: (text){
          String? error;
          if (text!=null){
            if (widget.validEmptyText!=null){
              if (text.isEmpty)
                error = widget.validEmptyText;
            }
          }
          if (error==null){
            setState(() {
              currentColor = widget.color==null ? Config.primaryColor : widget.color!;
            });
          } else {
            setState(() {
              currentColor = widget.errorColor;
            });
          }
          return error;
        },
        onTap: widget.onTap,
        keyboardType: widget.type,
        style: TextStyle(color: currentColor, fontSize: 16),
        cursorColor: currentColor,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(color: widget.disableLabel ? Config.textColor : currentColor, fontSize: 16),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2,color: currentColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2,color: currentColor),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 2,color: widget.errorColor)
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 2,color: widget.errorColor)
          ),
          labelText: widget.disableLabel ? null : widget.name,
          hintText: widget.hintText ?? '',
          labelStyle: TextStyle(color: currentColor, fontSize: 16),
          errorStyle: TextStyle(color: widget.errorColor, fontSize: 12)
        ),
      ),
    );
  }

}



