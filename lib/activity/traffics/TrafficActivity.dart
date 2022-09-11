
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_online/Storage.dart';
import 'package:car_online/activity/traffics/TrafficDetailActivity.dart';
import 'package:car_online/activity/services/OnlineMapsActivity.dart';
//import 'package:car_online/activity/profile/routes/RouteToCatInfoPage2.dart';
import 'package:car_online/entity/Notif.dart';
import 'package:car_online/entity/News.dart';
import 'package:car_online/entity/Traffic.dart';
import 'package:car_online/widget/Button.dart';
import 'package:car_online/widget/ControlButton.dart';
import 'package:car_online/widget/YandexMapControllerButtons.dart';
//import 'package:car_online/activity/profile/routes/RouteToCarInfoPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';
import 'package:car_online/widget/ButtonCardWidget.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../Api.dart';

class TrafficActivity extends StatefulWidget {

  TrafficActivity({required this.traffic});

  final Traffic traffic;

  @override
  state createState() => state();
}

class state extends State<TrafficActivity> {

  late Traffic traffic;

  bool isMapVisible = true;
  List<MapObject> mapObjects = [];
  YandexMapController? _controller = null;

  @override
  void initState() {
    super.initState();

    traffic = widget.traffic;
  }

  load() async{
    // Api.getTraffic(widget.id).then((value){
    //   setState(() {
    //     traffic = value;
    //   });
    //   if (value!=null){
    final placemark = Placemark(
      mapId: MapObjectId('normal_icon_placemark'),
      point: traffic.point,
      onTap: (Placemark self, Point point){

      },
      opacity: 1,
      direction: 90,
      //isDraggable: true,
      //onDragStart: (_) => print('Drag start'),
      //onDrag: (_, Point point) => print('Drag at point $point'),
      //onDragEnd: (_) => print('Drag end'),
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
        image: BitmapDescriptor.fromAssetImage("assets/img/place.png"),
      )),
    );

    _controller!.moveCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: traffic.point)),
        animation: MapAnimation(type: MapAnimationType.linear, duration: 1.0),
    );


    setState(() {
      mapObjects.add(placemark);
    });
    // });
  }

  Future<void> _onMapCreated(YandexMapController controller) async {
    setState(() {_controller = controller;});
    await _controller!.toggleUserLayer(visible: true);
    load();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        setState(() {
          isMapVisible = false;
        });
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            leading: Row(
              children: <Widget>[
                SizedBox(width: Config.padding * 0.5,),
                IconButton(
                  icon: Image.asset("assets/img/arrow_back.png"),
                  onPressed: () {
                    setState(() {
                      isMapVisible = false;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Трафик', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14)),
                Text(traffic.name),
              ],
            ),
          ),
          backgroundColor: Config.activityBackColor,
          body: Stack(
            children: <Widget>[
              Visibility(
                visible: isMapVisible,
                child: YandexMap(
                  onMapCreated: _onMapCreated,
                  // onMapTap: (Point? point) async {
                  //   print(point);
                  //   if (point != null) {
                  //     final SearchResultWithSession result =  YandexSearch.searchByPoint(
                  //       point: point,
                  //       searchOptions: SearchOptions(
                  //           searchType: SearchType.geo),
                  //     );
                  //     final SearchSessionResult res = await result.result;
                  //
                  //     print(res);
                  //     print(res.found);
                  //     print(res.items);
                  //   }
                  // },
                  mapObjects: mapObjects,
                ),
              ),

              _controller != null
                  ? YandexMapControllerButtons(controller: _controller!)
                  : const SizedBox()
            ],
          )
      ),
    );
  }
}
