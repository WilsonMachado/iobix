import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'multipurpose_rs485_tab_controller.dart';
import '../../../../theme/text_theme.dart';
import '../../../../widgets/default_card.dart';
import '../../../../utils/constants/ble_api/ble_general_constants.dart';

class AmmoniaSensorGemhoCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MultipurposeRS485TabController>(
        builder: (_) => Column(
              children: [
                Obx(
                  () => DefaultCard(
                    color: Colors.lightBlue[50],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sensor de Amoníaco (GEMHO)', style: miniTitle),
                            Row(
                              children: [
                                Text('Estado del sensor: '),
                                Text(
                                    BLE_GENERAL_CONSTANTS.STATUS[_
                                        .modelMultipurposeRS485
                                        .ammoniaSensorGemhoStatus],
                                    style: textInfoBold),
                              ],
                            )
                          ],
                        ),
                        Spacer(),
                        if (_.modelMultipurposeRS485.ammoniaSensorGemhoStatus ==
                            BLE_GENERAL_CONSTANTS.STATUS_OK)
                          Column(
                            children: [
                              Text(_.modelMultipurposeRS485.ammoniaSensorGemhoAmmoniaLevel, style: variableIndicator),
                              Text('N. Amoníaco (ppm)',
                                  style: variableIndicatorUnit)
                            ],
                          )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10)
              ],
            ));
  }
}
