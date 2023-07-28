import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'multipurpose_rs485_tab_controller.dart';
import '../../../../widgets/default_card.dart';
import '../../../../theme/text_theme.dart';
import '../../../../utils/constants/ble_api/ble_general_constants.dart';

class NoiseSensorRenkeCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MultipurposeRS485TabController>(
        builder: (_) => Column(children: [
              Obx(() => DefaultCard(
                    color: Colors.lightBlue[50],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sensor de ruido (RENKE)', style: miniTitle,),
                            Row(
                              children: [
                                Text('Estado del sensor: '),
                                Text(
                                  BLE_GENERAL_CONSTANTS.STATUS[_
                                      .modelMultipurposeRS485
                                      .noiseSensorRenkeStatus],
                                  style: textInfoBold,
                                )
                              ],
                            )
                          ],
                        ),
                        Spacer(),
                        if (_.modelMultipurposeRS485.noiseSensorRenkeStatus ==
                            BLE_GENERAL_CONSTANTS.STATUS_OK)
                          Column(
                            children: [
                              Text(
                                  _.modelMultipurposeRS485
                                      .noiseSensorRenkeNoiseLevel,
                                  style: variableIndicator),
                              Text('Nivel de ruido (dB)',
                                  style: variableIndicatorUnit)
                            ],
                          )
                      ],
                    ),
                  )),
                  SizedBox(height: 10)
            ]));
  }
}
