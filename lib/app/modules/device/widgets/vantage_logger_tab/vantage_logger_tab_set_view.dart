import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iobix/app/data/models/local/model_login.dart';
import 'package:iobix/app/theme/text_theme.dart';
import 'package:iobix/app/utils/constants/ble_api/vantage_logger/vantage_logger_constants.dart';
import 'package:iobix/app/utils/constants/enums.dart';
import 'package:iobix/app/widgets/custom_dropdown/custom_dropdown.dart';
import 'package:iobix/app/widgets/feature_set_textfield.dart';
import 'package:iobix/app/widgets/features_set_card.dart';
import 'package:iobix/app/widgets/normal_button.dart';

import 'vantage_logger_tab_controller.dart';

class VantageLoggerTabSetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VantageLoggerTabController>(
        builder: (_) => Column(children: [
              SingleChildScrollView(
                  child: Column(children: [
                (ModelLogin.isRole(Roles.superAdmin))
                    ? Obx(
                        () => FeaturesSetCard(
                          title: 'Selección de sensores RS485',
                          iconMain: FontAwesomeIcons.pencil,
                          widgetFeatures: Column(
                            children: [
                              SizedBox(height: 10),
                              Column(
                                children: VANTAGE_LOGGER_CONSTANTS_V3
                                    .RS485_SENSOR_MAP.entries
                                    .map((e) {
                                  //print(e.key);
                                  return CheckboxListTile(
                                      title: Text(e.value,
                                          style: TextStyle(fontSize: 11)),
                                      value: (int.parse(pow(2, (e.key - 1))
                                                      .toString()) &
                                                  _.modelVantageLogger
                                                      .sensorsRS485) ==
                                              0
                                          ? false
                                          : true,
                                      onChanged: (v) {
                                        (v)
                                            ? _.modelVantageLogger
                                                    .sensorsRS485 +=
                                                (pow(2, (e.key - 1)))
                                            : _.modelVantageLogger
                                                    .sensorsRS485 -=
                                                (pow(2, (e.key - 1)));

                                        _.setRS485Devices(
                                            _.modelVantageLogger.sensorsRS485);
                                      });
                                }).toList(),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),

                Obx(
                  () => FeaturesSetCard(
                      title: 'Configuración de alimentación de sensores RS485',
                      iconMain: FontAwesomeIcons.batteryFull,
                      widgetFeatures: Column(children: [
                        SizedBox(
                          height: 10,
                        ),
                        CustomDropdown(
                            showSetButton: false,
                            onPressedSet: () {},
                            itemsMap:
                                VANTAGE_LOGGER_CONSTANTS_V3.SENSOR_TYPE_MAP,
                            onChanged: (int k) {
                              _.modelVantageLogger
                                  .selectedSensorPowerBehaviour = k;
                              _.getSensorPowerBehaviour();
                            },
                            floatingLabel: 'Sensor',
                            errorText: '',
                            dropdownTitle: 'select'.tr,
                            dropdownSubtitle:
                                'Seleccione un sensor para cambiar su forma de alimentación',
                            value: VANTAGE_LOGGER_CONSTANTS_V3.SENSOR_TYPE_MAP[_
                                .modelVantageLogger
                                .selectedSensorPowerBehaviour],
                            hintText: 'select'.tr),
                        CustomDropdown(
                            showSetButton: true,
                            onPressedSet: () {
                              _.setSpecificSensorPowerBehaviour(
                                  _.modelVantageLogger
                                      .selectedSensorPowerBehaviour,
                                  _.modelVantageLogger
                                      .statusSensorPowerBehaviour);
                            },
                            itemsMap: VANTAGE_LOGGER_CONSTANTS_V3
                                .SENSOR_ENERGY_OPTIONS_MAP,
                            onChanged: (int k) => {
                                  _.modelVantageLogger
                                      .statusSensorPowerBehaviour = k
                                },
                            floatingLabel: 'Opción',
                            errorText: '',
                            dropdownTitle: 'select'.tr,
                            dropdownSubtitle:
                                'Seleccione una forma de alimentación',
                            value: VANTAGE_LOGGER_CONSTANTS_V3
                                    .SENSOR_ENERGY_OPTIONS_MAP[
                                _.modelVantageLogger
                                    .statusSensorPowerBehaviour],
                            hintText: 'select'.tr),
                      ])),
                ),

                ///! Establecer el tiempo desfase entre transmisiones LoRaWAN

                Obx(() => FeaturesSetCard(
                      title: 'Tiempo de desfase para transmisiones LoRaWAN',
                      iconMain: FontAwesomeIcons.screwdriverWrench,
                      widgetFeatures: Column(
                        children: [
                          Text('* Este debe estar entre 0 y 840 segundos',
                              style: textInfoMiniItalic),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Tiempo actual'),
                              Spacer(),
                              Text(
                                  _.modelVantageLogger.sensorRS485Mismatch
                                      .toString(),
                                  style: variableIndicatorMini),
                              SizedBox(width: 5.0),
                              Text('s', style: variableIndicatorUnit)
                            ],
                          ),
                          FeatureSetTextField(
                            labelText: 'Tiempo de desfase',
                            hintText: 's',
                            initialValue: '',
                            maxLength: 3,
                            keyboardType: TextInputType.number,
                            onChangedText: (t) =>
                                _.onChangedSetSensorRS485Mismatch(t),
                            onPressedSet: () => _.setSensorRS485Mismatch(),
                            errorText: _
                                .modelVantageLogger.errorSetSensorRS485Mismatch,
                          )
                        ],
                      ),
                    )),

                (_.isFwHigherOrEqual1_0_15 &&
                        _.modelVantageLogger.deviceVersion == 3.0)
                    ? Obx(() => FeaturesSetCard(
                        title: 'Configuración de limpieza de FAN',
                        iconMain: FontAwesomeIcons.clock,
                        leadingWidget: NormalButton(
                            text: 'Limpiar FAN',
                            onPressed: (!_.isCleaningFAN) ? _.cleanFAN : null),
                        widgetFeatures: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('La limpieza se realiza cada'),
                              Spacer(),
                              Text(_.modelVantageLogger.getHourToCleanFan,
                                  style: variableIndicatorMini),
                              SizedBox(width: 5.0),
                              Text('h', style: variableIndicatorUnit)
                            ],
                          ),
                          SizedBox(height: 8.0),
                          FeatureSetTextField(
                            labelText: 'Tiempo para la limpieza del FAN',
                            hintText: 'h',
                            initialValue: '',
                            maxLength: 3,
                            keyboardType: TextInputType.number,
                            onChangedText: (t) =>
                                _.onChangedSetHourToCleanFan(t),
                            onPressedSet: () => _.setHourToCleanFan(),
                            errorText: _.modelVantageLogger.errorHourToCleanFan,
                          )
                        ])))
                    : Container(),
              ])),
            ]));
  }
}
