import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iobix/app/modules/device/widgets/system_tab/system_tab_controller.dart';
import 'package:iobix/app/modules/device/widgets/temperature_logger_tab/bme280_alarm_params.dart';
import 'package:iobix/app/utils/helpers/helpers.dart';

import './temperature_logger_tab_controller.dart';
import './temperature_card.dart';
import './temperature_abp_sensor.dart';

import '../../../../widgets/i2c_bme280_card.dart';
import '../../../../utils/constants/ble_api/temperature_logger/temperature_logger_constants.dart';

class TemperatureLoggerTabView extends StatelessWidget {
  bool get isFwHigherOrEqual1_0_3 => isFirmwareVersionIsHigherOrEqualThat(
        Get.find<SystemTabController>().modelDeviceInformation.firmware,
        'v1.0.3',
      );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TemperatureLoggerTabController>(
      builder: (_) => RefreshIndicator(
        onRefresh: _.bleApiReloadView,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _.totalNtcSensor,
                  itemBuilder: (__, idx) => Obx(
                        () => TemperatureCard(
                          title:
                              '${'temperature'.tr} (Sensor ${(idx + 1).toString()}) °C',
                          ntc: _.modelTemperatureLogger.ntcData[idx],
                        ),
                      )),
              Obx(() {
                if (_.modelTemperatureLogger.isAbpSensor)
                  return TemperatureAbpSensor(
                    title: 'Presión',
                    pressure: _.modelTemperatureLogger.abpSensorPressure,
                    pressureAdc: _.modelTemperatureLogger.abpSensorPressureAdc,
                    status: TEMPERATURE_LOGGER_CONSTANTS
                        .ABP_SENSOR_STATUS[
                            _.modelTemperatureLogger.abpSensorStatus]
                        .tr,
                  );
                return Container();
              }),
              Obx(() {
                switch (_.modelTemperatureLogger.i2cSensor) {
                  case TEMPERATURE_LOGGER_CONSTANTS.I2C_BME280_SENSOR:
                    return Column(
                      children: [
                        I2cBme280Card(
                          showPressure: true,
                          title: 'BME280 (${'digital_sensor'.tr})',
                          status: _.modelTemperatureLogger.i2cBme280Status.tr,
                          temperature:
                              (_.modelTemperatureLogger.i2cBme280Status == 'Ok')
                                  ? _.modelTemperatureLogger
                                      .i2cBme280Temperature
                                  : '-.--',
                          humidity: _.modelTemperatureLogger.i2cBme280Humidity,
                          pressure:
                              (_.modelTemperatureLogger.i2cBme280Status == 'Ok')
                                  ? _.modelTemperatureLogger.i2cBme280Pressure
                                  : '-.--',
                        ),
                        if (_.modelTemperatureLogger.deviceVersion == 3.0 &&
                            isFwHigherOrEqual1_0_3)
                          Bme280AlarmParams(
                            title: 'Umbrales para alarma digital',
                            tempTH: _.modelTemperatureLogger.ntcData[4],
                            humTH: _.modelTemperatureLogger.ntcData[5],
                          ),
                      ],
                    );
                    break;
                  case TEMPERATURE_LOGGER_CONSTANTS.I2C_SHT31_SENSOR:
                    return Column(
                      children: [
                        I2cBme280Card(
                            showPressure: false,
                            title: 'SHT31 (${'digital_sensor'.tr})',
                            status: _.modelTemperatureLogger.i2cBme280Status,
                            temperature: (_.modelTemperatureLogger
                                        .i2cBme280Status ==
                                    'Ok')
                                ? _.modelTemperatureLogger.i2cBme280Temperature
                                : '-.--',
                            humidity:
                                (_.modelTemperatureLogger.i2cBme280Status ==
                                        'Ok')
                                    ? _.modelTemperatureLogger.i2cBme280Humidity
                                    : '0',
                            pressure:
                                _.modelTemperatureLogger.i2cBme280Pressure),
                        if (_.modelTemperatureLogger.deviceVersion == 3.0 &&
                            isFwHigherOrEqual1_0_3)
                          Bme280AlarmParams(
                            title: 'Umbrales para alarma digital',
                            tempTH: _.modelTemperatureLogger.ntcData[4],
                            humTH: _.modelTemperatureLogger.ntcData[5],
                          ),
                      ],
                    );
                    break;
                  case TEMPERATURE_LOGGER_CONSTANTS.I2C_NOT_SENSOR:
                  default:
                    return Container();
                }
              }),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
