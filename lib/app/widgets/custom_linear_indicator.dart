import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../theme/text_theme.dart';

class CustomLinearPercentIndicator extends StatelessWidget {
  const CustomLinearPercentIndicator(
      {Key key,
      @required this.title,
      @required this.unit,
      @required this.value,
      this.maxValue = 100000.0,
      this.digits = 0,
      this.lineHeight = 12.0,
      this.progressColor})
      : super(key: key);

  final String title, unit;
  final double value, maxValue, lineHeight;
  final int digits;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    double percent = value / maxValue;
    if (percent < 0) percent = percent * (-1);
    if (percent > 1) percent = 0.99;

    String valueStr = value.toStringAsFixed(digits), valueInteger, valueDouble;
    valueInteger =
        digits != 0 ? valueStr.split('.')[0] : value.toStringAsFixed(0);
    valueDouble = digits != 0 ? valueStr.split('.')[1] : null;

    return Column(
      children: [
        Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(title, style: textInfoBold),
            Spacer(),
            Text(valueInteger, style: variableIndicator),
            Text(digits != 0 ? '.$valueDouble $unit' : ' $unit',
                style: variableIndicatorUnit),
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
      ],
    );
  }
}
