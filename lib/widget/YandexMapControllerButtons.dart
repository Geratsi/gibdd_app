
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../Config.dart';

class YandexMapControllerButtons extends StatelessWidget {
  const YandexMapControllerButtons({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final YandexMapController controller;

  Future<void> _zoomIn() async {
    await controller.moveCamera(CameraUpdate.zoomIn(),
        animation: MapAnimation(type: MapAnimationType.linear, duration: 1.0));
  }

  Future<void> _zoomOut() async {
    await controller.moveCamera(CameraUpdate.zoomOut(),
        animation: MapAnimation(type: MapAnimationType.linear, duration: 1.0));
  }

  @override
  Widget build(BuildContext context) {
    final Location location = Location();
    final Point defaultPoint = Config.pointKazan;

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: Config.primaryColor,
                onPressed: _zoomIn,
                child: Icon(
                  Icons.add,
                ),
              ),
            ],
          ),

          SizedBox(height: Config.padding,),

          FloatingActionButton(
            backgroundColor: Config.primaryColor,
            onPressed: _zoomOut,
            child: Icon(Icons.remove),
          ),

          SizedBox(height: Config.padding,),

          FloatingActionButton(
              backgroundColor: Config.primaryColor,
              onPressed: () async {
                final LocationData locationData = await location.getLocation();

                controller.moveCamera(
                  CameraUpdate.newCameraPosition(CameraPosition(
                    zoom: 17,
                    target: Point(
                      latitude: locationData.latitude ?? defaultPoint.latitude,
                      longitude: locationData.longitude ?? defaultPoint.longitude,
                    ),),
                  ),
                  animation: MapAnimation(type: MapAnimationType.linear, duration: 1.0),
                );
              },
              child: Transform.rotate(
                angle: 0.8,
                child: Icon(
                  Icons.navigation,
                ),
              )
          ),
        ],
      ),
    );
  }
}
