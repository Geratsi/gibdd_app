import 'package:car_online/config.dart';
import 'package:flutter/material.dart';

class AndroidSelect extends StatefulWidget {
  const AndroidSelect({
    Key? key,
    required this.title,
    required this.themData,
    required this.selectActions,
    this.cancelButton,
  }) : super(key: key);

  final String title;
  final Iterable<Map> selectActions;
  final Widget? cancelButton;
  final ThemeData themData;

  @override
  State<AndroidSelect> createState() => _AndroidSelectState();
}

class _AndroidSelectState extends State<AndroidSelect> {
  final List<SimpleDialogOption> _actions = <SimpleDialogOption>[];

  @override
  void initState() {
    super.initState();

    for (var item in widget.selectActions) {
      _actions.add(SimpleDialogOption(
        onPressed: item['handler'],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              item['label'],
              style: TextStyle(fontSize: 20, color: widget.themData.primaryColor),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 15,),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = Theme.of(context);

    _actions.add(SimpleDialogOption(
      child: widget.cancelButton ?? Container(
        child: Text(
          'Отмена',
          style: TextStyle(fontSize: 18, color: Config.primaryLightColor),
          textAlign: TextAlign.center,
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),);

    return SimpleDialog(
      title: Container(
        child: Text(
          widget.title,
          style: TextStyle(fontSize: 18, color: Config.textColor),
          textAlign: TextAlign.center,
        ),
        margin: const EdgeInsets.only(bottom: 15),
      ),
      children: _actions,
      contentPadding: const EdgeInsets.only(bottom: 0),
      backgroundColor: Config.textColorOnPrimary,
    );
  }
}

