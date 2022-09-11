import 'package:car_online/activity/MainActivity.dart';
import 'package:car_online/activity/profile/ProfileActivity.dart';
import 'package:car_online/Config.dart';
import 'package:car_online/widget/MenuBottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppActivity extends StatefulWidget {
  @override
  state createState() => state();
}

class state extends State<AppActivity> with TickerProviderStateMixin {
  int mainTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Config.activityBackColor,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Visibility(
              visible: mainTabIndex==0,
              child: MainActivity()
            ),
            Visibility(
                visible: mainTabIndex==1,
                child: ProfileActivity()
            ),
          ],
        ),

        bottomNavigationBar: Container(
          height: 68,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MenuBottom(
                "Главная",
                Icon(Icons.home_rounded, color: mainTabIndex==0 ? Config.primaryColor : Colors.grey.shade600),
                mainTabIndex==0 ? Config.primaryColor : Colors.grey.shade600,
                (){
                  setState(() {
                    mainTabIndex = 0;
                  });
                }
              ),
              /*
              MenuBottom(
                "Новости",
                Icon(MdiIcons.newspaperVariant, color: mainTabIndex==1 ? Config.primaryColor : Colors.grey.shade600),
                mainTabIndex==1 ? Config.primaryColor : Colors.grey.shade600,
                (){
                  setState(() {
                    mainTabIndex = 1;
                  });
                }
              ),
               */
              MenuBottom(
                "Профиль",
                  Icon(MdiIcons.accountCircle, color: mainTabIndex==1 ? Config.primaryColor : Colors.grey.shade600),
                mainTabIndex==1 ? Config.primaryColor : Colors.grey.shade600,
                (){
                  setState(() {
                    mainTabIndex = 1;
                  });
                }
              )
            ],
          )
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}

class Tab{
  String name;
  Widget icon;
  StatefulWidget content;
  Tab(this.name, this.icon, this.content);
}

