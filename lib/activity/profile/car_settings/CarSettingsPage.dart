import 'package:car_online/activity/services/evacuation/models/Car.dart';
import 'package:car_online/activity/stubs/CarsListHolder.dart';
import 'package:car_online/widget/Button.dart';
import 'package:car_online/widget/MainButton.dart';
import 'package:car_online/widget/MainInputText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config.dart';

class CarSettingsPage extends StatefulWidget {

  CarSettingsPage(this.car);

  Car car;

  @override
  State<StatefulWidget> createState() => _CarSettingsPage(car);
}

class _CarSettingsPage extends State<CarSettingsPage> {

  _CarSettingsPage(this.car);

  Car car;
  ImagePicker _picker = ImagePicker();
  TextEditingController carNumberController = TextEditingController();
  TextEditingController carCtcController = TextEditingController();

  /// Get from gallery
  void _getPhotoFromGallery() async {
    //Navigator.pop(context);
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 2800,
      maxHeight: 2800,
    );

    // if (pickedFile != null) {
    //   Uint8List _imageBytes = await pickedFile.readAsBytes();
    //   setState(() {
    //     _imageProvider = MemoryImage(_imageBytes);
    //   });
    //
    //   _imageBytesController.setValue = _imageBytes;
    // }
  }

  /// Get from camera
  void _getPhotoFromCamera() async {
    //Navigator.pop(context);
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 2800,
      maxHeight: 2800,
    );

    // if (pickedFile != null) {
    //   Uint8List _imageBytes = await pickedFile.readAsBytes();
    //   setState(() {
    //     _imageProvider = MemoryImage(_imageBytes);
    //   });
    //
    //   _imageBytesController.setValue = _imageBytes;
    // }
  }


  @override
  void initState() {
    carNumberController.text = car.carNumber;
    carCtcController.text = car.ctc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.activityBackColor,

      appBar: AppBar(
          title: Text('Данные автомобиля',),
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
          )
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
                  )
              ),

              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  Config.padding, Config.padding,
                  Config.padding, Config.padding * 2,),

                child: Column(
                  children: <Widget>[
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                      ),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                            child: Image.asset(
                                car.imgPath),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Button(
                          "Изменить фото",
                              () {
                            _getPhotoFromCamera();
                          },
                          color: Config.activityBackColor,
                          backgroundColor: Colors.transparent,
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
                    bottomRight: Radius.zero
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
                padding: EdgeInsets.fromLTRB(
                  Config.padding, 0,
                  Config.padding, Config.padding,
                ),

                child: Column(
                  children: <Widget>[
                    MainInputText(
                      type: TextInputType.text,
                      controller: carNumberController,
                    ),

                    MainInputText(
                      type: TextInputType.text,
                      controller: carCtcController,
                    ),

                    SizedBox(height: 20,),

                    MainButton(
                      label: 'Сохранить изменения',
                      onPressed: () {
                        onSaveBtnClick();
                      },
                      labelColor: Config.textColorOnPrimary,
                      bgColor: Config.primaryColor,
                    ),
                    SizedBox(height: 20,),

                    MainButton(
                      label: 'Удалить автомобиль',
                      onPressed: () {
                        onDeleteCarBtnClick(car);
                      },
                      labelColor: Config.textColorOnPrimary,
                      bgColor: Config.secondaryButtonColor,
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

  void onSaveBtnClick() {
    var car = CarsListHolder.carsList[CarsListHolder.carsList.indexOf(this.car)];
    car.carNumber = carNumberController.value.text;
    car.ctc = carCtcController.value.text;
    Navigator.of(context).pop();
  }

  void onDeleteCarBtnClick(Car car) {
    if (CarsListHolder.carsList.remove(car)) {
      Navigator.of(context).pop();
    }
  }
}