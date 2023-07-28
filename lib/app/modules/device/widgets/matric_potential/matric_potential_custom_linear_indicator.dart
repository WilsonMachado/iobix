import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../theme/text_theme.dart';

class MatricPotentialCustomLinearIndicator extends StatelessWidget {
  final String title, unit, value;
  final double maxValue, lineHeight, customHeight;
  final int digits;
  final Color progressColor;

  const MatricPotentialCustomLinearIndicator({
    Key key,
    @required this.title,
    @required this.unit,
    @required this.value,
    this.maxValue = 1000000.0,
    this.lineHeight = 12.0,
    this.digits = 0,
    this.customHeight = 0.0,
    this.progressColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percent = 0;
    String valueInteger, valueDouble;

    if (value != 'disconnected') {
      percent = double.parse(value) / maxValue;
      if (percent > 1) percent = 0.99;
      valueInteger = value.split('.')[0];
      valueDouble = digits != 0 ? value.split('.')[1] : null;
    }

    return Column(
      children: [
        SizedBox(height: customHeight),
        Row(
          children: [
            Spacer(),
            if (value == 'disconnected')
              Column(
                children: [
                  Text(
                    value.tr,
                    style: variableIndicatorUnit,
                  ),
                ],
              )
            else
              Column(
                children: [
                  Text(
                    valueInteger,
                    style: variableIndicatorMini,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    digits != 0 ? '.$valueDouble $unit' : unit,
                    style: variableIndicatorUnit,
                  ),
                ],
              )
          ],
        ),
        LinearPercentIndicator(
            barRadius: Radius.circular(20),
            animation: true,
            restartAnimation: true,
            animationDuration: 1000,
            padding: EdgeInsets.zero,
            lineHeight: lineHeight,
            percent: percent,
            progressColor: progressColor != null
                ? progressColor
                : Theme.of(context).primaryColor),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: textInfoBold))
      ],
    );
  }
}
