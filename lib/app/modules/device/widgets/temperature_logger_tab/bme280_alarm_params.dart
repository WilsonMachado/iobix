import 'package:flutter/material.dart';

import '../../../../theme/text_theme.dart';

class Bme280AlarmParams extends StatelessWidget {
  const Bme280AlarmParams({
    Key key,
    @required this.title,
    @required this.tempTH,
    @required this.humTH,
  }) : super(key: key);

  final List<String> tempTH;
  final List<String> humTH;
  final String title;

  @override
  Widget build(BuildContext context) {
    String deltaTemp = tempTH[1], tempMin = tempTH[2], tempMax = tempTH[3];
    String deltaHum = humTH[1], humMin = humTH[2], humMax = humTH[3];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 10.0,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title, style: textInfoBold),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Temperatura: '),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                  Column(
                    children: [
                      Text(deltaTemp, style: variableIndicatorUnit),
                      Text('Delta')
                    ],
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    children: [
                      Text(tempMin, style: variableIndicatorUnit),
                      Text('Min')
                    ],
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    children: [
                      Text(tempMax, style: variableIndicatorUnit),
                      Text('Max')
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Humedad: '),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.65,
                  ),
                  Column(
                    children: [
                      Text(deltaHum, style: variableIndicatorUnit),
                      Text('Delta')
                    ],
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    children: [
                      Text(humMin, style: variableIndicatorUnit),
                      Text('Min')
                    ],
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    children: [
                      Text(humMax, style: variableIndicatorUnit),
                      Text('Max')
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
