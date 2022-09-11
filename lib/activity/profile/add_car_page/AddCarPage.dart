import 'package:car_online/Config.dart';
import 'package:car_online/activity/services/evacuation/models/Car.dart';
import 'package:car_online/activity/stubs/CarsListHolder.dart';
import 'package:car_online/widget/MainButton.dart';
import 'package:flutter/material.dart';

class AddCarPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _AddCarPage();
}

class _AddCarPage extends State<AddCarPage> {

  /**
   * CarNumber Text Field
   */
  TextEditingController carNumberController = TextEditingController();
  bool numberFieldValidate = true;

  /**
   * CTC Text Field
   */
  TextEditingController carCtcController = TextEditingController();
  bool ctcFieldValidate = true;
  /**
   * VIN Text Field
   */
  TextEditingController carVinController = TextEditingController();
  bool vinFieldValidate = true;

  List<String> carModels = List.empty();
  String? carManufacturerSelectedItem;
  String? carModelSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.activityBackColor,

      appBar: AppBar(
        title: Text('Добавить автомобиль',),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  )
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Config.padding, Config.padding / 2,
                        Config.padding, 40
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Добавьте свой автомобиль \n'
                              'и получайте актуальную информацию о штрафах',
                          style: TextStyle(
                            color: Colors.white, fontSize: 16,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
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
                    bottomRight: Radius.zero
                ),
              ),

              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  Config.padding, Config.padding,
                  Config.padding, Config.padding / 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: [
                        getTextInputs(),

                        SizedBox(height: Config.padding,),

                        MainButton(
                          label: 'Добавить',
                          onPressed: () {
                            onAddCatBtnClick();
                          },
                          labelColor: Config.textColorOnPrimary,
                          bgColor: Config.primaryColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isFieldsValid() {
    if (carManufacturerSelectedItem == null || carModelSelectedItem == null) {
      return false;
    }
    else {
      setState(() {
        numberFieldValidate = (RegExp(r'^[A-Z, А-Я]{1}[0-9]{3}[A-Z, А-Я]{2}[0-9]{2,3}$').firstMatch(
            carNumberController.value.text.replaceAll(" ", "")) != null);
        ctcFieldValidate = (RegExp(r'^[0-9]{2}[A-Z, А-Я]{2}[0-9]{6}$').firstMatch(
            carCtcController.value.text.replaceAll(" ", "")) != null);
        //vinFieldValidate = (carVinController.value.text.length == 17);
      });
        return numberFieldValidate && ctcFieldValidate && vinFieldValidate;
      }
  }

  void onAddCatBtnClick() {
    if (!isFieldsValid()) {
      return;
    }
    CarsListHolder.carsList.add(Car(
        null,
        carNumberController.value.text,
        carManufacturerSelectedItem! + " " + carModelSelectedItem!,
        carVinController.value.text,
        carCtcController.value.text
    ));
    Navigator.of(context).pop();
  }

  Widget getTextInputs() {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
              hint: Text("Марка автомобиля"),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
              value: carManufacturerSelectedItem,
              items: List.generate(
                    CarsListHolder.getManufacturers().length,
                        (index) => DropdownMenuItem(
                        value: CarsListHolder.getManufacturers()[index],
                        child: Text(CarsListHolder.getManufacturers()[index]),
                        )
                ),
              onChanged: (String? value) {
                setState(() {
                  carModels = CarsListHolder.getModels(value!);
                  carManufacturerSelectedItem = value;
                  carModelSelectedItem = null;
                });
              }),
          SizedBox(height: 10,),
          //getTextField("Модель автомобиля", "A5", carModelController),
          DropdownButtonFormField<String>(
              hint: Text("Модель автомобиля"),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
              value: carModelSelectedItem,
              items: List.generate(
                  carModels.length,
                      (index) => DropdownMenuItem(
                    value: carModels[index],
                    child: Text(carModels[index]),
                  )
              ),
              onChanged: (String? value) {
                setState(() {
                  carModelSelectedItem = value;
                });
              }),
          SizedBox(height: 5,),
          getTextField("Госномер", "A000AA 116", carNumberController, numberFieldValidate),
          getTextField("СТС", "00 AA 000000", carCtcController, ctcFieldValidate),
          getTextField("VIN", "VF1HD95584A295F44", carVinController, vinFieldValidate),
        ],
      );
  }

  Widget getTextField(String title, String hint, TextEditingController controller, bool validate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title, style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Config.textColor
        ),
        ),
        SizedBox(height: 5,),
        TextField(
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(
            hintText: hint,
            errorText: validate? null : "Поле должно быть заполнено корректно!",
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
          controller: controller,
        ),
        SizedBox(height: 5,),
      ],
    );
  }
}