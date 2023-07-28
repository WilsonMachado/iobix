import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../widgets/default_card.dart';
import '../../../../theme/color_theme.dart';
import '../../../../theme/text_theme.dart';

class BatteryCard extends StatelessWidget {
  const BatteryCard({
    Key key,
    @required this.value,
    @required this.percentage,
    this.radiusSize = 40.0,
    this.title = 'Title',
  }) : super(key: key);

  final double value, percentage, radiusSize;
  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textInfoBold),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircularPercentIndicator(
                animateFromLastPercent: false,
                radius: radiusSize > 100 ? 100 : radiusSize,
                lineWidth: radiusSize / 5,
                animation: true,
                percent: percentage,
                center: Icon(
                  Icons.battery_charging_full_rounded,
                  color: ColorsTheme.darkBlue,
                  size: 25,
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 8),
              Column(
                children: [
                  RichText(
                    text: TextSpan(style: variableIndicatorMini, children: [
                      TextSpan(text: value.toStringAsFixed(1)),
                      TextSpan(text: ' V', style: variableIndicatorUnit)
                    ]),
                  ),
                  RichText(
                    text: TextSpan(style: variableIndicatorMini, children: [
                      TextSpan(
                          text: (percentage == 0)
                              ? '--'
                              : (percentage * 100).toStringAsFixed(0)),
                      TextSpan(text: ' %', style: variableIndicatorUnit)
                    ]),
                  ),
                ],
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}
