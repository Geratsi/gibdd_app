
import 'package:car_online/Api.dart';
import 'package:car_online/entity/Traffic.dart';
import 'package:car_online/widget/YandexMapControllerButtons.dart';
import 'package:flutter/material.dart';
import 'package:car_online/widget/CustomSearchDelegate.dart';
import 'package:location/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:car_online/widget/CustomSearchBar.dart';
import 'package:car_online/activity/traffics/FavouriteTrafficsActivity.dart';

import '../../Config.dart';

class TrafficsActivity extends StatefulWidget {
  @override
  _TrafficsActivityState createState() => _TrafficsActivityState();
}

class _TrafficsActivityState extends State<TrafficsActivity> {
  final Location location = Location();

  late Point _defaultPoint;
  late bool _serviceEnabled;
  late List<Traffic> traffics = [];
  late PermissionStatus _permissionGranted;

  List<MapObject> mapObjects = [];
  YandexMapController? _controller = null;

  @override
  void initState() {
    Api.getTraffics().then((value) {
      traffics = value;
    });

    _defaultPoint = Config.pointKazan;

    _serviceIsEnabled().then((value) async {
      if (value) {
        final LocationData locationData = await location.getLocation();
        _moveToCurrentPosition(Point(
          latitude: locationData.latitude ?? _defaultPoint.latitude,
          longitude: locationData.longitude ?? _defaultPoint.longitude,
        ));
      } else {
        _moveToCurrentPosition(_defaultPoint, zoom: 10);
      }
    });

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

  void _moveToCurrentPosition(Point point, {double zoom=15}) {
    // final placemark = Placemark(
    //   mapId: MapObjectId('normal_icon_placemark'),
    //   point: point,
    //   onTap: (Placemark self, Point point){
    //
    //   },
    //   opacity: 1,
    //   direction: 90,
    //   icon: PlacemarkIcon.single(PlacemarkIconStyle(
    //     image: BitmapDescriptor.fromAssetImage("assets/img/place.png"),
    //   )),
    // );

    _controller!.moveCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: point, zoom: zoom)),
        animation: MapAnimation(type: MapAnimationType.linear, duration: 1.0)
    );

    // setState(() {
    //   mapObjects.add(placemark);
    // });
  }

  Future<bool> _onMapCreated(YandexMapController controller) async {
    setState(() {_controller = controller;});
    _moveToCurrentPosition(_defaultPoint, zoom: 10); // Kazan
    await _controller!.toggleUserLayer(visible: true);
    final LocationData locationData = await location.getLocation();
    _moveToCurrentPosition(Point(
      latitude: locationData.latitude ?? _defaultPoint.latitude,
      longitude: locationData.longitude ?? _defaultPoint.longitude,
    ));

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Трафик'),
        leading: Row(
          children: <Widget>[
            SizedBox(
              width: Config.padding * 0.5,
            ),
            IconButton(
              icon: Image.asset("assets/img/arrow_back.png"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () async {
              final LocationData locationData = await location.getLocation();

              customShowSearch(
                context: context,
                delegate: CustomSearchBar(
                  latitude: locationData.latitude ?? _defaultPoint.latitude,
                  longitude: locationData.longitude ?? _defaultPoint.longitude,
                  traffics: traffics,
                  updateParentState: () {
                    setState(() {});
                  }
                ),
              );
            },
            icon: Icon(Icons.search),
          )
        ],
        shadowColor: Colors.transparent,
      ),

      body: Stack(
        children: <Widget>[
          YandexMap(
            mapObjects: mapObjects,
            onMapCreated: _onMapCreated,
            tiltGesturesEnabled: false,
          ),

          _controller != null
              ? YandexMapControllerButtons(controller: _controller!)
              : const SizedBox(),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          // BeveledRectangleBorder for rectangle border, not circle
          borderRadius: BorderRadius.circular(Config.activityBorderRadius),
        ),
        backgroundColor: Config.primaryColor,
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => FavouriteTrafficsActivity(
                traffics: traffics,
              ),
            ),
          );
        },
        label: Text(
          'Избранное',
          style: TextStyle(
            fontSize: Config.textLargeSize,
          ),
        ),
      ),
    );
  }
}
