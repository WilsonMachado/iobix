import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'multipurpose_rs485_tab_controller.dart';
import '../../../../utils/constants/ble_api/ble_general_constants.dart';
import '../../../../widgets/default_card.dart';
import '../../../../widgets/information_card.dart';
import '../../../../widgets/custom_linear_indicator.dart';
import '../../../../theme/text_theme.dart';

class ParticleSensorRenkeCardView extends StatelessWidget {
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
                              Text('Sensor de partículas (RENKE)',
                                  style: miniTitle),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Estado del sensor: '),
                              Text(
                                  BLE_GENERAL_CONSTANTS.STATUS[_
                                      .modelMultipurposeRS485
                                      .particleSensorRenkeStatus],
                                  style: textInfoBold)
                            ],
                          )
                        ],
                      ),
                    )),
                Obx(() {
                  return _.modelMultipurposeRS485.particleSensorRenkeStatus ==
                          BLE_GENERAL_CONSTANTS.STATUS_OK
                      ? Column(
                          children: [
                            InformationCard(
                              iconMain: FontAwesomeIcons.atom,
                              title: 'Medición de partículas',
                              content: [
                                SizedBox(height: 8.0),
                                CustomLinearPercentIndicator(
                                  title: 'Partícula 2.5',
                                  unit: 'µg/m³',
                                  maxValue: 70000,
                                  value: _.modelMultipurposeRS485.particleSensorRenkeParticulateMatter2_5.roundToDouble(),
                                  progressColor: Colors.lightBlue,
                                ),
                                CustomLinearPercentIndicator(
                                  title: 'Partícula 10',
                                  unit: 'µg/m³',
                                  maxValue: 70000,
                                  value: _.modelMultipurposeRS485.particleSensorRenkeParticulateMatter10.roundToDouble(),
                                  progressColor: Colors.lightBlue,
                                ),
                                SizedBox(height: 10),
                              ],
                            )
                          ],
                        )
                      : Container();
                }),
                SizedBox(height: 10)
              ],
            ));
  }
}
