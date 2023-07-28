import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:get/get_utils/get_utils.dart';

import './../theme/color_theme.dart';
import './../theme/text_theme.dart';

class I2cBme280Card extends StatelessWidget {
  const I2cBme280Card({
    Key key,
    @required this.title,
    @required this.status,
    @required this.temperature,
    @required this.humidity,
    @required this.pressure,
    @required this.showPressure,
  }) : super(key: key);

  final String title;
  final String status, temperature, humidity, pressure;
  final bool showPressure;
  @override
  Widget build(BuildContext context) {
    List<String> _temp = temperature.split('.');
    double _humi = int.parse(humidity) / 100;
    List<String> _press = pressure.split('.');
    List<Widget> contenido = [
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(FontAwesomeIcons.temperatureThreeQuarters,
                      size: 20, color: ColorsTheme.opaqueBlue),
                ),
                Text(_temp[0],
                    style: TextStyle(
                        color: ColorsTheme.darkBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                Text('.${_temp[1]}',
                    style: TextStyle(
                        color: ColorsTheme.darkBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))
              ],
            ),
            SizedBox(height: 8),
            Text('${'temperature'.tr} (°C)'),
          ],
        ),
      ),
      Flexible(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                CircularPercentIndicator(
                  animateFromLastPercent: false,
                  radius: 20,
                  lineWidth: 40 / 10,
                  animation: true,
                  percent: _humi > 1 ? 1 : _humi,
                  center: Icon(FontAwesomeIcons.droplet,
                      color: ColorsTheme.darkBlue, size: 13),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 4),
                Text(humidity,
                    style: TextStyle(
                        color: ColorsTheme.darkBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))
              ],
            ),
            SizedBox(height: 4),
            Text('${'humidity'.tr} (%)'),
          ],
        ),
      ),
      (showPressure)
          ? Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(FontAwesomeIcons.gaugeHigh,
                            size: 20, color: ColorsTheme.opaqueBlue),
                      ),
                      //SizedBox(width: 8),
                      Text(_press[0],
                          style: TextStyle(
                              color: ColorsTheme.darkBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      Text('.${_press[1]}',
                          style: TextStyle(
                              color: ColorsTheme.darkBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('${'pressure'.tr} (kPa)'),
                ],
              ),
            )
          : Container(),
    ];
    final currentWidth = MediaQuery.of(context).size.width;
    print(currentWidth);
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 10.0,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textInfoBold),
              Text('${'m_last_sensor_status'.tr}: $status',
                  style: textInfoItalic),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: contenido,
              )
            ],
          ),
        ),
      ),
    );
  }
}
