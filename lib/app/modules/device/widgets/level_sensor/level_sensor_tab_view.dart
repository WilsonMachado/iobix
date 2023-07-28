import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/i2c_bme280_card.dart';
import '../../../../modules/device/widgets/level_sensor/level_sensor_tab_controller.dart';
import '../../../../theme/text_theme.dart';
import '../../../../utils/constants/ble_api/level_sensor/level_sensor_constants.dart';
import '../../../../widgets/information_card.dart';

class LevelSensorTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LevelSensorTabController>(
      builder: (_) => RefreshIndicator(
        onRefresh: _.bleApiReloadView,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Obx(() => InformationCard(
                      iconMain: Icons.graphic_eq_rounded,
                      title: 'Medición de Nivel',
                      content: [
                        Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              mainAxisAlignment: MainAxisAlignment.start,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(_.modelLevelSensor.getMaxsonarDistance,
                                    style: (_.modelLevelSensor
                                                .getMaxsonarDistance.length >
                                            4)
                                        ? variableIndicatorMini
                                        : variableIndicator),
                                if (_.modelLevelSensor.getMaxsonarDistance
                                        .length <
                                    5)
                                  Text('m', style: variableIndicatorUnit)
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _.modelLevelSensor.getMaxsonarDelta,
                                  style: variableIndicatorUnit,
                                ),
                                Text('Delta')
                              ],
                            ),
                            SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _.modelLevelSensor.getMaxsonarMin,
                                  style: variableIndicatorUnit,
                                ),
                                Text('Min')
                              ],
                            ),
                            SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _.modelLevelSensor.getMaxsonarMax,
                                  style: variableIndicatorUnit,
                                ),
                                Text('Max')
                              ],
                            ),
                          ],
                        ),
                      ])),
              Obx(() {
                switch (_.modelLevelSensor.getI2cSensor) {
                  case LEVEL_SENSOR_CONSTANTS.I2C_BME280_SENSOR:
                    return I2cBme280Card(
                      showPressure: true,
                      title: 'BME280 (${'digital_sensor'.tr})',
                      status: _.modelLevelSensor.i2cBme280Status.tr,
                      temperature: _.modelLevelSensor.i2cBme280Temperature,
                      humidity: _.modelLevelSensor.i2cBme280Humidity,
                      pressure: _.modelLevelSensor.i2cBme280Pressure,
                    );
                  default:
                    return Container();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
