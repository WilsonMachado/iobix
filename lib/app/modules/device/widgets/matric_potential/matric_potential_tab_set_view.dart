import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iobix/app/utils/constants/ble_api/matric_potential/matric_potential_constants.dart';
import 'package:iobix/app/widgets/custom_dropdown/custom_dropdown.dart';

import '../../../../widgets/circular_button.dart';
import '../../../../widgets/custom_switch.dart';
import './matric_potential_tab_controller.dart';
import '../../../../widgets/features_set_card.dart';
import '../../../../widgets/feature_set_textfield.dart';
import '../../../../data/models/local/model_login.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../theme/text_theme.dart';

class MatricPotentialTabSetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatricPotentialTabController>(
      builder: (_) => Column(
        children: [
          if (ModelLogin.isRole(Roles.superAdmin))
            Obx(() => FeaturesSetCard(
                  title: 'Calibración de potencial mátrico',
                  iconMain: FontAwesomeIcons.screwdriverWrench,
                  widgetFeatures: Column(
                    children: [
                      if ((_.modelMatricPotential.deviceVersion == 3.1 &&
                              _.isFwHigherOrEqual1_2_0 == false) ||
                          (_.modelMatricPotential.deviceVersion == 4.0 &&
                              _.isFwHigherOrEqual1_0_15 == false) ||
                          (_.modelMatricPotential.deviceVersion != 3.1 &&
                              _.modelMatricPotential.deviceVersion != 4.0))
                        Text(
                            '* Mida, con una herramienta de medición confiable, el valor de una resistencia eléctrica. Luego, conecte dicha resistencia en el puerto del sensor 1 (MG1) e ingrese, en el siguiente campo, el valor de resistencia medido',
                            style: textInfoMiniItalic),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text('Valor de compensación actual'),
                          Spacer(),
                          Text(_.modelMatricPotential.getResistanceCalibValue,
                              style: variableIndicatorMini),
                          SizedBox(width: 5.0),
                          Text('Ω', style: variableIndicatorUnit)
                        ],
                      ),
                      FeatureSetTextField(
                        labelText: 'Calibración resistiva',
                        hintText: 'Ω',
                        initialValue:
                            _.modelMatricPotential.setResistanceCalibValue,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        onChangedText: (t) =>
                            _.onChangedSetResistanceCalibValue(t),
                        onPressedSet: _.bleApiSetResistanceCalibData,
                        errorText:
                            _.modelMatricPotential.errorSetResistanceCalibValue,
                      )
                    ],
                  ),
                )),
          if ((ModelLogin.isRole(Roles.admin) ||
                      ModelLogin.isRole(Roles.superAdmin)) &&
                  _.modelMatricPotential.deviceVersion == 3.1 &&
                  !_.isFwHigherOrEqual1_2_0 ||
              (ModelLogin.isRole(Roles.superAdmin) &&
                  (_.modelMatricPotential.deviceVersion == 3.1 &&
                      _.isFwHigherOrEqual1_2_0)))
            Obx(() => FeaturesSetCard(
                title: 'Calibración para el RTC',
                iconMain: FontAwesomeIcons.sliders,
                leadingWidget: Container(),
                widgetFeatures: Column(children: [
                  Column(
                      //
                      children: [
                        Text(
                          'Seleccione el offset para el RTC:',
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(
                            height:
                                10), //! Para establecer el offset de calibración del RTC
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButton<String>(
                                  //* Mapa que transporta
                                  value: _.modelMatricPotential
                                      .rtcOffsetCalibration,
                                  items: MATRIC_POTENTIAL_CONSTANTS_V3_1
                                      .RTC_OFFSET_VALUE
                                      .map((value, key) {
                                        return MapEntry(
                                            value,
                                            DropdownMenuItem<String>(
                                              value: value.toString(),
                                              child: Text(key.toString()),
                                            ));
                                      })
                                      .values
                                      .toList(),
                                  onChanged: (v) {
                                    _.bleApiSetRTCCalibrationOffset(
                                        int.parse(v));
                                  }),
                            ]),
                        SizedBox(height: 10),

                        Text(
                          'Seleccione la frecuencia de salida del RTC:',
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(
                            height:
                                10), //! Para establecer la frecuencia de salida del RTC
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButton<String>(
                                  //* Mapa que transporta
                                  value: _.modelMatricPotential.rtcCLKOUT,
                                  items: MATRIC_POTENTIAL_CONSTANTS_V3_1
                                      .RTC_CLKOUT_CONFIG
                                      .map((value, key) {
                                        return MapEntry(
                                            value,
                                            DropdownMenuItem<String>(
                                              value: value.toString(),
                                              child: Text(key.toString()),
                                            ));
                                      })
                                      .values
                                      .toList(),
                                  onChanged: (v) {
                                    _.bleApiSetRTCCLKOUT(int.parse(v));
                                  }),
                            ])
                      ])
                ]))),
          if (!ModelLogin.isRole(Roles.device) &&
              _.modelMatricPotential.deviceVersion == 1)
            Obx(() => FeaturesSetCard(
                  title: 'Control de riego',
                  iconMain: FontAwesomeIcons.sliders,
                  leadingWidget: (ModelLogin.isRole(Roles.superAdmin))
                      ? CustomSwitch(
                          value: _.modelMatricPotential.irrigationStatus,
                          onChanged: (v) => _.bleApiSetIrrigationStatus(v),
                        )
                      : Container(),
                  widgetFeatures: (_.modelMatricPotential.irrigationStatus)
                      ? Column(
                          children: [
                            Obx(() => FeatureSetTextField(
                                  labelText: 'Tiempo de riego',
                                  hintText: 'Minutos',
                                  initialValue:
                                      _.modelMatricPotential.setIrrigationTime,
                                  maxLength: 3,
                                  keyboardType: TextInputType.number,
                                  onChangedText: (t) =>
                                      _.onChangedSetIrrigationTime(t),
                                  onPressedSet: _.bleApiSetIrrigationTime,
                                  errorText: _.modelMatricPotential
                                      .errorSetIrrigationTime,
                                )),
                            Obx(() => FeatureSetTextField(
                                  labelText: 'Tiempo de espera para el riego',
                                  hintText: 'Minutos',
                                  initialValue: _.modelMatricPotential
                                      .setIrrigationWaitTime,
                                  maxLength: 3,
                                  keyboardType: TextInputType.number,
                                  onChangedText: (t) =>
                                      _.onChangedSetIrrigationWaitTime(t),
                                  onPressedSet: _.bleApiSetIrrigationWaitTime,
                                  errorText: _.modelMatricPotential
                                      .errorSetIrrigationWaitTime,
                                )),
                            Obx(() => FeatureSetTextField(
                                labelText:
                                    'Valor de presión para iniciar riego',
                                hintText: 'kPa',
                                initialValue: _.modelMatricPotential
                                    .setPvToStartIrrigation,
                                maxLength: 3,
                                keyboardType: TextInputType.number,
                                onChangedText: (t) =>
                                    _.onChangedSetPvToStartIrrigation(t),
                                onPressedSet: _.bleApiSetPvToStartIrrigation,
                                errorText: _.modelMatricPotential
                                    .errorSetPvToStartIrrigation)),
                            Obx(() => FeatureSetTextField(
                                  labelText:
                                      'Valor de presión para finalizar riego',
                                  hintText: 'kPa',
                                  initialValue: _.modelMatricPotential
                                      .setPvToStopIrrigation,
                                  maxLength: 3,
                                  keyboardType: TextInputType.number,
                                  onChangedText: (t) =>
                                      _.onChangedSetPvToStopIrrigation(t),
                                  onPressedSet: _.bleApiSetPvToStopIrrigation,
                                  errorText: _.modelMatricPotential
                                      .errorSetPvToStopIrrigation,
                                )),
                            SizedBox(height: 25.0),
                            Obx(() => CustomDropdown(
                                  itemsMap:
                                      MATRIC_POTENTIAL_CONSTANTS.GM_SENSOR_MAP,
                                  onPressedSet: _.bleApiSetGmIrrigationControl,
                                  onChanged: (int k) =>
                                      _.onChangedSetGmIrrigationControl(k),
                                  value:
                                      MATRIC_POTENTIAL_CONSTANTS.GM_SENSOR_MAP[_
                                          .modelMatricPotential
                                          .setGmIrrigationControl],
                                  dropdownTitle: 'select'.tr,
                                  dropdownSubtitle:
                                      'Seleccione el canal de la matrix granular que controlará el riego',
                                  floatingLabel: 'Sensor de control de riego',
                                  hintText: 'select'.tr,
                                  errorText: _.modelMatricPotential
                                      .errorSetGmIrrigationControl,
                                ))
                          ],
                        )
                      : Text(
                          'Habilite el control de riego en el dispositivo para ver las configuraciones posibles ...',
                          style: textInfoItalic,
                        ),
                )),
          SizedBox(height: 8.0),
          if (!ModelLogin.isRole(Roles.superAdmin) &&
              ((_.modelMatricPotential.deviceVersion == 3.1 &&
                      _.isFwHigherOrEqual1_2_0) ||
                  (_.modelMatricPotential.deviceVersion == 4.0 &&
                      _.isFwHigherOrEqual1_0_15)))
            Center(
              child: Text(
                  "No se tiene ninguna configuración especifica para este dispositivo"),
            ),
          if (ModelLogin.isRole(Roles.superAdmin) &&
              _.modelMatricPotential.deviceVersion == 4.0 &&
              _.isFwHigherOrEqual1_0_15)
            Obx(
              () => FeaturesSetCard(
                title: 'Calibración del RTC',
                iconMain: FontAwesomeIcons.timeline,
                widgetFeatures: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text('Valor de calibración actual'),
                        Spacer(),
                        Text(
                            "${_.modelMatricPotential.getRtcOffsetSign}${_.modelMatricPotential.getRtcOffset}",
                            style: variableIndicatorMini),
                        SizedBox(width: 5.0),
                        Text('ppm', style: variableIndicatorUnit)
                      ],
                    ),
                    Row(
                      children: [
                        DropdownButton(
                            //* Signo del RTC
                            value: _.modelMatricPotential.setRtcOffsetSign,
                            items: MATRIC_POTENTIAL_CONSTANTS_V4.RTC_OFSSET_SIGN
                                .map((value) {
                              return DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text('$value'),
                              );
                            }).toList(),
                            onChanged: (v) {
                              _.modelMatricPotential.setRtcOffsetSign = v;
                            }),
                        SizedBox(width: 12),
                        Expanded(
                          child: FeatureSetTextField(
                            labelText: 'Offset de RTC',
                            hintText: 'ppm',
                            initialValue: '',
                            maxLength: 3,
                            keyboardType: TextInputType.number,
                            onChangedText: (t) => _.onChangedRTCOffset(t),
                            onPressedSet: _.bleApiSetRTCOffsetData,
                            errorText: _.modelMatricPotential.errorRTCOffset,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          if (!ModelLogin.isRole(Roles.device) &&
              _.modelMatricPotential.deviceVariation == 1 &&
              _.modelMatricPotential.deviceVersion == 4)
            Obx(() => FeaturesSetCard(
                  title: 'Control de riego',
                  iconMain: FontAwesomeIcons.sliders,
                  leadingWidget: Container(),
                  widgetFeatures: Column(
                    children: [
                      FeatureSetTextField(
                        labelText: 'Umbral para riego automático (kPa)',
                        hintText: 'kPa',
                        initialValue:
                            _.modelMatricPotential.setIrrigationThreshold,
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        onChangedText: (t) =>
                            _.onChangedSetIrrigationThreshold(t),
                        onPressedSet: _.bleApiSetIrrigationThreshold,
                        errorText:
                            _.modelMatricPotential.errorSetIrrigationThreshold,
                      ),
                      SizedBox(height: 25),
                      Column(
                        //
                        children: [
                          Text(
                            'Establezca la hora para iniciar el riego automático:',
                            style: TextStyle(fontSize: 10),
                          ),
                          SizedBox(
                              height: 10), //! Para setear la hora de la alarma
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              DropdownButton(
                                  //* Horas para la configuración de la alarma
                                  value: _
                                      .modelMatricPotential.hoursIrrigationTime,
                                  items: MATRIC_POTENTIAL_CONSTANTS.hours
                                      .map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value.toString(),
                                      child: Text('$value'),
                                    );
                                  }).toList(),
                                  onChanged: (v) {
                                    _.modelMatricPotential.hoursIrrigationTime =
                                        v;
                                  }),
                              SizedBox(width: 12),
                              Text(
                                ':',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(width: 12),
                              DropdownButton(
                                  //* MInutos para la configuración de la alarma
                                  value: _.modelMatricPotential
                                      .minutesIrrigationTime,
                                  items: MATRIC_POTENTIAL_CONSTANTS.minutes
                                      .map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value.toString(),
                                      child: Text('$value'),
                                    );
                                  }).toList(),
                                  onChanged: (v) {
                                    _.modelMatricPotential
                                        .minutesIrrigationTime = v;
                                  }),
                              SizedBox(width: 50),
                              CircularButton(
                                  icon: FontAwesomeIcons.angleRight,
                                  onPressed: () => _.bleApiSetIrrigationAlarm())
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Seleccione dos sensores para iniciar el riego automático:',
                            style: TextStyle(fontSize: 10),
                          ),
                          SizedBox(height: 10),
                          Column(
                            children: MATRIC_POTENTIAL_CONSTANTS
                                .GM_SENSOR_MAP.entries
                                .map((e) {
                              //print(e.key);
                              return CheckboxListTile(
                                  title: Text(e.value,
                                      style: TextStyle(fontSize: 13)),
                                  value: (int.parse(pow(2, (e.key - 1))
                                                  .toString()) &
                                              _.modelMatricPotential
                                                  .setSensorsForIrrigation) ==
                                          0
                                      ? false
                                      : true,
                                  onChanged: (v) {
                                    int cont = 0;
                                    String bytes = _.modelMatricPotential
                                        .setSensorsForIrrigation
                                        .toRadixString(2)
                                        .toString();

                                    for (int i = 0; i < bytes.length; i++) {
                                      if (bytes[i] == '1') {
                                        cont++;
                                      }
                                    }

                                    if (cont < 2 &&
                                        _.modelMatricPotential
                                                .setSensorsForIrrigation !=
                                            pow(2, (e.key - 1))) {
                                      _.modelMatricPotential
                                              .setSensorsForIrrigation |=
                                          ((int.parse(
                                              pow(2, (e.key - 1)).toString())));
                                      cont++;
                                    } else {
                                      _.modelMatricPotential
                                              .setSensorsForIrrigation &=
                                          (~(int.parse(
                                              pow(2, (e.key - 1)).toString())));
                                      cont--;
                                    }

                                    if (cont == 2) {
                                      print('Estoy enviando todo al MCU');
                                      _.bleApiSetSensorForIrrgation();
                                    }
                                  });
                            }).toList(),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
