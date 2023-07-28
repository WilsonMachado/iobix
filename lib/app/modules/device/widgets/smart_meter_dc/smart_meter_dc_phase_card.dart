import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../theme/text_theme.dart';
import '../../../../theme/color_theme.dart';
import '../../../../widgets/default_card.dart';

class SmartMeterDcPhaseCard extends StatelessWidget {
  const SmartMeterDcPhaseCard({
    Key key,
    this.title = 'Fase',
    @required this.voltage,
    @required this.current,
    this.maxVoltage = 140.0,
    this.maxCurrent = 10.0,
    this.radius = 70,
    this.currentScale = 'A',
    @required this.delta,
    @required this.min,
    @required this.max,
  }) : super(key: key);

  final String title;
  final String voltage, current, currentScale;
  final String delta, min, max;
  final double maxVoltage, maxCurrent;
  final double radius;

  @override
  Widget build(BuildContext context) {
    double voltagePercent = (double.tryParse(voltage) != null)
        ? double.parse(voltage) / maxVoltage
        : 0;
    double currentPercent = (double.tryParse(current) != null)
        ? double.parse(current) / maxCurrent
        : 0;
    if (currentPercent < 0) currentPercent = 0;
    if (currentPercent > 1) currentPercent = 1;

    if (voltagePercent < 0) voltagePercent = 0;
    if (voltagePercent > 1) voltagePercent = 1;

    return DefaultCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: textInfoBold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CircularPercentIndicator(
            animateFromLastPercent: false,
            radius: radius > 100 ? 100 : radius,
            lineWidth: radius / 5,
            animation: true,
            percent: voltagePercent,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: ColorsTheme.opaqueBlue,
            center: Text(
              voltage,
              style:
                  (voltage.length < 6) ? textInfoBold : textInfoSuperMiniBold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Voltaje (V)',
            style: variableIndicatorUnit,
          ),
          SizedBox(
            height: 10,
          ),
          CircularPercentIndicator(
            animateFromLastPercent: false,
            radius: radius > 100 ? 100 : radius,
            lineWidth: radius / 5,
            animation: true,
            percent: currentPercent,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: ColorsTheme.salmon,
            center: Text(
              current,
              style:
                  (current.length < 6) ? textInfoBold : textInfoSuperMiniBold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Corriente ($currentScale)',
            style: variableIndicatorUnit,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delta (V)'),
              SizedBox(
                width: 5.0,
              ),
              Text(
                delta,
                style: variableIndicatorUnit,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('U. Inferior (V)'),
              SizedBox(
                width: 5.0,
              ),
              Text(
                min,
                style: variableIndicatorUnit,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('U. Superior (V)'),
              SizedBox(
                width: 5.0,
              ),
              Text(
                max,
                style: variableIndicatorUnit,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
