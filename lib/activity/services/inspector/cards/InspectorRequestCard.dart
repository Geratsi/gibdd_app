import 'package:car_online/activity/services/inspector/cards/ImageDialogActivity.dart';
import 'package:car_online/activity/services/inspector/cards/InspectorMaterialImage.dart';
import 'package:car_online/activity/services/inspector/cards/InspectorMaterialVideo.dart';
import 'package:car_online/activity/services/inspector/cards/VideoDialogActivity.dart';
import 'package:car_online/activity/services/inspector/models/InspectorMaterialModel.dart';
import 'package:car_online/activity/services/inspector/models/InspectorRequestModel.dart';
import 'package:car_online/widget/ButtonCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';

class InspectorRequestCard extends StatefulWidget {
  const InspectorRequestCard({
    Key? key,
    required this.requestModel,
    required this.materialItems,
  }) : super(key: key);

  final InspectorRequestModel requestModel;
  final List<InspectorMaterialModel> materialItems;

  @override
  _InspectorRequestCardState createState() => _InspectorRequestCardState();
}

class _InspectorRequestCardState extends State<InspectorRequestCard> {
  final Map<String, Color> statusColors = {
    'В работе': Config.primaryDarkColor,
    'Принята': Config.textTitleColor,
    'Закрыта': Config.successColor,
  };

  void _showMaterialImage(BuildContext context, InspectorMaterialModel source) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImageDialogActivity(source: source.sourceURL, isAsset: source.isAsset,);
      },
    );
  }

  void _showMaterialVideo(BuildContext context, InspectorMaterialModel source) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return VideoDialogActivity(model: source,);
      },
    );
  }

  Widget _getMaterialsCardButton(InspectorMaterialModel item) {
    return Padding(
      padding: EdgeInsets.only(right: Config.padding / 4),
      child: ButtonCardWidget(
        90,
        Config.activityBorderRadius,
        item.isImage
            ? InspectorMaterialImage(model: item)
            : InspectorMaterialVideo(model: item),
        bgColor: Config.activityBackColor,
        onTap: () {
          item.isImage
              ? _showMaterialImage(context, item)
              : _showMaterialVideo(context, item);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final InspectorRequestModel _requestModel = widget.requestModel;

    return Padding(
      padding: EdgeInsets.only(bottom: Config.padding),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: Config.padding / 2, horizontal: Config.padding / 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Config.activityBorderRadius),
          color: Config.baseInfoColor,
        ),
        child: Column(
          children: <Widget>[
            RichText(
              text: TextSpan(
                  style: TextStyle(fontSize: Config.textMediumSize,
                      color: Config.textColor),
                  children: <TextSpan>[
                    TextSpan(text: 'Заявка № '),
                    TextSpan(text: _requestModel.number,
                        style: TextStyle(color: Config.textTitleColor)),
                  ]
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: Config.padding / 4,
                  horizontal: Config.padding / 2),
              child: Row(
                children: <Widget>[
                  Text(_requestModel.title,
                    style: TextStyle(fontSize: Config.textMediumSize,
                        color: Config.textColor),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: Config.padding / 4,
                  horizontal: Config.padding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Статус заявки',
                    style: TextStyle(fontSize: Config.textMediumSize,
                        color: Config.textColor),
                  ),

                  Text(_requestModel.status,
                    style: TextStyle(fontSize: Config.textMediumSize,
                        color: statusColors[_requestModel.status]),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: Config.padding / 4,
                  horizontal: Config.padding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Начислено баллов',
                    style: TextStyle(fontSize: Config.textMediumSize,
                        color: Config.textColor),
                  ),

                  Text(_requestModel.bonus,
                    style: TextStyle(fontSize: Config.textMediumSize,
                        color: Config.successColor),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: Config.padding / 4),
              child: Divider(height: 1,),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: Config.padding / 4,
                  horizontal: Config.padding / 2),
              child: Row(
                children: <Widget>[
                  Text('Отправленные материалы',
                    style: TextStyle(fontSize: Config.textMediumSize,
                        color: Config.textColor),
                  ),
                ],
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.materialItems.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return _getMaterialsCardButton(widget.materialItems[index]);
                    },
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

