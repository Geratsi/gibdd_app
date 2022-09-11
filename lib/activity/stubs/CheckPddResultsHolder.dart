import 'package:car_online/activity/profile/check_pdd/domain/model/CheckPddResult.dart';

class CheckPddResultsHolder {

  static List<CheckPddResult> _list = [
    CheckPddResult(3, 10),
    CheckPddResult(1, 10),
    CheckPddResult(2, 10),
  ];

  static void saveCheckPddResult(CheckPddResult result) {
    _list.add(result);
  }

  static List<CheckPddResult> getResults() {
    return _list;
  }
}