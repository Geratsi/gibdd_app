import 'package:car_online/Config.dart';
import 'package:car_online/activity/profile/check_pdd/domain/model/PddTestItem.dart';
import 'package:car_online/widget/MainButton.dart';
import 'package:flutter/material.dart';

import '../domain/PddTestController.dart';

class CheckPddTab extends StatefulWidget {
  const CheckPddTab({
    Key? key,
    required this.testItemState,
    required this.updateParentState,
    required this.setAnswer,
  }) : super(key: key);

  final PddTestItemState testItemState;
  final Function updateParentState;
  final Function(PddTestOption) setAnswer;

  @override
  _CheckPddTabState createState() => _CheckPddTabState();
}

class _CheckPddTabState extends State<CheckPddTab> {
  late PddTestItemState testItemState;

  @override
  void initState() {
    testItemState = widget.testItemState;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int optionCount = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        testItemState.item.imageSource != null ?
        SizedBox(
          height: 150,
          child: Image.asset(
            testItemState.item.imageSource!,
            fit: BoxFit.cover,
          ),
        ) : SizedBox.shrink(),

        Padding(
          padding: EdgeInsets.all(Config.padding),
          child: Column(
            children: <Widget>[
              Text(testItemState.item.question, style: TextStyle(
                  fontSize: Config.textMediumSize,
                  color: Config.textTitleColor),
              ),

              SizedBox(height: Config.padding,),

              ...testItemState.item.options.map((option) {
                return Padding(
                  padding: EdgeInsets.only(bottom: Config.padding / 2),
                  child: MainButton(
                    label: '${++optionCount}. ${option.label}',
                    onPressed: testItemState.isPassed() ? null : () {
                      widget.setAnswer(option);
                      widget.updateParentState();
                    },

                    bgColor: getBtnBgColor(testItemState, option),
                    labelColor: getBtnTitleColor(testItemState, option),
                    labelAlignment: MainAxisAlignment.start,
                  ),
                );
              })
            ],
          ),
        ),
      ],
    );
  }
  
  Color getBtnBgColor(PddTestItemState state, PddTestOption option) {
    if (state.isPassed()) {
      if (state.choosenOption == option) {
        return state.isCorrect(option) ? Config.successColor : Config.errorColor;
      } else {
        return state.isCorrect(option) ? Config.successColor : Config.baseInfoColor;
      }
    } else {
      return Config.baseInfoColor;
    }
  }

  Color getBtnTitleColor(PddTestItemState state, PddTestOption option) {
    if (state.isPassed()) {
      if (state.choosenOption == option || option.isCorrect) {
        return Config.textColorOnPrimary;
      } else {
        return Config.primaryDarkColor;
      }
    } else {
      return Config.primaryDarkColor;
    }
  }
}

