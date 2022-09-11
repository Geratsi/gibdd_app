import 'dart:developer';
import 'dart:math' as Math;

import 'package:car_online/activity/traffics/TrafficComponent.dart';
import 'package:car_online/entity/Traffic.dart';
import 'package:car_online/widget/CustomSearchDelegate.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../Config.dart';

class CustomSearchBar extends CustomSearchDelegate {
  CustomSearchBar({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.traffics,
    required this.updateParentState,
  }) : super(
    searchFieldDecorationTheme: InputDecorationTheme(),
  );

  final double latitude;
  final double longitude;
  final List<Traffic> traffics;
  final Function updateParentState;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Config.padding * 0.5),
      child: IconButton(
        icon: Image.asset("assets/img/arrow_back.png", width: 30,),
        onPressed: () {
          updateParentState();
          close(context, null);
        },
      ),
    );
  }

  // double _computeDelta(degrees) {
  //   const EART_RADIUS = 6371210; // Радиус земли
  //   return Math.pi / 180 * EART_RADIUS * Math.cos(deg2rad(degrees));
  // }
  //
  // double deg2rad(degrees) {
  //   return degrees * Math.pi / 180;
  // }

  Future<List<SearchItem>> _searchResult(String query) async {
    // final double deltaLat = 5000 / _computeDelta(latitude);
    // final double deltaLong = 5000 / _computeDelta(longitude);
    // final Point point1 = Point(latitude: latitude - deltaLat, longitude: longitude + deltaLong);
    // final Point point2 = Point(latitude: latitude + deltaLat, longitude: longitude - deltaLong);

    final SearchResultWithSession searchRes = YandexSearch.searchByText(
      searchText: query,
      // geometry: Geometry.fromBoundingBox(
      //   BoundingBox(
      //     northEast: Point(latitude: latitude - deltaLat, longitude: longitude + deltaLong),
      //     southWest: Point(latitude: latitude + deltaLat, longitude: longitude - longitude),
      //   ),
      // ),
      geometry: Geometry.fromPoint(Point(latitude: latitude, longitude: longitude)),
      searchOptions: SearchOptions(geometry: true),
    );

    try {
      final SearchSessionResult res = await searchRes.result;
      final List<SearchItem>? _res = res.items;
      if (_res != null) {
        return _res;
      }
    } catch (e) {
      print('CustomSearchBar: _searchResult: Error: $e');
    }

    return [];
  }

  List<Widget> _buildComponents(List<SearchItem> searchItems) {
    List<Widget> result = [];
    int id = 100;

    for (var item in searchItems) {
      final Point? _point = item.geometry[0].point;
      print(_point);
      final SearchItemToponymMetadata? metadata = item.toponymMetadata;
      print(metadata);
      if (metadata != null && _point != null) {
        final Object? address = metadata.address.props[0];
        if (address != null && address.runtimeType == String) {
          final Traffic item = Traffic(
            id: id++,
            points: 1,
            point: _point,
            name: address.toString(),
          );

          result.add(TrafficComponent(item: item));
          traffics.add(item);
        }
      }
    }

    return result;
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return query.isEmpty
        ? Center()
        : FutureBuilder<List<SearchItem>>(
            future: _searchResult(query),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(Config.padding),
                    child: Column(
                      children: _buildComponents(snapshot.data!),
                    ),
                  ),
                );
              }
            },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Traffic> matchQuery = [];
    for (final Traffic item in []) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(Config.padding),
        child: Column(
          children: <Widget>[
            ...matchQuery.map(
                  (item) => TrafficComponent(item: item,),
            ),
          ],
        ),
      ),
    );
  }
}

