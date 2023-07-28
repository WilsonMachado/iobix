import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../theme/color_theme.dart';
import '../theme/text_theme.dart';

class CircularIndicatorCard extends StatelessWidget {
  const CircularIndicatorCard(
      {Key key,
      @required this.title,
      @required this.value,
      @required this.unit,
      @required this.icon,
      this.iconSize = 25,
      this.digits = 0,
      this.radiusSize = 70.0,
      this.progressColor})
      : super(key: key);

  final String title, unit;
  final IconData icon;
  final double iconSize, radiusSize;
  final int digits;
  final Color progressColor;
  final double value;

  @override
  Widget build(BuildContext context) {
    double valuePercentage = value * 100;
    String valueStr = valuePercentage.toStringAsFixed(digits), valueInteger, valueDouble;
    valueInteger =
        digits != 0 ? valueStr.split('.')[0] : valuePercentage.toStringAsFixed(0);
    valueDouble = digits != 0 ? valueStr.split('.')[1] : null;
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 10.0,
        child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textInfoBold),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    CircularPercentIndicator(
                      animateFromLastPercent: false,
                      radius: radiusSize > 100 ? 100 : radiusSize,
                      lineWidth: radiusSize / 10,
                      animation: true,
                      percent: value,
                      center: Icon(icon,
                          color: ColorsTheme.darkBlue, size: iconSize),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: progressColor != null
                          ? progressColor
                          : Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 8),
                    Text(valueInteger,
                        style: variableIndicator),
                    Text(digits != 0 ? '.$valueDouble$unit' : unit,
                        style: variableIndicatorUnit),
                  ],
                ),
              ],
            )));
  }
}
