import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../theme/color_theme.dart';
import '../../../../theme/text_theme.dart';

class IskraMT174PhaseCard extends StatelessWidget {
  const IskraMT174PhaseCard(
      {Key key,
      @required this.title,
      @required this.voltage,
      @required this.current,
      this.maxVoltage = 150,
      this.maxCurrent = 10,
      this.radius = 70})
      : super(key: key);

  final String title;
  final double voltage, current, maxVoltage, maxCurrent;
  final double radius;

  @override
  Widget build(BuildContext context) {
    double voltagePercent = voltage / maxVoltage;
    if (voltagePercent > 1) voltagePercent = 1;
    double currentPercent = current / maxCurrent;
    if (currentPercent > 1) currentPercent = 1;
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 10.0,
        child: Padding(
            padding: EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: textInfoBold),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularPercentIndicator(
                          animateFromLastPercent: false,
                          radius: radius > 100 ? 100 : radius,
                          lineWidth: radius / 5,
                          animation: true,
                          percent: voltagePercent,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: ColorsTheme.opaqueBlue,
                          center: Text(voltage.toStringAsFixed(1),
                              style: textInfoBold),
                        ),
                        Text('Voltaje (V)', style: variableIndicatorUnit)
                      ],
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularPercentIndicator(
                          radius: radius,
                          lineWidth: radius * 0.1,
                          animation: true,
                          percent: currentPercent,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: ColorsTheme.salmon,
                          center: Text(current.toStringAsFixed(2),
                              style: textInfoBold),
                        ),
                        Text('Corriente (A)', style: variableIndicatorUnit)
                      ],
                    ),
                  ),
                ],
              ),
            ])));
  }
}
