import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_online/Storage.dart';
//import 'package:car_online/activity/profile/routes/RouteToCatInfoPage2.dart';
import 'package:car_online/entity/Notif.dart';
import 'package:car_online/entity/News.dart';
import 'package:car_online/widget/Button.dart';
import 'package:car_online/widget/InputText.dart';
//import 'package:car_online/activity/profile/routes/RouteToCarInfoPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';
import 'package:car_online/widget/ButtonCardWidget.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../Api.dart';
import '../entity/Comment.dart';

class CommentsActivity extends StatefulWidget {

  String name;
  int commentsBlockId;

  CommentsActivity(this.name, this.commentsBlockId);

  @override
  state createState() => state();
}

class state extends State<CommentsActivity> {

  Comment? commentReply;
  TextEditingController commentTextController = TextEditingController();
  List<Comment> comments = [];

  @override
  initState() {
    super.initState();
    comments.add(Comment(1, 'Иван Иванов', '10.01.2022 в 18:00', 'Интересная новость. Надеюсь все будет хорошо', 87, [
      //Comment(2, 'Александр', '12.01.2022 в 18:15', 'Интересная новость. Надеюсь все будет хорошо', 1, []),
      //Comment(3, 'Руслан', '12.01.2022 в 18:18', 'Интересная новость. Надеюсь все будет хорошо', 3, []),
    ]));
    comments.add(Comment(4, 'Игорь Кузин', '13.01.2022 в 10:00', 'Интересная новость. Надеюсь все будет хорошо', 5, []));
    comments.add(Comment(5, 'Алия Ренатовна', '15.01.2022 в 14:35', 'Интересная новость. Надеюсь все будет хорошо', 120, []));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        leading: Row(
          children: <Widget>[
            SizedBox(width: Config.padding * 0.5,),
            IconButton(
              icon: Image.asset("assets/img/arrow_back.png"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.name, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14)),
            Text('Комментарии'),
          ],
        ),
      ),
      backgroundColor: Config.activityBackColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(Config.padding, Config.padding, Config.padding, Config.padding/2),
                          child: Text('${comments.length} комментариев', style: TextStyle(color: Config.primaryColor, fontSize: 18, fontWeight: FontWeight.w600))
                      ),
                      for(var i=0;i<comments.length;i++)
                        Container(
                          padding: EdgeInsets.fromLTRB(Config.padding, Config.padding/2, 0, Config.padding),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, Config.padding, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(comments[i].userName, style: TextStyle(color: Config.primaryColor, fontSize: 16, fontWeight: FontWeight.w600)),
                                        SizedBox(width: Config.padding/4),
                                        Text(comments[i].date, style: TextStyle(color: Config.primaryColor, fontSize: 14, fontWeight: FontWeight.w600))
                                      ],
                                    ),
                                    SizedBox(height: Config.padding/2),
                                    Text(comments[i].text, style: TextStyle(color: Config.textColor, fontSize: 16)),
                                    SizedBox(height: Config.padding/1.5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Button(
                                          'Ответить ${comments[i].comments.length>0 ? '(${comments[i].comments.length})' : ''}',
                                          (){
                                            setState(() {
                                              commentReply = comments[i];
                                              commentTextController.text = '';
                                            });
                                          },
                                          iconData: MdiIcons.reply,
                                          color:Config.primaryColor,
                                          size: 14,
                                          iconSize: 14,
                                          padding: EdgeInsets.fromLTRB(Config.padding/1.5, Config.padding/2, Config.padding/1.5, Config.padding/2),
                                        ),
                                        Button(
                                          '${comments[i].likes>0 ? comments[i].likes: ''}',
                                              (){
                                            setState(() {
                                              comments[i].likes++;
                                            });
                                          },
                                          iconData: MdiIcons.thumbUp,
                                          color:Config.primaryColor,
                                          size: 14,
                                          iconSize: 14,
                                          padding: EdgeInsets.fromLTRB(Config.padding/1.5, Config.padding/2, Config.padding/1.5, Config.padding/2),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: comments[i].comments.length>0 ? Config.padding : 0),
                              for(var i1=0;i1<comments[i].comments.length;i1++)
                                Container(
                                  padding: EdgeInsets.fromLTRB(Config.padding, Config.padding/2, Config.padding, Config.padding),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(comments[i].comments[i1].userName, style: TextStyle(color: Config.primaryColor, fontSize: 16, fontWeight: FontWeight.w600)),
                                          SizedBox(width: Config.padding/4),
                                          Text(comments[i].comments[i1].date, style: TextStyle(color: Config.primaryColor, fontSize: 14, fontWeight: FontWeight.w600))
                                        ],
                                      ),
                                      SizedBox(height: Config.padding/2),
                                      Text(comments[i].comments[i1].text, style: TextStyle(color: Config.textColor, fontSize: 16)),
                                      SizedBox(height: Config.padding/1.5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Button(
                                            'Ответить',
                                            (){
                                              setState(() {
                                                commentReply = comments[i].comments[i1];
                                                commentTextController.text = '';
                                              });
                                            },
                                            iconData: MdiIcons.reply,
                                            color:Config.primaryColor,
                                            size: 14,
                                            iconSize: 14,
                                            padding: EdgeInsets.fromLTRB(Config.padding/1.5, Config.padding/2, Config.padding/1.5, Config.padding/2),
                                          ),
                                          Button(
                                            '${comments[i].comments[i1].likes>0 ? comments[i].comments[i1].likes : ''}',
                                                (){
                                              setState(() {
                                                comments[i].comments[i1].likes++;
                                              });
                                            },
                                            iconData: MdiIcons.thumbUp,
                                            color:Config.primaryColor,
                                            size: 14,
                                            iconSize: 14,
                                            padding: EdgeInsets.fromLTRB(Config.padding/1.5, Config.padding/2, Config.padding/1.5, Config.padding/2),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),

                    ],
                  )
              ),
            )
          ),
          Visibility(
            visible: true,
            child:Container(
              color: Config.primaryColor,
              padding: EdgeInsets.fromLTRB(Config.padding,Config.padding,Config.padding,Config.padding),
              child: Column(
                children: [
                  Visibility(
                      visible: commentReply!=null,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Ответ \'${commentReply?.userName}\'', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                              Button(
                                'Отменить ответ',
                                    (){
                                  setState(() {
                                    commentReply = null;
                                    commentTextController.text = '';
                                  });
                                },
                                iconData: MdiIcons.close,
                                color:Colors.white,
                                backgroundColor: Config.primaryColor,
                                size: 14,
                                iconSize: 14,
                                padding: EdgeInsets.fromLTRB(Config.padding/1.5, Config.padding/2, Config.padding/1.5, Config.padding/2),
                              ),
                            ],
                          ),
                          SizedBox(height: Config.padding/2),
                        ],
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: InputText(
                            'Введите комментарий',
                            TextInputType.text,
                            commentTextController,
                            margin: EdgeInsets.all(0),
                            color: Colors.white,
                          )
                      ),
                      SizedBox(width: Config.padding/2),
                      ElevatedButton(
                        onPressed: () {
                          if (commentReply!=null){
                            setState(() {
                              commentReply!.comments.insert(0, Comment(3, 'Михаил Палий', '14.02.2022 в 15:10', commentTextController.text, 0, []));
                            });
                          } else {
                            setState(() {
                              comments.insert(0, Comment(3, 'Михаил Палий', '14.02.2022 в 15:10', commentTextController.text, 0, []));
                            });
                          }
                          setState(() {
                            commentTextController.text = '';
                            commentReply = null;
                          });
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: Icon(MdiIcons.send, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(Config.padding*3, Config.padding*3),
                            padding: EdgeInsets.zero,
                            shape: CircleBorder(),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shadowColor: Colors.transparent
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }
}

