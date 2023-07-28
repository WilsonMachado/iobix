import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'multipurpose_rs485_tab_controller.dart';
import '../../../../theme/color_theme.dart';
import '../../../../theme/text_theme.dart';
import '../../../../utils/constants/ble_api/ble_general_constants.dart';
import '../../../../widgets/circular_indicator_card.dart';
import '../../../../widgets/custom_linear_indicator.dart';
import '../../../../widgets/default_card.dart';
import '../../../../widgets/horizontal_indicator_card.dart';
import '../../../../widgets/information_card.dart';

class SoilSensorGemhoCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MultipurposeRS485TabController>(
        builder: (_) => Column(
              children: [
                Obx(() => DefaultCard(
                    color: Colors.lightBlue[50],
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Sensor de suelo (GEMHO)', style: miniTitle),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Estado del sensor: '),
                              Text(
                                  BLE_GENERAL_CONSTANTS.STATUS[_
                                      .modelMultipurposeRS485
                                      .soilSensorGemhoStatus],
                                  style: textInfoBold)
                            ],
                          )
                        ]))),
                Obx(() {
                  return _.modelMultipurposeRS485.soilSensorGemhoStatus ==
                          BLE_GENERAL_CONSTANTS.STATUS_OK
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CircularIndicatorCard(
                                      title: 'Humedad',
                                      radiusSize: 54,
                                      value: _.modelMultipurposeRS485
                                          .soilSensorGemhoHumidity,
                                      unit: ' %',
                                      progressColor: Colors.lightBlue,
                                      icon: FontAwesomeIcons.droplet),
                                ),
                                Expanded(
                                  child: HorizontalIndicatorCard(
                                      title: 'temperature'.tr,
                                      value: _.modelMultipurposeRS485
                                          .soilSensorGemhoTemperature,
                                      digits: 1,
                                      unit: ' °C',
                                      icon: FontAwesomeIcons
                                          .temperatureThreeQuarters),
                                ),
                              ],
                            ),
                            InformationCard(
                                iconMain: FontAwesomeIcons.atom,
                                title: 'Componentes quimicos',
                                content: [
                                  SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                              _.modelMultipurposeRS485
                                                  .soilSensorGemhoPh
                                                  .toStringAsFixed(2),
                                              style: variableIndicator),
                                          Text('PH',
                                              style: variableIndicatorUnit)
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                              _.modelMultipurposeRS485
                                                  .soilSensorGemhoElectroconductivity
                                                  .toString(),
                                              style: variableIndicator),
                                          Text('Electroconductividad (uS/cm)',
                                              style: variableIndicatorUnit)
                                        ],
                                      ),
                                    ],
                                  ),
                                  CustomLinearPercentIndicator(
                                    title: 'Nitrogeno',
                                    unit: 'mg/kg',
                                    maxValue: 2000,
                                    value: _.modelMultipurposeRS485
                                            .soilSensorGemhoNitrogen *
                                        1.0,
                                    progressColor: Colors.grey,
                                  ),
                                  CustomLinearPercentIndicator(
                                    title: 'Fosforo',
                                    unit: 'mg/kg',
                                    maxValue: 2000,
                                    value: _.modelMultipurposeRS485
                                            .soilSensorGemhoPhosphorus *
                                        1.0,
                                    progressColor: ColorsTheme.lightBlue,
                                  ),
                                  CustomLinearPercentIndicator(
                                    title: 'Potasio',
                                    unit: 'mg/kg',
                                    maxValue: 2000,
                                    value: _.modelMultipurposeRS485
                                            .soilSensorGemhoPotassium *
                                        1.0,
                                    progressColor: ColorsTheme.opaqueBlue,
                                  ),
                                  SizedBox(height: 10)
                                ]),
                            SizedBox(height: 10)
                          ],
                        )
                      : Container();
                })
              ],
            ));
  }
}
