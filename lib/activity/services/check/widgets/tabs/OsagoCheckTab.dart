import 'package:car_online/Config.dart';
import 'package:car_online/activity/services/check/models/OsagoCheckResult.dart';
import 'package:car_online/activity/services/check/widgets/cards/OsagoCard.dart';
import 'package:car_online/activity/stubs/CheckDataHolder.dart';
import 'package:car_online/widget/MainButton.dart';
import 'package:car_online/widget/MainInputText.dart';
import 'package:flutter/material.dart';

class OsagoCheckTab extends StatefulWidget {
  const OsagoCheckTab({Key? key}) : super(key: key);

  @override
  _OsagoCheckTabState createState() => _OsagoCheckTabState();
}

class _OsagoCheckTabState extends State<OsagoCheckTab> {
  final List<String> _series = ['ХХХ', 'ССС', 'РРР', 'ННН', 'МММ', 'ККК', 'ЕЕЕ', 'ВВВ', 'ТТТ', 'ААС', 'ААВ'];

  late TextEditingController _osagoNumberController;

  OsagoCheckResult? osagoCheckResult;
  String? _seriesValue;

  @override
  void initState() {
    _osagoNumberController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _osagoNumberController.dispose();

    super.dispose();
  }

  void _checkOsago() {
    if (_osagoNumberController.text.isNotEmpty && _seriesValue != null) {
      setState(() {
        osagoCheckResult = CheckDataHolder.getOsagoCheckResult(_seriesValue!, _osagoNumberController.text,);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                color: Config.baseInfoColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: Config.padding / 2),
              child: DropdownButton<String>(
                hint: Text('Серия', style: TextStyle(fontSize: Config.textLargeSize,
                    color: Config.textColor),
                ),
                value: _seriesValue,
                icon: Icon(Icons.expand_more),
                elevation: 16,
                underline: SizedBox(),
                onChanged: (String? newValue) {
                  setState(() {
                    _seriesValue = newValue!;
                  });
                },
                items: _series.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontSize: Config.textMediumSize,
                        color: Config.primaryColor),),
                  );
                }).toList(),
              ),
            ),

            SizedBox(width: Config.padding / 2,),

            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                  color: Config.baseInfoColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: Config.padding / 4),
                child: MainInputText(
                  type: TextInputType.number,
                  controller: _osagoNumberController,
                  capitalization: TextCapitalization.characters,
                  hintText: 'Номер полиса',
                  isUnderlined: false,
                  maxLength: 10,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: Config.padding,),

        MainButton(
          label: 'Проверить',
          onPressed: () {
            _checkOsago();
          },
          labelColor: Config.textColorOnPrimary,
          bgColor: Config.primaryColor,
        ),

        SizedBox(height: Config.padding,),

        osagoCheckResult != null ? OsagoCard(osagoCheckResult: osagoCheckResult!,)
            : SizedBox.shrink(),
      ],
    );
  }
}

