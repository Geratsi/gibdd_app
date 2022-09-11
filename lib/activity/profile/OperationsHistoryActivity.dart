import 'package:car_online/Config.dart';
import 'package:car_online/tool/ValueListener.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


class OperationsHistoryActivity extends StatefulWidget {
  const OperationsHistoryActivity({Key? key}) : super(key: key);

  @override
  _OperationsHistoryActivityState createState() => _OperationsHistoryActivityState();
}

class _OperationsHistoryActivityState extends State<OperationsHistoryActivity> {
  final DateTime _localTime = DateTime.now().toLocal();
  final Map<String, Color> statusColors = {
    'В работе': Config.primaryDarkColor,
    'Принята': Config.textTitleColor,
    'Закрыта': Config.successColor,
  };

  late DateTime _fromDate;
  late DateTime _toDate;
  late ValueListener<DateTime> _fromDateController;
  late ValueListener<DateTime> _toDateController;

  @override
  void initState() {
    initLanguageSettings();

    setState(() {
      _fromDate = DateTime(_localTime.year, _localTime.month - 1, _localTime.day);
      _toDate = _localTime;
    });

    _fromDateController = ValueListener<DateTime>(
      value: _fromDate,
    );
    _toDateController = ValueListener<DateTime>(
      value: _toDate,
    );

    super.initState();
  }

  Future<void> initLanguageSettings() async {
    await initializeDateFormatting();
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();

    super.dispose();
  }

  void _selectDate(BuildContext context, bool from, ValueListener controller) async {

    // if (Platform.isIOS) {
    //   showCupertinoModalPopup(
    //     context: context,
    //     builder: (_) => IOSDatePicker(
    //       initialDateTime: _selectedBornDate,
    //       minimumDateTime: DateTime(1930),
    //       maximumDateTime: DateTime(_now.year - 18, _now.month, _now.day),
    //       onChange: (pickedDate) {
    //         if (pickedDate != null) {
    //           setState(() {_selectedBornDate = pickedDate;});
    //           _bornDateController.setValue = pickedDate;
    //         }
    //       },
    //     ),
    //   );
    //
    // } else if (Platform.isAndroid) {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: controller.getValue!,
      firstDate: DateTime(2000),
      lastDate: _localTime,
    );

    if (pickedDate != null && pickedDate != controller.getValue) {
      if (from) {
        setState(() {_fromDate = pickedDate;});
      } else {
        setState(() {_toDate = pickedDate;});
      }
      controller.setValue = pickedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.activityBackColor,

      appBar: AppBar(
        title: Text('История операций',),
        centerTitle: true,
        shadowColor: Colors.transparent,
        leading: Row(
          children: <Widget>[
            SizedBox(width: Config.padding * 0.5,),
            IconButton(
              icon: Image.asset("assets/img/arrow_back.png"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Config.primaryColor,
                    Config.primaryDarkColor,
                    //Color.fromARGB(255, 69,96,181),
                  ],
                ),
              ),

              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  Config.padding, Config.padding,
                  Config.padding, Config.padding * 2,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Выберите период, за который хотите\nпосмотреть историю платежей',
                      style: TextStyle(color: Config.textColorOnPrimary, fontSize: Config.textMediumSize,),
                    ),

                    SizedBox(height: 10,),

                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text('С',
                                style: TextStyle(color: Config.textColorOnPrimary, fontSize: Config.textLargeSize,),
                              ),

                              SizedBox(height: Config.padding / 3,),

                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                                  color: Config.activityBackColor,
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                                  splashColor: Config.primaryLightColor,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: Config.padding / 1.5, horizontal: Config.padding / 3),
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(DateFormat('dd MMM y', 'ru').format(_fromDate),
                                          style: TextStyle(fontSize: Config.textLargeSize,
                                              color: Config.primaryDarkColor),
                                        ),

                                        Icon(Icons.date_range, color: Config.primaryDarkColor,)
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    _selectDate(context, true, _fromDateController);
                                  },
                                ),
                              ),
                            ],
                          ),
                          flex: 25,
                        ),

                        Expanded(child: Text(''), flex: 1,),

                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text('По',
                                style: TextStyle(color: Config.textColorOnPrimary, fontSize: Config.textLargeSize,),
                              ),

                              SizedBox(height: Config.padding / 3,),

                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                                  color: Config.activityBackColor,
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                                  splashColor: Config.primaryLightColor,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: Config.padding / 1.5, horizontal: Config.padding / 3),
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(DateFormat('dd MMM y', 'ru').format(_toDate),
                                          style: TextStyle(fontSize: Config.textLargeSize,
                                              color: Config.primaryDarkColor),
                                        ),

                                        Icon(Icons.date_range, color: Config.primaryDarkColor,)
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    _selectDate(context, false, _toDateController);
                                  },
                                ),
                              ),
                            ],
                          ),
                          flex: 25,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Container(
              height: (Config.activityBorderRadius * 2) + 1,
              transform: Matrix4.translationValues(
                  0.0, -(Config.activityBorderRadius * 2), 0.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      Config.activityBorderRadius * 2),
                  topRight: Radius.circular(
                      Config.activityBorderRadius * 2),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),
            ),

            Container(
              transform: Matrix4.translationValues(
                  0.0, -(Config.activityBorderRadius * 4)+Config.padding, 0.0
              ),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      Config.activityBorderRadius * 2),
                  topRight: Radius.circular(
                      Config.activityBorderRadius * 2),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),

              child: Padding(
                padding: EdgeInsets.fromLTRB(Config.padding, 0,
                  Config.padding, Config.padding,
                ),

                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('2022-1',
                              style: TextStyle(fontSize: Config.textLargeSize, color: Config.textColor),
                            ),

                            Text('Заявка о правонарушении',
                              style: TextStyle(fontSize: Config.textMediumSize, color: Config.textColor),
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Принята',
                              style: TextStyle(fontSize: Config.textMediumSize,
                                  color: statusColors['Принята']),
                            ),
                          ],
                        ),

                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Config.padding),
                      child: Divider(height: 1, color: Config.textColor,),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('2022-2',
                              style: TextStyle(fontSize: Config.textLargeSize, color: Config.textColor),
                            ),

                            Text('Заявка на оплату штрафа',
                              style: TextStyle(fontSize: Config.textMediumSize, color: Config.textColor),
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Закрыта',
                              style: TextStyle(fontSize: Config.textMediumSize,
                                  color: statusColors['Закрыта']),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Config.padding),
                      child: Divider(height: 1, color: Config.textColor,),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('2022-3',
                              style: TextStyle(fontSize: Config.textLargeSize, color: Config.textColor),
                            ),

                            Text('Заявка о нарушении из сервиса\n"Народный инспектор"',
                              style: TextStyle(fontSize: Config.textMediumSize, color: Config.textColor),
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('В работе',
                                style: TextStyle(fontSize: Config.textMediumSize,
                                    color: statusColors['В работе'])
                            ),
                          ],
                        ),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Config.padding),
                      child: Divider(height: 1, color: Config.textColor,),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

