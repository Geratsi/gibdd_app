
import 'dart:developer';

import 'package:car_online/Api.dart';
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:car_online/activity/services/inspector/cards/ImageDialogActivity.dart';
import 'package:car_online/activity/services/inspector/cards/InspectorMaterialImage.dart';
import 'package:car_online/activity/services/inspector/cards/InspectorRequestCard.dart';
import 'package:car_online/activity/services/inspector/cards/VideoDialogActivity.dart';
import 'package:car_online/activity/services/inspector/models/InspectorMaterialModel.dart';
import 'package:car_online/activity/services/inspector/cards/InspectorMaterialVideo.dart';
import 'package:car_online/activity/services/inspector/models/InspectorRequestModel.dart';
import 'package:car_online/activity/services/inspector/components/ChooseDialogComponent.dart';
import 'package:car_online/widget/Button.dart';
import 'package:car_online/widget/ButtonCard.dart';
import 'package:car_online/widget/ButtonCardWidget.dart';
import 'package:car_online/widget/CustomCheckbox.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class InspectorActivity extends StatefulWidget {
  const InspectorActivity({Key? key}) : super(key: key);

  @override
  _InspectorActivityState createState() => _InspectorActivityState();
}

class _InspectorActivityState extends State<InspectorActivity> {
  final Location location = Location();
  final ImagePicker _picker = ImagePicker();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late List<InspectorMaterialModel> _materials;

  List<Widget> _historyData = [];
  bool _someIsChosen = false;
  bool _isActiveChoose = false;

  @override
  void initState() {
    _serviceIsEnabled();

    _materials = <InspectorMaterialModel>[
      InspectorMaterialModel(sourceURL: 'assets/img/video-1.png', ),
      InspectorMaterialModel(sourceURL: 'assets/img/video-2.png', ),
      InspectorMaterialModel(sourceURL: 'assets/img/video-3.png', ),
      InspectorMaterialModel(sourceURL: 'assets/img/video-4.png', ),
      InspectorMaterialModel(sourceURL: 'assets/img/photo-1.png', ),
      InspectorMaterialModel(sourceURL: 'assets/img/photo-2.png', ),
      InspectorMaterialModel(sourceURL: 'assets/video/video-1.mp4', isImage: false),
    ];

    _historyData = [
      InspectorRequestCard(
          requestModel: InspectorRequestModel('22-208692',
          'Фиксация правонарушения', 'В работе', '-'),
        materialItems: [
          InspectorMaterialModel(sourceURL: 'assets/img/photo-1.png', ),
          InspectorMaterialModel(sourceURL: 'assets/img/photo-1.png', ),
          InspectorMaterialModel(sourceURL: 'assets/img/photo-1.png', ),
          InspectorMaterialModel(sourceURL: 'assets/img/photo-2.png', ),
        ],
      ),
      InspectorRequestCard(
        requestModel: InspectorRequestModel('22-828674',
          'Фиксация правонарушения', 'Закрыта', '12'),
        materialItems: [
          InspectorMaterialModel(sourceURL: 'assets/img/photo-1.png', ),
          InspectorMaterialModel(sourceURL: 'assets/img/photo-2.png', ),
          InspectorMaterialModel(sourceURL: 'assets/img/photo-2.png', ),
          InspectorMaterialModel(sourceURL: 'assets/img/photo-2.png', ),
        ],
      ),
    ];

    super.initState();
  }

