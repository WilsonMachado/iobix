import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'multipurpose_rs485_tab_controller.dart';
import '../../../../theme/color_theme.dart';
import '../../../../theme/text_theme.dart';
import '../../../../utils/constants/ble_api/ble_general_constants.dart';
import '../../../../widgets/circular_indicator_card.dart';
import '../../../../widgets/default_card.dart';
import '../../../../widgets/horizontal_indicator_card.dart';
import '../../../../widgets/custom_linear_indicator.dart';

class TempHumIluxSensorGemhoCardView extends StatelessWidget {
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
                              Text('Sensor de Temp/Hum/Ilum (GEMHO)' , style: miniTitle),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Estado del sensor: '),
                              Text(
                                  BLE_GENERAL_CONSTANTS.STATUS[_
                                      .modelMultipurposeRS485
                                      .temphumiluxSensorGemhoStatus],
                                  style: textInfoBold)
                            ],
                          )
                        ]))),
                Obx(
                  () {
                    return _.modelMultipurposeRS485.temphumiluxSensorGemhoStatus ==
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
                                            .temphumiluxSensorGemhoHumidity,
                                        unit: ' %',
                                        progressColor: Colors.lightBlue,
                                        icon: FontAwesomeIcons.droplet),
                                  ),
                                  Expanded(
                                    child: HorizontalIndicatorCard(
                                        title: 'temperature'.tr,
                                        value: _.modelMultipurposeRS485
                                            .temphumiluxSensorGemhoTemperature,
                                        digits: 1,
                                        unit: ' °C',
                                        icon: FontAwesomeIcons
                                            .temperatureThreeQuarters),
                                  ),
                                ],
                              ),
                              DefaultCard(
                                child: CustomLinearPercentIndicator(
                                  title: 'Iluminancia',
                                  unit: 'lx',
                                  value: _.modelMultipurposeRS485
                                          .temphumiluxSensorGemhoIlluminance *
                                      1.0,
                                  progressColor: ColorsTheme.opaqueBlue,
                                ),
                              ),
                            ],
                          )
                        : Container();
                  },
                ),
                SizedBox(height: 10)
              ],
            ));
  }
}
