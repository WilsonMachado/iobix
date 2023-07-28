import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../theme/color_theme.dart';
import '../../../../theme/text_theme.dart';

class PluviometerWidget extends StatelessWidget {
  const PluviometerWidget({
    Key key,
    @required this.value,
    this.desc = 'Precipitación',
  }) : super(key: key);

  final int value;
  final String desc;

  @override
  Widget build(BuildContext context) {
    double percent = value / 20;
    if (percent > 1.0) percent = 1.0;

    return Column(
      children: [
        CircularPercentIndicator(
          animateFromLastPercent: false,
          radius: 70,
          lineWidth: 10,
          animation: true,
          percent: percent,
          center: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.cloudRain, color: ColorsTheme.darkBlue),
              Text(' | ' + value.toString(), style: variableIndicatorUnit)
            ],
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: ColorsTheme.darkBlue,
        ),
        SizedBox(height: 5),
        Text(desc, style: variableIndicatorUnit)
      ],
    );
  }
}