
import 'package:car_online/activity/services/inspector/cards/ImageDialogActivity.dart';
import 'package:car_online/activity/services/inspector/cards/InspectorMaterialImage.dart';
import 'package:car_online/activity/services/inspector/cards/InspectorMaterialVideo.dart';
import 'package:car_online/activity/services/inspector/cards/VideoDialogActivity.dart';
import 'package:car_online/activity/services/inspector/components/CommentsDialogComponent.dart';
import 'package:car_online/activity/services/inspector/models/InspectorMaterialModel.dart';
import 'package:car_online/widget/ButtonCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';

class ChooseDialogComponent extends StatefulWidget {
  const ChooseDialogComponent({
    Key? key,
    required this.sendFunc,
    required this.cancelFunc,
    required this.materialModel,
  }) : super(key: key);

  final Function cancelFunc;
  final Function(String?) sendFunc;
  final InspectorMaterialModel materialModel;

  @override
  _ChooseDialogComponentState createState() => _ChooseDialogComponentState();
}

class _ChooseDialogComponentState extends State<ChooseDialogComponent> {

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

  Widget _buildInspectorMaterialWidget(InspectorMaterialModel item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Opacity(
          opacity: item.wasSent ? 0.5 : 1,
          child: ButtonCardWidget(
            120,
            Config.activityBorderRadius,
            Stack(
              children: <Widget>[
                item.isImage
                    ? InspectorMaterialImage(model: item)
                    : InspectorMaterialVideo(model: item),
              ],
            ),
            bgColor: Config.activityBackColor,
            onTap: () {
              item.isImage
                  ? _showMaterialImage(context, item)
                  : _showMaterialVideo(context, item);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Config.activityBorderRadius),),
      title: Column(
        children: <Widget>[
          Text('Файл будет сохранен', style: TextStyle(color: Config.textColor, 
              fontSize: Config.textMediumSize), ),

          SizedBox(height: Config.padding / 3,),

          Text('Отправить в ГИБДД?', style: TextStyle(color: Config.textTitleColor),),
        ],
      ),

      content: _buildInspectorMaterialWidget(widget.materialModel),

      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.cancelFunc();
          },
          child: Text('Нет', style: TextStyle(color: Config.errorColor,
              fontSize: Config.textLargeSize),),
        ),

        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            showDialog(context: context, builder: (_) =>
                CommentsDialogComponent(sendFunc: widget.sendFunc,
                  cancelFunc: widget.cancelFunc,));
          },
          child: Text('Да', style: TextStyle(fontSize: Config.textLargeSize),),
        ),
      ],
    );
  }
}

