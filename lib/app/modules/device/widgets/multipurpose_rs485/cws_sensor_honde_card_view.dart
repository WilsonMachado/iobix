import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'multipurpose_rs485_tab_controller.dart';
import '../../../../widgets/default_card.dart';
import '../../../../widgets/circular_indicator_card.dart';
import '../../../../widgets/horizontal_indicator_card.dart';
import '../../../../widgets/vertical_indicator_card.dart';
import '../../../../theme/text_theme.dart';
import '../../../../utils/constants/ble_api/ble_general_constants.dart';

class CwsSensorHondeCardView extends StatelessWidget {
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
                              Text('Estación del clima (HONDE)', style: miniTitle),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Estado del sensor: '),
                              Text(
                                  BLE_GENERAL_CONSTANTS.STATUS[
                                      _.modelMultipurposeRS485.cwsSensorHondeStatus],
                                  style: textInfoBold)
                            ],
                          )
                        ]))),
                Obx(() {
                  return _.modelMultipurposeRS485.cwsSensorHondeStatus ==
                          BLE_GENERAL_CONSTANTS.STATUS_OK
                      ? Column(
                          children: [
                            Row(
                              children: [
                                CircularIndicatorCard(
                                    title: 'Humedad',
                                    radiusSize: 54,
                                    value: _.modelMultipurposeRS485
                                        .cwsSensorHondeHumidity,
                                    unit: ' %',
                                    progressColor: Colors.lightBlue,
                                    icon: FontAwesomeIcons.droplet),
                                Expanded(
                                  child: HorizontalIndicatorCard(
                                      title: 'temperature'.tr,
                                      value: _.modelMultipurposeRS485
                                          .cwsSensorHondeTemperature,
                                  
                                      digits: 1,
                                      unit: ' °C',
                                      icon: FontAwesomeIcons
                                          .temperatureThreeQuarters),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: VerticalIndicatorCard(
                                    title: 'Presión A.',
                                    value: _.modelMultipurposeRS485
                                        .cwsSensorHondePressure,
                                    unit: 'hPa',
                                    icon: FontAwesomeIcons.weightScale,
                                    iconSize: 20,
                                    digits: 1,
                                  ),
                                ),
                                Expanded(
                                  child: VerticalIndicatorCard(
                                    title: 'P. de lluvia',
                                    value: _.modelMultipurposeRS485
                                        .cwsSensorHondeRainFall,
                                    unit: 'mm',
                                    icon: FontAwesomeIcons.cloudShowersHeavy,
                                    iconSize: 20,
                                    digits: 1,
                                  ),
                                ),
                                Expanded(
                                  child: VerticalIndicatorCard(
                                    title: 'Radiación',
                                    value: _.modelMultipurposeRS485
                                        .cwsSensorHondeRadiation.roundToDouble(),
                                    unit: 'W/m2',
                                    icon: FontAwesomeIcons.sun,
                                    iconSize: 20,
                                    digits: 0
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container();
                }),
                SizedBox(height: 10)
              ],
            ));
  }
}
