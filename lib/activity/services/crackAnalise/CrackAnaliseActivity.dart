
import 'package:car_online/Api.dart';
import 'package:car_online/activity/services/crackAnalise/CrackAnaliseComponent.dart';
import 'package:flutter/material.dart';
import 'package:car_online/Config.dart';

class CrackAnaliseActivity extends StatefulWidget {
  const CrackAnaliseActivity({Key? key}) : super(key: key);

  @override
  _CrackAnaliseActivityState createState() => _CrackAnaliseActivityState();
}

class _CrackAnaliseActivityState extends State<CrackAnaliseActivity> {
  late List<List<String>> _videos;

  @override
  void initState() {
    super.initState();

    //API
    _videos = [
      ['_Fwzzgh7t2M', 'Дтп 30 10 2012 короткое'],
      ['BPVY8pX__R8', 'Дтп короткое'],
      ['-GdCD0Srd5A', 'Момент ДТП с Chevrolet Corvette попал на камеру видеонаблюдения'],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Разбор ДТП'),
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
          )
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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

            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Config.activityBorderRadius * 1.5),
                  topRight: Radius.circular(Config.activityBorderRadius * 1.5),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),

              child: SizedBox(
                height: MediaQuery.of(context).size.height - 120, // 80 - AppBar height
                child: ListView.separated(
                  itemCount: _videos.length,
                  itemBuilder: (BuildContext context, int index) => CrackAnaliseComponent(
                    videoHash: _videos[index][0], comments: _videos[index][1],
                  ),
                  separatorBuilder: (BuildContext context, int index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: Config.padding),
                    child: Divider(height: 1, thickness: 1, color: Config.activityHintColor,),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

