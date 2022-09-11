import 'package:car_online/Api.dart';
import 'package:car_online/Config.dart';
import 'package:car_online/entity/ProfileMenuItem.dart';
import 'package:car_online/widget/ButtonCard.dart';
import 'package:car_online/widget/MainButton.dart';
import 'package:flutter/material.dart';

class ProfileActivity extends StatefulWidget {
  const ProfileActivity({Key? key}) : super(key: key);

  @override
  _ProfileActivityState createState() => _ProfileActivityState();
}

class _ProfileActivityState extends State<ProfileActivity> {
  late List<ProfileMenuItem> _activities;

  @override
  void initState() {
    _activities = Api.getProfileMenuButtons();

    super.initState();
  }

  Widget _getRectButton(String label, Function onPressed, Widget source) {
    return ButtonCard(
      label,
      source,
      Config.baseInfoColor,
      onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Config.activityBackColor,
        body: Container(
            color: Config.primaryColor,
            child: SafeArea(
                child: Container(
                    color: Config.activityBackColor,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Config.primaryColor,
                                  Config.primaryDarkColor,
                                  //Color.fromARGB(255, 69,96,181),
                                ],
                              ),
                            ),

                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                Config.padding, Config.padding,
                                Config.padding, Config.padding * 3,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                                        ),
                                        child: Stack(
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                                              child: Image.asset("assets/img/user_photo.png"),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(width: 50,),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                              'Палий Михаил',
                                              style: TextStyle(fontSize: 20, color: Colors.white,
                                                  fontWeight: FontWeight.w600)
                                          ),

                                          Text(
                                              'Евгеньевич',
                                              style: TextStyle(fontSize: 20, color: Colors.white,
                                                  fontWeight: FontWeight.w600)
                                          ),

                                          SizedBox(height: 10,),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Рейтинг',
                                                    style: TextStyle(fontSize: 20, color: Colors.white,
                                                        fontWeight: FontWeight.w600),
                                                  ),

                                                  SizedBox(height: 10,),

                                                  Text(
                                                    'Баллы',
                                                    style: TextStyle(fontSize: 20, color: Colors.white,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(width: 20,),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      '87',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.green,
                                                          fontWeight: FontWeight.w600),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                                                      color: Config.activityBackColor,
                                                    ),
                                                    padding: EdgeInsets.symmetric(horizontal: Config.padding / 4,
                                                        vertical: Config.padding / 5),
                                                  ),

                                                  SizedBox(height: 5,),

                                                  Container(
                                                    child: Text(
                                                      '100',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.green,
                                                          fontWeight: FontWeight.w600),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(Config.activityBorderRadius),
                                                      color: Config.activityBackColor,
                                                    ),
                                                    padding: EdgeInsets.symmetric(horizontal: Config.padding / 4,
                                                        vertical: Config.padding / 5),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            transform: Matrix4.translationValues(
                                0.0, -(Config.activityBorderRadius * 3)+Config.padding, 0.0
                            ),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      Config.activityBorderRadius * 2),
                                  topRight: Radius.circular(
                                      Config.activityBorderRadius * 2),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero
                              ),
                            ),

                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                Config.padding, Config.padding,
                                Config.padding, Config.padding,
                              ),

                              child: Column(
                                children: <Widget>[
                                  GridView.count(
                                    shrinkWrap: true,
                                    primary: false,
                                    crossAxisSpacing: Config.padding / 1.5,
                                    mainAxisSpacing: Config.padding / 1.5,
                                    crossAxisCount: 3,
                                    childAspectRatio: MediaQuery.of(context).size.width/410,
                                    children: [
                                      ..._activities.map((item) => _getRectButton(item.itemLabel, () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => item.itemWidget),
                                        );
                                      }, item.itemImageSource)).toList(),
                                    ],
                                  ),

                                  SizedBox(height: 40,),

                                  MainButton(
                                    label: 'Выйти',
                                    onPressed: () {},
                                    labelColor: Config.primaryColor,
                                    bgColor: Config.secondaryButtonColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                )
            )
        )
    );
  }
}
