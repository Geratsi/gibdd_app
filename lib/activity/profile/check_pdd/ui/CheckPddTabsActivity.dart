import 'package:car_online/Config.dart';
import 'package:car_online/activity/profile/check_pdd/domain/model/PddTestItem.dart';
import 'package:car_online/activity/profile/check_pdd/ui/CheckPddResultPage.dart';
import 'package:car_online/activity/profile/check_pdd/ui/CheckPddTab.dart';
import 'package:car_online/widget/MainButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../domain/PddTestController.dart';

class CheckPddTabsActivity extends StatefulWidget {
  const CheckPddTabsActivity({
    Key? key,
    required this.testItems,
  }) : super(key: key);

  final List<PddTestItem> testItems;
  @override
  _CheckPddTabsActivityState createState() => _CheckPddTabsActivityState();
}

class _CheckPddTabsActivityState extends State<CheckPddTabsActivity> with TickerProviderStateMixin {
  late TabController _tabController;
  late List<PddTestItem> _testItems;
  late PddTestController _testController;


  void initialize() {
    _testItems = widget.testItems;
    _tabController = TabController(length: _testItems.length, initialIndex: 0, vsync: this);
    _tabController.addListener(() {
      _testController.setCurrentIndex(_tabController.index);
    });
    _testController = PddTestController(_testItems, completeTest);
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CheckPddTabsActivity oldWidget) {
    initialize();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Билет',),
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
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          labelPadding: EdgeInsets.zero,
          indicatorColor: Config.baseInfoColor,
          tabs: List<int>.generate(_testController.size, (index) => index + 1)
              .map((e) =>
              Tab(
                child: Container(
                  color: Colors.transparent,
                  width: 80,
                  height: double.infinity,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Config.padding / 2,
                          horizontal: Config.padding * 1.8),
                      decoration: BoxDecoration(
                        color: !_testController.getPddItemState(e - 1).isPassed()
                            ? Config.activityBackColor
                            : _testController.getPddItemState(e - 1).isCorrect(
                            _testController
                                .getPddItemState(e - 1)
                                .choosenOption)
                            ? Config.successColor
                            : Config.errorColor,
                        borderRadius: BorderRadius.circular(Config
                            .activityBorderRadius),
                      ),
                      child: Text(
                        '$e',
                        style: TextStyle(
                            color: _testController.getPddItemState(e - 1).isPassed() ? Config.textColorOnPrimary : Config.textColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              )).toList(),
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: _testController.items.map((e) =>
            CheckPddTab(
              testItemState: e,
              updateParentState: () {
                setState(() {});
              },
              setAnswer: setAnswer,
            )
        ).toList(),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(Config.padding),
        child: MainButton(
            label: _testController.isCompleted() ? "Завершить" : "Далее",
            onPressed: () {
              onFloatingBtnClick(_testController.isCompleted());
            },
            bgColor: Config.primaryColor,
            labelColor: Config.textColorOnPrimary
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked
    );
  }

  void onFloatingBtnClick(bool isCompleted) {
    if (isCompleted) {
      completeTest();
    } else {
      var nextIndex = _testController.getNextNotPassedIndex();
      if (nextIndex != -1) {
        _tabController.index = nextIndex;
      }
    }
  }

  void setAnswer(PddTestOption option) {
    _testController.answer(option);
  }

  void completeTest() {
    _testController.save();
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckPddResultPage(_testController.getResult())));
  }
}

