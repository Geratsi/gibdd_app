
import 'package:car_online/widget/InputText.dart';
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';

class CommentsDialogComponent extends StatefulWidget {
  const CommentsDialogComponent({
    Key? key,
    required this.sendFunc,
    required this.cancelFunc,
  }) : super(key: key);

  final Function cancelFunc;
  final Function(String?) sendFunc;

  @override
  _CommentsDialogComponentState createState() => _CommentsDialogComponentState();
}

class _CommentsDialogComponentState extends State<CommentsDialogComponent> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Config.activityBorderRadius),),
      title: Text(
        'Добавьте комментарии',
        style: TextStyle(color: Config.textTitleColor),
        textAlign: TextAlign.center,
      ),

      content: InputText(
        '', TextInputType.multiline, _controller,
        minLines: 3, hintText: 'Комментарии', disableLabel: true,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            widget.cancelFunc();
            Navigator.of(context).pop();
          },
          child: Text('Отмена', style: TextStyle(color: Config.errorColor,
            fontSize: Config.textLargeSize,),),
        ),

        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.sendFunc(_controller.text);
          },
          child: Text('Отправить', style: TextStyle(fontSize: Config.textLargeSize),),
        ),
      ],
    );
  }
}

