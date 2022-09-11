import 'package:car_online/widget/Button.dart';
import 'package:car_online/widget/MainButton.dart';
import 'package:car_online/widget/MainInputText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_online/config.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfoActivity extends StatefulWidget {
  const PersonalInfoActivity({Key? key}) : super(key: key);

  @override
  _PersonalInfoActivityState createState() => _PersonalInfoActivityState();
}

class _PersonalInfoActivityState extends State<PersonalInfoActivity> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _thirdNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    _nameController.text = 'Михаил';
    _secondNameController.text = 'Палий';
    _thirdNameController.text = 'Евгеньевич';
    _phoneNumberController.text = '+7 (999) 999-99-99';

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _secondNameController.dispose();
    _thirdNameController.dispose();
    _phoneNumberController.dispose();

    super.dispose();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.activityBackColor,

      appBar: AppBar(
          title: Text('Личные данные',),
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
                            child: Image.asset("assets/img/user_photo.png"),
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
                      type: TextInputType.phone,
                      controller: _phoneNumberController,
                      mask: true,
                    ),

                    MainInputText(
                      type: TextInputType.name,
                      controller: _secondNameController,
                    ),

                    MainInputText(
                      type: TextInputType.name,
                      controller: _nameController,
                    ),

                    MainInputText(
                      type: TextInputType.name,
                      controller: _thirdNameController,
                    ),

                    SizedBox(height: 20,),

                    MainButton(
                      label: 'Сохранить изменения',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      labelColor: Config.textColorOnPrimary,
                      bgColor: Config.primaryColor,
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

