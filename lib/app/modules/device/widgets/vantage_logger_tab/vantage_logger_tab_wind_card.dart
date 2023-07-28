import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../theme/text_theme.dart';
import '../../../../theme/color_theme.dart';

class VantageLoggerTabWindCard extends StatelessWidget {
  const VantageLoggerTabWindCard({
    Key key,
    @required this.title,
    @required this.direction,
    @required this.speed,
    @required this.unitSpeed,
    this.directionDigits = 0,
    this.speedDigits = 0,
  }) : super(key: key);

  final String title;
  final String unitSpeed;
  final double direction, speed;
  final int directionDigits, speedDigits;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 10.0,
        child: Padding(
            padding: EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Icon(FontAwesomeIcons.wind, color: ColorsTheme.opaqueBlue),
                  SizedBox(width: 8),
                  Text(title, style: textInfoBold)
                ],
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: SfRadialGauge(
                  enableLoadingAnimation: true,
                  animationDuration: 1000,
                  axes: [
                    RadialAxis(
                        startAngle: 270,
                        endAngle: 270,
                        interval: 90,
                        radiusFactor: 0.8,
                        minimum: 0,
                        maximum: 360,
                        showFirstLabel: false,
                        axisLabelStyle: GaugeTextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                        labelFormat: '{value}',
                        //labelsPosition: ElementsPosition.outside,
                        showTicks: false,
                        pointers: [
                          MarkerPointer(
                              value: direction,
                              markerHeight: 15,
                              markerWidth: 15,
                              markerType: MarkerType.triangle,
                              color: ColorsTheme.salmon,
                              markerOffset: 50)
                        ],
                        annotations: [
                          GaugeAnnotation(
                              horizontalAlignment: GaugeAlignment.center,
                              verticalAlignment: GaugeAlignment.center,
                              //angle: 180,
                              positionFactor: 0.03,
                              widget: Container(
                                //color: Colors.black,
                                width: 300,
                                height: 300,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              height: 35,
                                              child: Text(
                                                  speed.toStringAsFixed(
                                                      speedDigits),
                                                  style: variableIndicator)),
                                          Text(unitSpeed,
                                              style: variableIndicatorUnit),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text('N'),
                                        Spacer(),
                                        Row(
                                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text('W'),
                                              Spacer(),
                                              Text(
                                                  direction.toStringAsFixed(
                                                      directionDigits),
                                                  style: variableIndicator),
                                              Text(' °',
                                                  style: variableIndicatorUnit),
                                              Spacer(),
                                              Text('E'),
                                            ]),
                                        Spacer(),
                                        Text('S')
                                      ],
                                    )
                                  ],
                                ),
                              ))
                        ])
                  ],
                ),
              )
            ])));
  }
}
