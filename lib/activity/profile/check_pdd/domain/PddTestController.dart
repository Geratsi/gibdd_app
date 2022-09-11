import 'package:car_online/activity/profile/check_pdd/domain/model/CheckPddResult.dart';
import 'package:car_online/activity/stubs/CheckPddResultsHolder.dart';

import 'model/PddTestItem.dart';

class PddTestController {

  Function() onCompleteCallback;
  late List<PddTestItemState> items;
  int currentIndex = 0;
  int get size => items.length;
  PddTestItemState get currentItem => items[currentIndex];

  PddTestController(List<PddTestItem> items, this.onCompleteCallback) {
    this.items = List.generate(
        items.length,
            (index) => PddTestItemState(items[index])
    );
  }

  int getNextNotPassedIndex() {
    var index = currentIndex;
    while (index + 1 < size) {
      if (!getPddItemState(index + 1).isPassed()) {
        return index + 1;
      }
      index ++;
    }
    index = 0;
    while (index < currentIndex) {
      if (!getPddItemState(index).isPassed()) {
        return index;
      }
      index ++;
    }
    return -1;
  }

  PddTestItemState getPddItemState(int index) {
    return items[index];
  }

  void setCurrentIndex(int index) {
      currentIndex = index;
  }

  void answer(PddTestOption option) {
    currentItem.setOption(option);
  }

  bool isCompleted() {
    bool isCompleted = true;
    items.forEach((element) {
      if (!element.isPassed()) {
        isCompleted = false;
      }
    });
    return isCompleted;
  }

  CheckPddResult getResult() {
    int correctAnswers = 0;
    items.forEach((element) { if (element.isCorrect(element.choosenOption)) correctAnswers ++; });
    return CheckPddResult(correctAnswers, size);
  }

  void save() {
    CheckPddResultsHolder.saveCheckPddResult(getResult());
  }
}

class PddTestItemState {

  PddTestItem item;
  PddTestOption? choosenOption;

  PddTestItemState(this.item);

  void setOption(PddTestOption option) {
    choosenOption = option;
  }

  bool isPassed() {
    return (choosenOption != null);
  }

  bool isCorrect(PddTestOption? option) {
    if (option == null) {
      return false;
    } else {
      return option.isCorrect;
    }
  }
}

