
import 'dart:io';

import 'package:car_online/activity/services/inspector/models/InspectorMaterialModel.dart';
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';

class InspectorMaterialImage extends StatefulWidget {
  const InspectorMaterialImage({
    Key? key,
    required this.model,
  }) : super(key: key);

  final InspectorMaterialModel model;

  @override
  _InspectorMaterialImageState createState() => _InspectorMaterialImageState();
}

class _InspectorMaterialImageState extends State<InspectorMaterialImage> {
  //
  // get getMaterialModel {
  //   return widget.materialModel;
  // }

  InspectorMaterialModel getMaterialModel() {
    return widget.model;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Config.activityBorderRadius / 2),
      child: widget.model.isAsset
        ? Image.asset(
          widget.model.sourceURL,
          width: 110 + Config.padding / 2,
          height: 110 + Config.padding / 2,
          fit: BoxFit.cover,
        )
        : Image.file(
            File(widget.model.sourceURL),
            width: 110 + Config.padding / 2,
            height: 110 + Config.padding / 2,
            fit: BoxFit.cover,
          ),
    );
  }
}

