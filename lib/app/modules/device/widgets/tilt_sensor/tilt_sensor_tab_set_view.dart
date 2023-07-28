import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iobix/app/theme/color_theme.dart';
import 'package:iobix/app/widgets/feature_set_textfield.dart';
import 'package:iobix/app/widgets/features_set_card.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:iobix/app/widgets/normal_button.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../../theme/text_theme.dart';
import 'tilt_sensor_tab_controller.dart';

class TiltSensorTabSetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TiltSensorTabController>(
        builder: (_) => Column(children: [
              Obx(() => FeaturesSetCard(
                    leadingWidget: NormalButton(
                      text: 'Establecer',
                      onPressed: _.bleApiSetAnglesAll,
                    ),
                    title: 'Configuración de umbrales de alarma',
                    iconMain: FontAwesomeIcons.screwdriverWrench,
                    widgetFeatures: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Valor de delta actual'),
                            Spacer(),
                            Text(_.modelTiltSensor.getAngleDelta.toString(),
                                style: variableIndicatorMini),
                            SizedBox(width: 1.0),
                            Text('°', style: variableIndicatorUnit)
                          ],
                        ),
                        FeatureSetTextField(
                          showSetButton: false,
                          labelText: 'Delta',
                          hintText: '[10° - 90°]',
                          initialValue: null,
                          maxLength: 2,
                          keyboardType: TextInputType.number,
                          onChangedText: (t) => _.onChangedSetAngleDelta(t),
                          errorText: _.modelTiltSensor.errorSetAngleDelta,
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Umbral mínimo'),
                            Spacer(),
                            Text(_.modelTiltSensor.setAngleMin,
                                style: variableIndicatorMini),
                            SizedBox(width: 1.0),
                            Text('°', style: variableIndicatorUnit)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Umbral máximo'),
                            Spacer(),
                            Text(_.modelTiltSensor.setAngleMax,
                                style: variableIndicatorMini),
                            SizedBox(width: 1.0),
                            Text('°', style: variableIndicatorUnit)
                          ],
                        ),
                        Column(
                          children: [
                            /*
                            FeatureSetTextField(
                              showSetButton: false,
                              labelText: 'Mínimo',
                              hintText: '[0° - 360°]',
                              initialValue: null,
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              onChangedText: (t) => _.onChangedSetAngleMin(t),
                              errorText: _.modelTiltSensor.errorSetAngleMin,
                            ),
                            FeatureSetTextField(
                              showSetButton: false,
                              labelText: 'Máximo',
                              hintText: '[0° - 360°]',
                              initialValue: null,
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              onChangedText: (t) => _.onChangedSetAngleMax(t),
                              errorText: _.modelTiltSensor.errorSetAngleMax,
                            ),*/
                            SfRadialGauge(
                                enableLoadingAnimation: true,
                                axes: <RadialAxis>[
                                  RadialAxis(
                                    //Sets the minimum range for the slider.
                                    minimum: 0,

                                    //Sets the maximum range for the slider.
                                    maximum: 360,

                                    //Sets the interval range.
                                    interval: 15,

                                    //Sets the minor ticks between interval range.
                                    minorTicksPerInterval: 20,

                                    //Sets the start angle.
                                    startAngle: 270,

                                    //Sets the end angle.
                                    endAngle: 270,

                                    showFirstLabel: false,

                                    ranges: <GaugeRange>[
                                      GaugeRange(
                                        color: Color.fromARGB(225, 56, 121, 75),
                                        startValue: double.parse(
                                            _.modelTiltSensor.setAngleMin),
                                        endValue: double.parse(
                                            _.modelTiltSensor.setAngleMax),
                                      )
                                    ],

                                    pointers: <GaugePointer>[
                                      //First thumb
                                      MarkerPointer(
                                        value: double.parse(_.modelTiltSensor
                                            .setAngleMin), // We declared this in state class.
                                        enableDragging: true,
                                        color: Colors.blueAccent,
                                        onValueChanged: (v) {
                                          _.modelTiltSensor.setAngleMin =
                                              v.toInt().toString();
                                          print(_.modelTiltSensor.setAngleMin);
                                        },
                                        onValueChanging: (v) {},
                                      ),
                                      //Second thumb
                                      MarkerPointer(
                                        value: double.parse(
                                                _.modelTiltSensor.setAngleMax)
                                            .toDouble(),
                                        enableDragging: true,
                                        color: Colors.redAccent,
                                        onValueChanged: (v) {
                                          _.modelTiltSensor.setAngleMax =
                                              v.toInt().toString();
                                          print(_.modelTiltSensor.setAngleMax);
                                        },
                                        onValueChanging: (v) {},
                                      ),
                                    ],
                                  ),
                                ]),
                          ],
                        )
                      ],
                    ),
                  )),
              Obx(() => FeaturesSetCard(
                  title: 'Reajustar transmisiones en alarma',
                  iconMain: FontAwesomeIcons.screwdriverWrench,
                  widgetFeatures: Column(children: [
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text('Estado'),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlutterSwitch(
                              showOnOff: true,
                              activeTextColor: ColorsTheme.lightSalmon,
                              inactiveTextColor: Colors.blue[50],
                              activeColor: ColorsTheme.salmon,
                              value:
                                  (_.modelTiltSensor.getAlarmModeStatus == 0x01)
                                      ? true
                                      : false,
                              height: 25,
                              width: 55,
                              valueFontSize: 10,
                              onToggle: (v) =>
                                  _.updateAlarmMode((v) ? 0x01 : 0x00),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text('Tiempo de transmisición'),
                        Spacer(),
                        Text(
                            _.modelTiltSensor.getAlarmTransmitionPeriod
                                .toString(),
                            style: variableIndicatorMini),
                        SizedBox(width: 1.0),
                        Text('s', style: variableIndicatorUnit)
                      ],
                    ),
                    FeatureSetTextField(
                      labelText: 'Periodo de transmisión',
                      hintText: 's',
                      initialValue: null,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      onChangedText: (t) =>
                          _.onChangedSetAlarmTransmitionPeriod(t),
                      onPressedSet: _.bleApiSetAlarmTransmitionPeriod,
                      errorText:
                          _.modelTiltSensor.errorSetAlarmTransmitionPeriod,
                    )
                  ]))),
            ]));
  }
}
