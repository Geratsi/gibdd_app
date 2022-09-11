import 'package:car_online/activity/profile/documents/models/UserDocuments.dart';
import 'package:flutter/material.dart';

import '../../../config.dart';

class MyDocumentsActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyDocumentsActivity();
}

class _MyDocumentsActivity extends State<MyDocumentsActivity> {

  final UserDocuments userDocuments = UserDocuments("99 45 245670", "15.11.2018", "234871235234", "licenseQrPath");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.activityBackColor,

      appBar: AppBar(
        title: Text('Мои документы',),
        centerTitle: true,
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
      ),

      body: SingleChildScrollView(
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
                padding: EdgeInsets.only(
                    top: Config.padding * 1.5
                ),

                child: SizedBox(width: MediaQuery.of(context).size.width,),
              ),
            ),

            Container(
              height: (Config.activityBorderRadius * 2) + 1,
              transform: Matrix4.translationValues(
                  0.0, -(Config.activityBorderRadius * 2), 0.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      Config.activityBorderRadius * 2),
                  topRight: Radius.circular(
                      Config.activityBorderRadius * 2),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),
            ),

            Container(
              transform: Matrix4.translationValues(
                  0.0, -(Config.activityBorderRadius * 4)+Config.padding, 0.0
              ),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      Config.activityBorderRadius * 2),
                  topRight: Radius.circular(
                      Config.activityBorderRadius * 2),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),

              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  Config.padding, 0,
                  Config.padding, Config.padding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('ВУ',
                      style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),

                    getLicenseView(userDocuments),

                    SizedBox(height: 10,),

                    getInnView(userDocuments)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getLicenseView(UserDocuments userDocuments) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Номер',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              ),

              SizedBox(height: 5,),

              Text('Дата выдачи',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              ),
            ],
          ),
          flex: 5,
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userDocuments.licenseNumber, style: TextStyle(fontSize: 16)),

              SizedBox(height: 5,),

              Text(userDocuments.licenseDate, style: TextStyle(fontSize: 16)),
            ],
          ),
          flex: 5,
        ),

        Expanded(
          child: Material(
            color: Config.activityBackColor,
            child: InkWell(
              borderRadius: BorderRadius.circular(Config.activityBorderRadius),
              splashColor: Config.primaryLightColor,
              child: Padding(
                padding: EdgeInsets.all(Config.padding / 4),
                child:  Icon(Icons.qr_code_2, size: 50,),
              ),
              onTap: () {
                _showModal(context);
              },
            ),
          ),
          flex: 2,
        ),
      ],
    );
  }

  Widget getInnView(UserDocuments userDocuments) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'ИНН',
              style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Номер',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),

            Text(userDocuments.innNumber, style: TextStyle(fontSize: 16)),
          ],
        ),
      ],
    );
  }

  void _showModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              color: Config.activityBackColor,
              constraints: BoxConstraints(maxHeight: 280),
              child: Image.asset(
                'assets/img/qrCode.png',
                fit: BoxFit.cover,
              ),
            ),
          );
        }
    );
  }
}