  Future<bool> _serviceIsEnabled() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }

    if (_serviceEnabled && (_permissionGranted == PermissionStatus.granted ||
        _permissionGranted == PermissionStatus.deniedForever)) {
      return true;
    } else {
      return false;
    }
  }

  void _updateElements() {
    setState(() {
      _someIsChosen = _materials.any((element) => element.isChecked);
    });
  }

  Future<InspectorMaterialModel?> _pickImage({required ImageSource source}) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      maxWidth: 2800,
      maxHeight: 2800,
    );

    if (pickedFile != null) {
      return InspectorMaterialModel(sourceURL: await pickedFile.path, isAsset: false);
    }
    return null;
  }

  void _showDialog(InspectorMaterialModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) => ChooseDialogComponent(
        materialModel: model,
        sendFunc: (String? comments) {
          _sendFile(model, comments);
        },
        cancelFunc: () {
          _materials.add(model);
          setState(() {});
        },
      ),
      barrierDismissible: false,
    );
  }

  /// Get from gallery
  void _getPhotoFromGallery() async {
    //Navigator.pop(context);
    final InspectorMaterialModel? model = await _pickImage(source: ImageSource.gallery);

    if (model != null) {
      _materials.add(model);
      setState(() {});
    }
  }

  /// Get from camera
  void _getPhotoFromCamera() async {
    print(await _serviceIsEnabled());
    if (await _serviceIsEnabled()) {
      final InspectorMaterialModel? model = await _pickImage(source: ImageSource.camera);

      if (model != null) {
        _showDialog(model);
      }
    } else {
      showDialog(context: context, builder: (_) => AlertDialog(
        title: Text(
          'Для дальнейшей работы необходимо включить геолокацию '
            'и разрешить приложению определять геолокацию',
          style: TextStyle(color: Config.textColor, fontSize: Config.textMediumSize,),
        ),
        actions: <Widget>[
          TextButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: Text('Ok')),
        ],
      ));
    }
  }

  void _getVideoFromCamera() async {
    print(await _serviceIsEnabled());
    if (await _serviceIsEnabled()) {
      final XFile? pickedFile = await _picker.pickVideo(
          source: ImageSource.camera, maxDuration: const Duration(seconds: 60));

      if (pickedFile != null) {
        _showDialog(InspectorMaterialModel(sourceURL: await pickedFile.path,
            isAsset: false, isImage: false));
      }
    } else {
      showDialog(context: context, builder: (_) => AlertDialog(
        title: Text(
          'Для дальнейшей работы необходимо включить геолокацию '
            'и разрешить приложению определять текущую геолокацию',
          style: TextStyle(color: Config.textColor, fontSize: Config.textMediumSize,),
        ),
        actions: <Widget>[
          TextButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: Text('Ok')),
        ],
      ));
    }
  }

  void _showMaterialImage(BuildContext context, InspectorMaterialModel source) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImageDialogActivity(source: source.sourceURL, isAsset: source.isAsset,);
      },
    );
  }

  void _showMaterialVideo(BuildContext context, InspectorMaterialModel source) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return VideoDialogActivity(model: source,);
      },
    );
  }

  Widget _buildInspectorMaterialWidget(InspectorMaterialModel item) {
    return Opacity(
      opacity: item.wasSent ? 0.5 : 1,
      child: ButtonCardWidget(
        150,
        Config.activityBorderRadius,
        Stack(
          children: <Widget>[
            item.isImage
              ? InspectorMaterialImage(model: item)
              : InspectorMaterialVideo(model: item),

            _isActiveChoose && item.wasSent == false
              ? Positioned(
                top: 3,
                right: 3,
                child: CustomCheckbox(
                  checked: item.isChecked,
                  onPressed: (value) {
                    setState(() {
                      item.isChecked = value!;
                    });
                    _updateElements();
                  },
                ),
              )
              : Text(''),
          ],
        ),
        bgColor: Config.activityBackColor,
        onTap: () {
          if (_isActiveChoose == false) {
            item.isImage
              ? _showMaterialImage(context, item)
              : _showMaterialVideo(context, item);
          }
        },
      ),
    );
  }

  void _sendFile(InspectorMaterialModel model, String? comments) async {
    final LocationData locationData = await location.getLocation();
    model.lat = locationData.latitude;
    model.long = locationData.longitude;
    model.comments = comments;

    Api.sendFilesToServer([model]);
    model.wasSent = true;
    _materials.add(model);
    setState(() {});
  }

  void _sendFiles() async {
    final List<InspectorMaterialModel> sendList = [];

    _materials.forEach((element) {
      if (element.isChecked) {
        sendList.add(element);
        if (element.wasSent == false) {
          element.wasSent = true;
          element.isChecked = false;
        }
      }}
    );

    Api.sendFilesToServer(sendList);

    _someIsChosen = _materials.any((element) => element.isChecked);
    setState(() {
      _isActiveChoose = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Config.activityBackColor,

      appBar: AppBar(
        title: Text('Народный инспектор'),
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
                      Config.padding, Config.padding / 1.5,
                      Config.padding, Config.padding * 2.5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Снимите нарушение в',
                          style: TextStyle(color: Config.textColorOnPrimary,
                            fontSize: Config.textMediumSize,),
                        ),
                        Text(
                          'реальном времени или',
                          style: TextStyle(color: Config.textColorOnPrimary,
                            fontSize: Config.textMediumSize,),
                        ),
                        Text(
                          'выберите из галереи',
                          style: TextStyle(color: Config.textColorOnPrimary,
                            fontSize: Config.textMediumSize,),
                        ),
                      ],
                    ),
                  ),
                ],
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
              transform: Matrix4.translationValues(0.0, -(Config.activityBorderRadius * 4), 0.0),
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
                  Config.padding, Config.padding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Онлайн фиксация нарушения',
                      style: TextStyle(fontSize: Config.textLargeSize,
                        color: Config.textTitleColor,),
                    ),

                    SizedBox(height: 20,),

                    GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0,
                          Config.padding / 2
                      ),
                      crossAxisSpacing: Config.padding / 1.5,
                      mainAxisSpacing: Config.padding / 1.5,
                      crossAxisCount: 3,
                      childAspectRatio: width / 410,
                      children: <Widget>[
                        ButtonCard(
                          "Видео нарушение",
                          Image.asset("assets/img/Video Camera-sm.png"),
                          Config.baseInfoColor,
                              () {
                            _getVideoFromCamera();
                          },
                        ),
                        ButtonCard(
                          "Фото нарушение",
                          Image.asset("assets/img/Camera-sm.png"),
                          Config.baseInfoColor,
                              () {
                                _getPhotoFromCamera();
                              },
                        ),
                        ButtonCard(
                          "Добавить из галереи",
                          Image.asset("assets/img/Gallery-sm.png"),
                          Config.baseInfoColor,
                              () {
                                _getPhotoFromGallery();
                              },
                        ),
                      ],
                    ),

                    SizedBox(height: 30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Нарушения',
                          style: TextStyle(fontSize: Config.textLargeSize,
                            color: Config.textTitleColor,),
                        ),

                        Button(
                          'Выбрать',
                          () {
                            setState(() {
                              _isActiveChoose = _isActiveChoose ? false : true;
                            });
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 10,),

                    GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0,
                          Config.padding / 2
                      ),
                      crossAxisSpacing: Config.padding / 1.5,
                      mainAxisSpacing: Config.padding / 1.5,
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      children: _materials.map((item) =>
                          _buildInspectorMaterialWidget(item))
                        .toList(),
                    ),

                    _historyData.length != 0 ? Padding(
                      padding: EdgeInsets.symmetric(vertical: Config.padding),
                      child: Text(
                        'Отправленные',
                        style: TextStyle(fontSize: Config.textLargeSize,
                          color: Config.textTitleColor,),
                      ),
                    ) : Text(''),

                    ..._historyData,
                  ],
                ),
              ),

            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _someIsChosen && _isActiveChoose ? FloatingActionButton.extended(
        shape: RoundedRectangleBorder( // BeveledRectangleBorder for rectangle border, not circle
          borderRadius: BorderRadius.circular(Config.activityBorderRadius),
        ),
        backgroundColor: Config.primaryColor,
        onPressed: () {
          _sendFiles();
        },
        label: Text(
          'Отправить в ГИБДД',
          style: TextStyle(fontSize: Config.textLargeSize,),
        ),
      ) : Text(''),
    );
  }
}
