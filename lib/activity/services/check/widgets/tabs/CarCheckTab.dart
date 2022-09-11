import 'package:car_online/activity/services/check/models/CarCheckResult.dart';
import 'package:car_online/activity/services/check/widgets/cards/CarCard.dart';
import 'package:car_online/activity/stubs/CheckDataHolder.dart';
import 'package:car_online/res/Strings.dart';
import 'package:car_online/widget/MainButton.dart';
import 'package:car_online/widget/MainInputText.dart';
import 'package:flutter/material.dart';

import '../../../../../Config.dart';
import '../../CarDetailedInfo.dart';

class CarCheckTab extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _CarCheckTab();
}

class _CarCheckTab extends State<CarCheckTab> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTextField(Strings.car_check_field_hint, Strings.car_check_field_hint, textEditingController),

        SizedBox(height: Config.padding,),

        MainButton(
          label: Strings.check_service_btn_title,
          onPressed: () {
            onClickCheckBtn(textEditingController.value.text);
          },
          labelColor: Config.textColorOnPrimary,
          bgColor: Config.primaryColor,
        ),

        SizedBox(height: Config.padding,),
        
        SingleChildScrollView(
          child: Column(
            children: getViewItems()
          )
        ),
      ],
    );
  }

  List<Widget> getViewItems() {
    return List.generate(
        CheckDataHolder.carCheckHistory.length,
            (index) =>
            CarCard(
                CheckDataHolder.carCheckHistory[index],
                    () {
                  navigateToDetailCarInfo(
                      CheckDataHolder.carCheckHistory[index]);
                },
                    (CarCheckResult carCheckResult) {
                  deleteCarCheckResult(carCheckResult);
                })
    );
  }

  void onClickCheckBtn(String value) {
    value = value.replaceAll(" ", "");
    setState(() {
      if (isNumber(value)) {
        var carCheckResult = CheckDataHolder.getCarCheckResultByNumber(value);
        CheckDataHolder.carCheckHistory.add(carCheckResult!);
      }
      else if (isVin(value)) {
        var carCheckResult = CheckDataHolder.getCarCheckResultByVin(value);
        CheckDataHolder.carCheckHistory.add(carCheckResult!);
      }
    });
  }

  bool isNumber(String value) {
    return (RegExp(r'^[A-Z, А-Я]{1}[0-9]{3}[A-Z, А-Я]{2}[0-9]{2,3}$').firstMatch(value) != null);
  }

  bool isVin(String value) {
    return (value.length == 17);
  }

  void navigateToDetailCarInfo(CarCheckResult carCheckResult) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CarDetailedInfo(carCheckResult))
    );
  }

  void deleteCarCheckResult(CarCheckResult carCheckResult) {
    showAlertDialogConfirm(
        getConfirmDialog(
            "",
            "Удалить автомобиль из истории поиска?",
            "Да",
            "Нет",
            () {
              setState(() {
                CheckDataHolder.carCheckHistory.remove(carCheckResult);
              });
            },
            () {})
    );
  }

  void showAlertDialogConfirm(AlertDialog dialog) {
    showDialog(
        context: context,
        builder: (context) {
          return dialog;
        }
    );
  }

  AlertDialog getConfirmDialog(
      String title,
      String message,
      String positiveBtnText,
      String negativeBtnText,
      Function positiveBtnCallback,
      Function negativeBtnCallback) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          child: Text(negativeBtnText),
          onPressed: () {
            negativeBtnCallback();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(positiveBtnText),
          onPressed: () {
            positiveBtnCallback();
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  Widget getTextField(String title, String hint, TextEditingController textEditingController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainInputText(
          type: TextInputType.text,
          controller: textEditingController,
          capitalization: TextCapitalization.characters,
          hintText: hint,
        ),
      ],
    );
  }
}