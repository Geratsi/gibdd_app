import 'package:car_online/activity/services/accident/models/AccidentDetails.dart';
import 'package:car_online/activity/services/accident/widgets/AccidentCard.dart';
import 'package:car_online/widget/ButtonCard.dart';
import 'package:car_online/widget/MainButton.dart';
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class TrafficAccidentActivity extends StatefulWidget {
  const TrafficAccidentActivity({Key? key}) : super(key: key);

  @override
  _TrafficAccidentActivityState createState() => _TrafficAccidentActivityState();
}

class _TrafficAccidentActivityState extends State<TrafficAccidentActivity> {
  final ImagePicker _picker = ImagePicker();
  AccidentDetails? accidentDetails;
  YandexMapController? _controller;
  List<MapObject> mapObjects = [];

  /// Get from gallery
  void _getPhotoFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 2800,
      maxHeight: 2800,
    );
  }

  /// Get from camera
  void _getPhotoFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 2800,
      maxHeight: 2800,
    );

  }

  /// Get from camera
  void _getVideoFromCamera() async {
    final XFile? file = await _picker.pickVideo(
        source: ImageSource.camera, maxDuration: const Duration(seconds: 20));
  }

  Future<void> _onMapCreated() async {
    final Point point =  Point(latitude: 55.793712, longitude: 49.171059);

    final placeMark = Placemark(
        mapId: MapObjectId('normal_icon_placemark'),
        point: point,
        onTap: (Placemark self, Point point) => print('Tapped me at $point'),
        opacity: 1,
        direction: 90,
        //isDraggable: true,
        //onDragStart: (_) => print('Drag start'),
        //onDrag: (_, Point point) => print('Drag at point $point'),
        //onDragEnd: (_) => print('Drag end'),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage("assets/img/place.png"),
        ))
    );

    _controller!.moveCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: point)),
      //animation: MapAnimation(type: MapAnimationType.smooth, duration: 1.0)
    );
    _controller?.setMapStyle("[" +
        "  {" +
        "    \"featureType\" : \"all\"," +
        "    \"stylers\" : {" +
        "      \"hue\" : \"1\"," +
        "      \"saturation\" : \"0.3\"," +
        "      \"lightness\" : \"-0.7\"" +
        "    }" +
        "  }" +
        "]");


    setState(() {
      mapObjects.add(placeMark);
    });
  }

  void onClickSendBtn() {
    setState(() {
      accidentDetails = AccidentDetails('Принята', 103, "пр.Победы, 194");
    });
  }

  @override
  Widget build(BuildContext context) {
    final _windowWidth = MediaQuery.of(context).size;
    final _itemWidth = _windowWidth.width - Config.padding * 2;
    final DateTime currentDate = DateTime.now().toLocal();

    return Scaffold(
      backgroundColor: Config.activityBackColor,

      appBar: AppBar(
        title: Text('Оформить ДТП'),
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
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Config.padding, Config.padding,
                        Config.padding, Config.padding * 2.5,
                    ),
                    child: Text('Данный сервис позволяет\nоформить ДТП',
                      style: TextStyle(color: Config.textColorOnPrimary,
                        fontSize: Config.textMediumSize,),
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
                  Config.padding, Config.padding / 2,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                      childAspectRatio: 0.94,
                      children: <Widget>[
                        ButtonCard(
                          "Сделать \nвидео",
                          Image.asset("assets/img/Video Camera-sm.png"),
                          Config.baseInfoColor,
                              () {
                            _getVideoFromCamera();
                          },
                        ),
                        ButtonCard(
                          "Сделать \nфото",
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

                    SizedBox(height: Config.padding,),

                    Padding(
                      padding: EdgeInsets.all(Config.padding / 3,),
                      child: Text('Геолокация',
                        style: TextStyle(fontSize: Config.textLargeSize,
                          color: Config.textTitleColor),
                      ),
                    ),

                    SizedBox(
                      width: _itemWidth,
                      height: 150,
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(Config.activityBorderRadius),

                            child: YandexMap(
                              onMapCreated: (controller){
                                _controller = controller;
                                _onMapCreated();
                              },
                              mapObjects: mapObjects,
                            ),
                          ),

                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: InkWell(
                                child: Image.asset('assets/img/geoposition.png'),
                              ),
                            ),
                          ),
                        ],
                      )
                    ),

                    SizedBox(height: Config.padding,),

                    Padding(
                      padding: EdgeInsets.all(Config.padding / 3,),
                      child: Text('Дата и время',
                        style: TextStyle(fontSize: Config.textLargeSize,
                          color: Config.textTitleColor),),
                    ),

                    Container(
                      width: _itemWidth,
                      decoration: BoxDecoration(
                        color: Config.baseInfoColor,
                        borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                      ),
                      padding: EdgeInsets.all(Config.padding * 1.1),
                      child: Text('${currentDate.day - 1}.0${currentDate.month}.${currentDate.year}, 18:36',
                        style: TextStyle(fontSize: Config.textMediumSize,
                            color: Config.textColor),),
                    ),

                    SizedBox(height: Config.padding,),

                    MainButton(
                      label: 'Отправить',
                      onPressed: () {onClickSendBtn();},
                      bgColor: Config.primaryColor,
                      labelColor: Config.textColorOnPrimary,
                    ),

                    SizedBox(height: Config.padding,),

                    accidentDetails != null
                        ? AccidentCard(accidentDetails!, () {}, () {})
                        : SizedBox.shrink(),
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
