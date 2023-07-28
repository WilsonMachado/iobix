import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../widgets/default_card.dart';
import '../../../../widgets/custom_linear_indicator.dart';
import '../../../../theme/color_theme.dart';
import '../../../../theme/text_theme.dart';

class PressureWidget extends StatelessWidget {
  const PressureWidget(
      {Key key,
      this.title = 'Sensores de presión',
      @required this.status1,
      @required this.status2,
      @required this.value1,
      @required this.value2,
      @required this.units})
      : super(key: key);

  final String title, status1, status2;
  final double value1, value2;
  final String units;

  @override
  Widget build(BuildContext context) {
    return DefaultCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            FontAwesomeIcons.thermometer,
            size: 30,
            color: ColorsTheme.opaqueBlue,
          ),
          SizedBox(height: 3.0),
          Text(
            title,
            style: textInfoBold,
          ),
          SizedBox(height: 5),
          CustomLinearPercentIndicator(
            title: 'Canal 1',
            unit: units,
            value: value1,
            digits: 2,
            maxValue: 30,
          ),
          SizedBox(height: 2),
          RichText(
            text: TextSpan(style: textInfoItalic, children: [
              TextSpan(text: 'Estado del sensor: '),
              TextSpan(text: status1, style: textInfoBold)
            ]),
          ),
          SizedBox(height: 5),
          CustomLinearPercentIndicator(
            title: 'Canal 2',
            unit: units,
            value: value2,
            digits: 2,
            maxValue: 30,
          ),
          SizedBox(height: 2),
          RichText(
            text: TextSpan(style: textInfoItalic, children: [
              TextSpan(text: 'Estado del sensor: '),
              TextSpan(text: status2, style: textInfoBold)
            ]),
          ),
        ],
      ),
    );
  }
}
