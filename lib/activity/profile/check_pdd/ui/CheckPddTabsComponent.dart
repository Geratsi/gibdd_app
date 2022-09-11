import 'package:car_online/Api.dart';
import 'package:car_online/activity/profile/check_pdd/ui/CheckPddTabsActivity.dart';
import 'package:car_online/activity/profile/check_pdd/domain/model/PddTestItem.dart';
import 'package:flutter/material.dart';

class CheckPddTabsComponent extends StatefulWidget {
  const CheckPddTabsComponent({Key? key}) : super(key: key);

  @override
  _CheckPddTabsComponentState createState() => _CheckPddTabsComponentState();
}

class _CheckPddTabsComponentState extends State<CheckPddTabsComponent> {
  late List<PddTestItem> _testItems;

  Future<void> _getTestItems() async {
   _testItems = await Api.getPddTestItems();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getTestItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator.adaptive(),);
        }
        else if (snapshot.hasError) {
          return Center(child: Text(snapshot.data.toString()),);
        }
        else {
          return CheckPddTabsActivity(testItems: _testItems,);
        }
      },
    );
  }
}

