
import 'package:car_online/entity/Traffic.dart';
import 'package:flutter/material.dart';

import '../../Config.dart';

class TrafficComponent extends StatefulWidget {
  const TrafficComponent({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Traffic item;

  @override
  State<TrafficComponent> createState() => _TrafficComponentState();
}

class _TrafficComponentState extends State<TrafficComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Config.padding,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Config.activityBorderRadius),
          color: Config.baseInfoColor,
        ),
        padding: EdgeInsets.fromLTRB(Config.padding / 2, Config.padding / 3, 0,
          Config.padding / 3,),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: Config.padding / 2),
              child: Container(
                decoration: BoxDecoration(
                  color: widget.item.pointsColor,
                  borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                ),
                width: 28,
                height: 28,
                child: Center(
                  child: Text(
                    '${widget.item.points}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Config.textMediumSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: Text(
                widget.item.name,
                style: TextStyle(color: Config.textColor,
                    fontSize: Config.textMediumSize,),
                overflow: TextOverflow.visible,
                softWrap: true,
                maxLines: 10,
              ),
              flex: 13,
            ),

            IconButton(
              splashColor: Colors.transparent,
              onPressed: () {
                setState(() {
                  widget.item.isSelected = !widget.item.isSelected;
                });
              },
              icon: Icon(
                Icons.favorite,
                color: widget.item.isSelected
                    ? Config.primaryColor
                    : Colors.black12,
              )),
          ],
        ),
      ),
    );
  }
}