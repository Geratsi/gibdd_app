import 'dart:io';

import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';

class ImageDialogActivity extends StatefulWidget {
  const ImageDialogActivity({
    Key? key,
    required this.source,
    required this.isAsset,
  }) : super(key: key);

  final bool isAsset;
  final String source;

  @override
  _ImageDialogActivityState createState() => _ImageDialogActivityState();
}

class _ImageDialogActivityState extends State<ImageDialogActivity> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: InteractiveViewer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                    color: Config.activityBackColor,
                  ),
                  padding: EdgeInsets.all(Config.padding / 4),
                  child: widget.isAsset ? Image.asset(
                    widget.source,
                    // fit: BoxFit.cover,
                  ) : Image.file(File(widget.source)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

