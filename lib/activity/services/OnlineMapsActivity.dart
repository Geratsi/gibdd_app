import 'dart:async';
import 'dart:typed_data';
import 'package:car_online/widget/Button.dart';
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:car_online/activity/traffics/TrafficDetailActivity.dart';

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}


class OnlineMapsActivity extends StatefulWidget {
  const OnlineMapsActivity({Key? key}) : super(key: key);

  @override
  _OnlineMapsActivityState createState() => _OnlineMapsActivityState();
}

class _OnlineMapsActivityState extends State<OnlineMapsActivity> {
  YandexMapController? _controller;
  List<MapObject> mapObjects = [];
  bool _descVisible = false;

  Future<void> _onMapCreated() async {
    final Point point =  Point(latitude: 55.793712, longitude: 49.171059);

    final placeMark = Placemark(
        mapId: MapObjectId('normal_icon_placemark'),
        point: point,
        onTap: (Placemark self, Point point) {
          setState(() {
            _descVisible = true;
          });

        },
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Онлайн камеры'),
            shadowColor: Colors.transparent,
            centerTitle: true,
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

        body: Stack(
          children: <Widget>[
            YandexMap(
              onMapCreated: (controller) {
                _controller = controller;
                _onMapCreated();
              },
              mapObjects: mapObjects,
            ),

            // GoogleMap(
            //   onMapCreated: _onMapCreated,
            //   zoomControlsEnabled: false,
            //   mapType: MapType.normal,
            //   initialCameraPosition: CameraPosition(
            //     target: LatLng(55.793712, 49.171059),
            //     zoom: 16,
            //   ),
            //   markers: _markers.values.toSet(),
            // ),

            Positioned(
              bottom: Config.padding,
              child: Visibility(
                visible: _descVisible,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Config.padding),
                    child: Container(
                      padding: EdgeInsets.only(left: Config.padding, bottom: Config.padding * 2),
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),)],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Config.activityBorderRadius * 2),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.close),
                                color: Config.textColor,
                                onPressed: () {
                                  setState(() {
                                    _descVisible = false;
                                  });
                                },
                              ),
                            ],
                          ),

                          Text('Пересечение улиц',
                            style: TextStyle(fontSize: 16, color: Config.textColor),),

                          SizedBox(height: 5,),

                          Text('Улица Николая Ершова -', style: TextStyle(fontSize: 18, color: Config.textColor)),
                          Text('Улица Гвардейская, г.Казань', style: TextStyle(fontSize: 18, color: Config.textColor)),
                          SizedBox(height: 20,),
                          Button('Просмотр камеры', (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TrafficDetailActivity(1))
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

