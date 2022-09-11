import 'package:car_online/Config.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MainInputText extends StatefulWidget {
  const MainInputText({
    Key? key,
    required this.type,
    required this.controller,
    this.onTap,
    this.isPassword = false,
    this.readOnly = false,
    this.mask = false,
    this.hintText = '',
    this.capitalization = TextCapitalization.none,
    this.isUnderlined = true,
    this.maxLength = 10000,
  }) : super(key: key);

  final TextInputType type;
  final TextEditingController controller;
  final Function()? onTap;
  final bool isPassword;
  final bool readOnly;
  final bool mask;
  final String hintText;
  final TextCapitalization capitalization;
  final bool isUnderlined;
  final int maxLength;

  @override
  _MainInputTextState createState() => _MainInputTextState();
}

class _MainInputTextState extends State<MainInputText> {
  final FocusNode _inputFocus = FocusNode();
  late MaskTextInputFormatter _numberMask;

  Color _currentColor = Config.textColor;

  @override
  void initState() {
    _numberMask = MaskTextInputFormatter(
        mask: '+# (###) ###-##-##',
        filter: { "#": RegExp(r'[0-9]') },
        type: MaskAutoCompletionType.lazy
    );

    _inputFocus.addListener(() {
      setState(() {
        _currentColor = _inputFocus.hasPrimaryFocus ? Config.primaryColor : Config.textColor;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _inputFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.mask ? [_numberMask] : null,
      focusNode: _inputFocus,
      obscureText: widget.isPassword,
      maxLines: widget.isPassword ? 1 : null,
      readOnly: widget.readOnly,
      controller: widget.controller,
      maxLength: widget.maxLength,
      validator: (text){
        String? error;
        if (text!=null){
          if (text.isEmpty)
            error = 'empty';
          print('empty');
        }

        if (error==null){
          setState(() {
            _currentColor = Config.primaryColor;
          });
        } else {
          setState(() {
            _currentColor = Config.errorColor;
          });
        }
        return error;
      },
      textCapitalization: widget.capitalization,
      onTap: widget.onTap,
      keyboardType: widget.type,
      style: TextStyle(color: _currentColor, fontSize: Config.textLargeSize),
      cursorColor: _currentColor,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(5),
        hintText: widget.hintText,
        counterText: '',
        hintStyle: TextStyle(color: _currentColor, fontSize: Config.textLargeSize),
        focusedBorder: widget.isUnderlined ? UnderlineInputBorder(
          borderSide: BorderSide(color: Config.primaryColor, width: widget.isUnderlined ? 2 : 0),
        ) : InputBorder.none,
        enabledBorder: widget.isUnderlined ? UnderlineInputBorder(
          borderSide: BorderSide(color: Config.textColor, width: 2),
        ) : InputBorder.none,
        errorBorder: widget.isUnderlined ? UnderlineInputBorder(
          borderSide: BorderSide(color: Config.errorColor, width: widget.isUnderlined ? 2 : 0),
        ) : InputBorder.none,
        focusedErrorBorder: widget.isUnderlined ? UnderlineInputBorder(
          borderSide: BorderSide(color: Config.errorColor, width: widget.isUnderlined ? 2 : 0),
        ) : InputBorder.none,
        errorStyle: TextStyle(color: Config.errorColor, fontSize: Config.textSmallSize),
      ),
    );
  }
}
