import 'package:car_online/Config.dart';
import 'package:car_online/activity/services/check/models/LicenseCheckResult.dart';
import 'package:car_online/activity/services/check/widgets/cards/LicenseCard.dart';
import 'package:car_online/activity/stubs/CheckDataHolder.dart';
import 'package:car_online/res/Strings.dart';
import 'package:car_online/widget/MainButton.dart';
import 'package:car_online/widget/MainInputText.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LicenseCheckTab extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LicenseCheckTab();
}

class _LicenseCheckTab extends State<LicenseCheckTab> {
  LicenseCheckResult? licenseCheckResult;
  DateTime _fromDate = DateTime.now().toLocal();

  late TextEditingController _licenseNumberController;

  @override
  void initState() {
    _licenseNumberController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _licenseNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTextField(Strings.license_check_number_hint,
            Strings.license_check_number_hint, _licenseNumberController),

        Padding(
          padding: EdgeInsets.all(Config.padding / 3,),
          child: Text(Strings.license_check_date_hint,
            style: TextStyle(
              fontSize: Config.textMediumSize,
              color: Config.textColor,
            ),
          ),
        ),

        Material(
          borderRadius: BorderRadius.circular(Config.activityBorderRadius),
          color: Config.baseInfoColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(Config.activityBorderRadius),
            splashColor: Config.primaryLightColor,
            child: Padding(
              padding: EdgeInsets.all(Config.padding / 1.5),
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
              _selectDate(context);
            },
          ),
        ),

        SizedBox(height: Config.padding,),

        MainButton(
          label: Strings.check_service_btn_title,
          onPressed: () {
            _checkLicense();
          },
          labelColor: Config.textColorOnPrimary,
          bgColor: Config.primaryColor,
        ),

        SizedBox(height: Config.padding,),

        licenseCheckResult != null ? LicenseCard(licenseCheckResult!)
            : SizedBox.shrink(),
      ],
    );
  }

  Widget getTextField(String title, String hint, TextEditingController textEditingController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainInputText(
          type: TextInputType.number,
          controller: textEditingController,
          hintText: hint,
        ),

        SizedBox(height: Config.padding / 2,),
      ],
    );
  }

  void _checkLicense() {
    final String inputText = _licenseNumberController.text;
    if (inputText.isNotEmpty) {
      setState(() {
        licenseCheckResult = CheckDataHolder.getLicenseCheckResult(inputText);
      });
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _fromDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().toLocal());

    if (pickedDate != null && pickedDate != _fromDate) {
      setState(() {_fromDate = pickedDate;});
    }
  }
}