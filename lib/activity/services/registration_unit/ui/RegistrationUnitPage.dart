import 'package:car_online/activity/services/registration_unit/ui/RegistrationUnitBottomSheetBuilder.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../Config.dart';
import '../../../stubs/RegistrationUnitsHolder.dart';
import '../model/RegistrationUnit.dart';

class RegistrationUnitPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _RegistrationUnitPageState();
}

class _RegistrationUnitPageState extends State<RegistrationUnitPage> {

  YandexMapController? _controller;
  var title = "Подразделения";
  late List<MapObject> mapObjects;
  final registrationUnits = RegistrationUnitsHolder.getUnits();


  @override
  void initState() {
    super.initState();
    mapObjects = List.generate(
        registrationUnits.length,
            (index) => _getPlacemark(registrationUnits[index], index)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        shadowColor: Colors.transparent,
        leading: Row(
          children: <Widget>[
            SizedBox(width: Config.padding * 0.5,),
            IconButton(
              icon: Image.asset("assets/img/arrow_back.png"),
              onPressed: onCloseBottomSheetClick
            ),
          ],
        ),
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
        ],
      ),
    );
  }

  Future<void> _onMapCreated() async {
    final Point point = Point(latitude: 55.795095, longitude: 49.220575);

    _controller!.moveCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: point)),
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
  }

  Placemark _getPlacemark(RegistrationUnit registrationUnit, int id) {
    return Placemark(
        mapId: MapObjectId(id.toString()),
        point: registrationUnit.coordinates,
        onTap: (Placemark self, Point point) {
          var bottomSheet = RegistrationUnitBottomSheetBuilder(
              registrationUnit,
              onCloseBottomSheetClick,
              onCallBottomSheetClick
          );
          showModalBottomSheet(
              context: context,
              builder: bottomSheet.getBuilder,
              shape: bottomSheet.shape(),
              isScrollControlled: bottomSheet.isScrollControlled,
            backgroundColor: Config.primaryColor
          );
        },
        opacity: 1,
        direction: 90,
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage("assets/img/place.png"),
        ))
    );
  }

  void onCloseBottomSheetClick() {
    Navigator.pop(context);
  }

  Future<dynamic> onCallBottomSheetClick(String number) async {
    var urlString = ("tel:${number.replaceAll("[^0-9]", "")}");
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      throw 'Could not launch';
    }
  }
}