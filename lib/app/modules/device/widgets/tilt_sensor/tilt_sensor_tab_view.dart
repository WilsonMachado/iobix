import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'tilt_sensor_tab_controller.dart';

class TiltSensorTabView extends StatelessWidget {
  const TiltSensorTabView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TiltSensorTabController>(
        builder: (_) => RefreshIndicator(
              onRefresh: () => _.bleApiReloadView(),
              child: Obx(
                () => SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            elevation: 10.0,
                            child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SfRadialGauge(
                                        title: GaugeTitle(
                                            text: 'Posición actual del sensor',
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black)),
                                        enableLoadingAnimation: true,
                                        animationDuration: 2500,
                                        axes: <RadialAxis>[
                                          RadialAxis(
                                              ranges: <GaugeRange>[
                                                GaugeRange(
                                                  color: Color.fromARGB(
                                                      225, 56, 121, 75),
                                                  startValue: _.modelTiltSensor
                                                      .getAngleMin
                                                      .toDouble(),
                                                  endValue: _.modelTiltSensor
                                                      .getAngleMax
                                                      .toDouble(),
                                                )
                                              ],
                                              axisLabelStyle: GaugeTextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 8,
                                                  color: Colors.black),
                                              annotations: <GaugeAnnotation>[
                                                GaugeAnnotation(
                                                    angle: 90,
                                                    positionFactor: 0.5,
                                                    widget: Text(
                                                      _.modelTiltSensor
                                                              .angleIncl
                                                              .toString() +
                                                          '°',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ))
                                              ],
                                              pointers: [
                                                MarkerPointer(
                                                    value: _.modelTiltSensor
                                                        .getAngleMin
                                                        .toDouble(),
                                                    color: Colors.blueAccent),

                                                ///* Min
                                                MarkerPointer(
                                                  value: _.modelTiltSensor
                                                      .getAngleMax
                                                      .toDouble(),
                                                  color: Colors.redAccent,
                                                ),

                                                ///* Max
                                                NeedlePointer(
                                                  value: _.modelTiltSensor
                                                      .angleIncl,
                                                )
                                              ],
                                              interval: 10,
                                              showFirstLabel: false,
                                              startAngle: 270,
                                              endAngle: 270,
                                              minimum: 0,
                                              maximum: 360),
                                        ],
                                      )
                                    ]))),
                      ],
                    )),
              ),
            ));
  }
}
