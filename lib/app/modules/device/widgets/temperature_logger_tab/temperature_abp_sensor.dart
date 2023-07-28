import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../theme/text_theme.dart';
import '../../../../theme/color_theme.dart';

class TemperatureAbpSensor extends StatelessWidget {
  const TemperatureAbpSensor(
      {Key key,
      @required this.title,
      @required this.pressure,
      @required this.pressureAdc,
      @required this.status})
      : super(key: key);

  final String title, pressure, status;
  final int pressureAdc;

  @override
  Widget build(BuildContext context) {
    List<String> splitPressure = pressure.split('.');
    String pressureInteger = splitPressure[0];
    String pressureDecimals = splitPressure[1];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 10.0,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: textInfoBold),
            Text('${'m_last_sensor_status'.tr}: $status',
                style: textInfoItalic),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  mainAxisAlignment: MainAxisAlignment.start,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(FontAwesomeIcons.gaugeHigh,
                          size: 30, color: ColorsTheme.opaqueBlue),
                    ),
                    SizedBox(width: 8),
                    Text(pressureInteger, style: variableIndicator),
                    Text('.$pressureDecimals', style: variableIndicatorUnit)
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      pressureAdc.toString(),
                      style: variableIndicatorUnit,
                    ),
                    Text('Puente Wheastone')
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
