import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../theme/text_theme.dart';
import '../../../../theme/color_theme.dart';

class TemperatureCard extends StatelessWidget {
  const TemperatureCard({
    Key key,
    @required this.title,
    @required this.ntc,
  }) : super(key: key);

  final List<String> ntc;
  final String title;

  @override
  Widget build(BuildContext context) {
    List<String> splitValue = ntc[0].split('.');
    bool isValue = splitValue.length > 1;

    String valueInteger = splitValue[0], valueDecimals;

    if (isValue) {
      valueDecimals = splitValue[1];
    }

    String delta = ntc[1], min = ntc[2], max = ntc[3];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 10.0,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: textInfoBold),
            SizedBox(height: 10),
            Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  mainAxisAlignment: MainAxisAlignment.start,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(FontAwesomeIcons.temperatureThreeQuarters,
                          size: 30, color: ColorsTheme.opaqueBlue),
                    ),
                    SizedBox(width: 8),
                    Text(valueInteger,
                        style: isValue ? variableIndicator : textInfoMiniBold),
                    if (isValue)
                      Text('.$valueDecimals', style: variableIndicatorUnit)
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(delta, style: variableIndicatorUnit),
                    Text('Delta')
                  ],
                ),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(min, style: variableIndicatorUnit),
                    Text('Min')
                  ],
                ),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(max, style: variableIndicatorUnit),
                    Text('Max')
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
