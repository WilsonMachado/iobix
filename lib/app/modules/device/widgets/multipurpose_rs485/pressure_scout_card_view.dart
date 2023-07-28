import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iobix/app/theme/text_theme.dart';

import 'multipurpose_rs485_tab_controller.dart';
import '../../../../widgets/default_card.dart';

class PressureScoutCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MultipurposeRS485TabController>(
        builder: (_) => Obx(() => Column(children: [
              SizedBox(
                height: 8,
              ),
              Obx(() => Row(
                    children: [
                      Text('Gateway Stick Status:'),
                      Spacer(),
                      Text(_.modelMultipurposeRS485.pressureScoutStatus,
                          style: variableIndicatorUnit)
                    ],
                  )),
              SizedBox(
                height: 8,
              ),
              if (_.modelMultipurposeRS485.pressureScoutStatus == 'Ok')
                Obx(() => DefaultCard(
                    color: Colors.lightBlue[50],
                    child: Column(
                      children: [
                        Center(
                          child: Text('Pressure Scout',
                              style: variableIndicatorMini),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          //! voltageSensorScout
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Voltaje del sensor'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.voltageSensorScout ==
                                      0xFFFF)
                                  ? 'Error'
                                  : _.modelMultipurposeRS485.voltageSensorScout
                                      .toString(),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                                (_.modelMultipurposeRS485.voltageSensorScout ==
                                        0xFFFF)
                                    ? ''
                                    : 'mV',
                                style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          //! psiIntSensorScout
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Lectura PSI'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.psiIntSensorScout == -1)
                                  ? 'Error'
                                  : _.modelMultipurposeRS485.psiIntSensorScout
                                      .toString(),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                                (_.modelMultipurposeRS485.psiIntSensorScout ==
                                        -1)
                                    ? ''
                                    : 'PSI',
                                style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          //! psiIntSensorScoutx100
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Lectura PSI x 100'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.psiIntSensorScoutx100 ==
                                      -1)
                                  ? 'Error'
                                  : _.modelMultipurposeRS485
                                      .psiIntSensorScoutx100
                                      .toString(),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                                (_.modelMultipurposeRS485
                                            .psiIntSensorScoutx100 ==
                                        -1)
                                    ? ''
                                    : 'PSI',
                                style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          //! highAlarmSensorScout
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Alarma alta'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.highAlarmSensorScout ==
                                      0xFFFF
                                  ? 'Error'
                                  : (_.modelMultipurposeRS485
                                              .highAlarmSensorScout) ==
                                          0
                                      ? 'Normal'
                                      : '¡Alarma!'),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text('', style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          //! lowAlarmSensorScout
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Alarma baja'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.lowAlarmSensorScout ==
                                      0xFFFF
                                  ? 'Error'
                                  : (_.modelMultipurposeRS485
                                              .lowAlarmSensorScout) ==
                                          0
                                      ? 'Normal'
                                      : '¡Alarma!'),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text('', style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          //! lowBatteryAlarmSensorScout
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Alarma de batería baja'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485
                                          .lowBatteryAlarmSensorScout ==
                                      0xFFFF
                                  ? 'Error'
                                  : (_.modelMultipurposeRS485
                                              .lowBatteryAlarmSensorScout) ==
                                          0
                                      ? 'Bat > 3 V'
                                      : 'Bat < 3 V'),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text('', style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          //! psiRangeSensorScout
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Rango del sensor'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.psiRangeSensorScout ==
                                      0xFFFF)
                                  ? 'Error'
                                  : _.modelMultipurposeRS485.psiRangeSensorScout
                                      .toString(),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                                (_.modelMultipurposeRS485.psiRangeSensorScout ==
                                        0xFFFF)
                                    ? ''
                                    : 'PSI',
                                style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          //! psiStatusSensorScout
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Estado del sensor'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.psiStatusSensorScout ==
                                      0xFFFF
                                  ? 'Error'
                                  : (_.modelMultipurposeRS485
                                              .psiStatusSensorScout) ==
                                          0
                                      ? 'Ok'
                                      : (_.modelMultipurposeRS485
                                                  .psiStatusSensorScout) ==
                                              0
                                          ? 'Out low range'
                                          : 'Out high range'),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text('', style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          //! psiFloatReadingSensorScout
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Lectura PSI del sensor'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485
                                      .psiFloatReadingSensorScout.isNaN)
                                  ? 'Error'
                                  : _.modelMultipurposeRS485
                                      .psiFloatReadingSensorScout
                                      .toString(),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                                (_.modelMultipurposeRS485
                                        .psiFloatReadingSensorScout.isNaN)
                                    ? ''
                                    : 'PSI',
                                style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          //! psiScaleReadingSensorScout
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Escalamiento de la lectura'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485
                                      .psiScaleReadingSensorScout.isNaN)
                                  ? 'Error'
                                  : _.modelMultipurposeRS485
                                      .psiScaleReadingSensorScout
                                      .toString(),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text('', style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          //! alarmHighThreshold
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Umbral superior de alarma'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.alarmHighThreshold
                                      .isNaN)
                                  ? 'Error'
                                  : _.modelMultipurposeRS485.alarmHighThreshold
                                      .toString(),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                                (_.modelMultipurposeRS485.alarmHighThreshold
                                        .isNaN)
                                    ? ''
                                    : 'PSI',
                                style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          //! alarmLowThreshold
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Umbral inferior de alarma'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.alarmLowThreshold.isNaN)
                                  ? 'Error'
                                  : _.modelMultipurposeRS485.alarmLowThreshold
                                      .toString(),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                                (_.modelMultipurposeRS485.alarmLowThreshold
                                        .isNaN)
                                    ? ''
                                    : 'PSI',
                                style: variableIndicatorUnit),
                          ],
                        ),

                        //
                      ],
                    ))),

              //?_______________________________ Segunda parte de la trama ____________________________________________//
              if (_.modelMultipurposeRS485.pressureScoutStatus == 'Ok')
                Obx(
                  () => DefaultCard(
                      color: Colors.lightBlue[50],
                      child: Column(
                        children: [
                          Row(
                            //! MainRevisionNumber
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Número de revisión principal'),
                              Spacer(),
                              Text(
                                ((_.modelMultipurposeRS485
                                                .mainCardTopRevisionNumber ==
                                            0xFFFF) ||
                                        (_.modelMultipurposeRS485
                                                .mainCardBotRevisionNumber) ==
                                            0xFFFF)
                                    ? 'Error'
                                    : ((_.modelMultipurposeRS485
                                            .mainCardTopRevisionNumber
                                            .toString() +
                                        '.' +
                                        (_.modelMultipurposeRS485
                                                .mainCardBotRevisionNumber)
                                            .toString())),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text('', style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            //! RadioRevisionNumber
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Número de revisión de radio'),
                              Spacer(),
                              Text(
                                ((_.modelMultipurposeRS485
                                                .radioTopRevisionNumber ==
                                            0xFFFF) ||
                                        (_.modelMultipurposeRS485
                                                .radioBotRevisionNumber) ==
                                            0xFFFF)
                                    ? 'Error'
                                    : ((_.modelMultipurposeRS485
                                            .radioTopRevisionNumber
                                            .toString() +
                                        '.' +
                                        (_.modelMultipurposeRS485
                                            .radioBotRevisionNumber
                                            .toString()))),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text('', style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            //! sftsNodeAddress
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Dirección SFTS'),
                              Spacer(),
                              Text(
                                (_.modelMultipurposeRS485.sftsNodeAddress ==
                                        0xFFFFFFFF)
                                    ? 'Error'
                                    : _.modelMultipurposeRS485.sftsNodeAddress
                                        .toString(),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text('', style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            //! modbusAddressSensorScout
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Dirección MODBUS'),
                              Spacer(),
                              Text(
                                (_.modelMultipurposeRS485
                                            .modbusAddressSensorScout ==
                                        0xFFFF)
                                    ? 'Error'
                                    : _.modelMultipurposeRS485
                                        .modbusAddressSensorScout
                                        .toString(),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text('', style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            //! rssiSensorScout
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('RSSI'),
                              Spacer(),
                              Text(
                                (_.modelMultipurposeRS485.rssiSensorScout == -1)
                                    ? 'Error'
                                    : _.modelMultipurposeRS485.rssiSensorScout
                                        .toString(),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                  (_.modelMultipurposeRS485.rssiSensorScout ==
                                          -1)
                                      ? ''
                                      : 'dBm',
                                  style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            //! sensorBatteryVoltage
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Voltaje de batería de sensor'),
                              Spacer(),
                              Text(
                                (_.modelMultipurposeRS485
                                            .sensorBatteryVoltage ==
                                        0xFFFF)
                                    ? 'Error'
                                    : _.modelMultipurposeRS485
                                        .sensorBatteryVoltage
                                        .toString(),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                  (_.modelMultipurposeRS485
                                              .sensorBatteryVoltage ==
                                          0xFFFF)
                                      ? ''
                                      : 'mV',
                                  style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            //! timeToLive
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Tiempo para timeout'),
                              Spacer(),
                              Text(
                                (_.modelMultipurposeRS485.timeToLive == 0xFFFF)
                                    ? 'Error'
                                    : _.modelMultipurposeRS485.timeToLive
                                        .toString(),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                  (_.modelMultipurposeRS485.timeToLive ==
                                          0xFFFF)
                                      ? ''
                                      : 'min',
                                  style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            //! numberOfRegisterCatched
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Registros leídos'),
                              Spacer(),
                              Text(
                                (_.modelMultipurposeRS485
                                            .numberOfRegisterCatched ==
                                        0xFFFF)
                                    ? 'Error'
                                    : _.modelMultipurposeRS485
                                        .numberOfRegisterCatched
                                        .toString(),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text('', style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            //! sensorType
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Tipo de sensor'),
                              Spacer(),
                              Text(
                                (_.modelMultipurposeRS485.sensorType == 0xFFFF)
                                    ? 'Error'
                                    : (_.modelMultipurposeRS485.sensorType ==
                                            56)
                                        ? 'Pressure Scout'
                                        : 'Unknown',
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text('', style: variableIndicatorUnit),
                            ],
                          ),
                        ],
                      )),
                ),
              //! ______________________________ HART SENSOR ______________________________________________
              if (_.modelMultipurposeRS485.pressureScoutStatus == 'Ok')
                Obx(() => DefaultCard(
                    color: Colors.lightBlue[50],
                    child: Column(
                      children: [
                        Center(
                          child: Text('HART Sentinel Sensor',
                              style: variableIndicatorMini),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          // hartMfgID
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('ID MFG del sensor'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.hartMfgID == 0xFF)
                                  ? 'Error'
                                  : _.modelMultipurposeRS485.hartMfgID
                                      .toString(),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text('', style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          // hartDeviceType
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Tipo de dispositivo HART'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.hartDeviceType == 0xFF)
                                  ? 'Error'
                                  : _.modelMultipurposeRS485.hartDeviceType
                                      .toString(),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text('', style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          // hartDeviceId
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('ID HART'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.hartDeviceId ==
                                      0xFFFFFF)
                                  ? 'Error'
                                  : _.modelMultipurposeRS485.hartDeviceId
                                      .toString(),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text('', style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          // hartStatus
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Estado del sensor HART'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.hartStatus == 0xFF)
                                  ? 'Error'
                                  : _.modelMultipurposeRS485.hartStatus
                                      .toString(),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text('', style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          // hartPv
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Variable primaria'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.hartPv.isNaN)
                                  ? 'Error'
                                  : _.modelMultipurposeRS485.hartPv.toString(),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                                ((_.modelMultipurposeRS485.hartPvUnitsCode ==
                                        32)
                                    ? '°C'
                                    : (_.modelMultipurposeRS485
                                                .hartPvUnitsCode ==
                                            0xFF)
                                        ? ''
                                        : 'und'),
                                style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          // hartSv
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Variable secundaria'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.hartSv.isNaN)
                                  ? 'Error'
                                  : _.modelMultipurposeRS485.hartSv.toString(),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                                ((_.modelMultipurposeRS485.hartSvUnitsCode ==
                                        32)
                                    ? '°C'
                                    : (_.modelMultipurposeRS485
                                                .hartSvUnitsCode ==
                                            0xFF)
                                        ? ''
                                        : 'und'),
                                style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          // hartTv
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Variable terciaria'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.hartTv.isNaN)
                                  ? 'Error'
                                  : _.modelMultipurposeRS485.hartTv.toString(),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                                ((_.modelMultipurposeRS485.hartTvUnitsCode ==
                                        32)
                                    ? '°C'
                                    : (_.modelMultipurposeRS485
                                                .hartTvUnitsCode ==
                                            0xFF)
                                        ? ''
                                        : 'und'),
                                style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          // hartQv
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Variable cuaternaria'),
                            Spacer(),
                            Text(
                              (_.modelMultipurposeRS485.hartQv.isNaN)
                                  ? 'Error'
                                  : _.modelMultipurposeRS485.hartQv.toString(),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                                ((_.modelMultipurposeRS485.hartQvUnitsCode ==
                                        32)
                                    ? '°C'
                                    : (_.modelMultipurposeRS485
                                                .hartQvUnitsCode ==
                                            0xFF)
                                        ? ''
                                        : 'und'),
                                style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          // hartCommunicationStatus
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Estado de comunicación HART'),
                            Spacer(),
                            Text(
                              ((_.modelMultipurposeRS485
                                          .hartCommunicationStatus) ==
                                      1
                                  ? 'Ok'
                                  : 'Error'),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text('', style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          // hartAlarmHighAlert
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Alerta alta HART'),
                            Spacer(),
                            Text(
                              ((_.modelMultipurposeRS485.hartAlarmHighAlert) ==
                                      0xFFFF
                                  ? 'Error'
                                  : (_.modelMultipurposeRS485
                                              .hartAlarmHighAlert) ==
                                          0
                                      ? 'Normal'
                                      : '¡Alarma!'),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text('', style: variableIndicatorUnit),
                          ],
                        ),
                        Row(
                          // hartAlarmLowAlert
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('Alerta baja HART'),
                            Spacer(),
                            Text(
                              ((_.modelMultipurposeRS485.hartAlarmLowAlert) ==
                                      0xFFFF
                                  ? 'Error'
                                  : (_.modelMultipurposeRS485
                                              .hartAlarmLowAlert) ==
                                          0
                                      ? 'Normal'
                                      : '¡Alarma!'),
                              style: variableIndicatorMini,
                            ),
                            SizedBox(width: 5.0),
                            Text('', style: variableIndicatorUnit),
                          ],
                        ),

                        //
                      ],
                    ))),

              //?_______________________________ Segunda parte de la trama HART ____________________________________________//
              if (_.modelMultipurposeRS485.pressureScoutStatus == 'Ok')
                Obx(
                  () => DefaultCard(
                      color: Colors.lightBlue[50],
                      child: Column(
                        children: [
                          Row(
                            // sentinelStatus
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Estado del Sentinel'),
                              Spacer(),
                              Text(
                                _.modelMultipurposeRS485.sentinelStatus
                                    .toString(),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text('', style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            // hartMainCardRevisionNumber
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Número de revisión principal'),
                              Spacer(),
                              Text(
                                ((_.modelMultipurposeRS485
                                                .hartMainCardTopRevisionNumber ==
                                            0xFFFF) ||
                                        (_.modelMultipurposeRS485
                                                .hartMainCardBotRevisionNumber) ==
                                            0xFFFF)
                                    ? 'Error'
                                    : ((_.modelMultipurposeRS485
                                            .hartMainCardTopRevisionNumber
                                            .toString() +
                                        '.' +
                                        (_.modelMultipurposeRS485
                                                .hartMainCardBotRevisionNumber)
                                            .toString())),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text('', style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            // hartRadioRevisionNumber
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Número de revisión de radio'),
                              Spacer(),
                              Text(
                                ((_.modelMultipurposeRS485
                                                .hartRadioTopRevisionNumber ==
                                            0xFFFF) ||
                                        (_.modelMultipurposeRS485
                                                .hartRadioBotRevisionNumber) ==
                                            0xFFFF)
                                    ? 'Error'
                                    : ((_.modelMultipurposeRS485
                                            .hartRadioTopRevisionNumber
                                            .toString()) +
                                        '.' +
                                        (_.modelMultipurposeRS485
                                            .hartRadioBotRevisionNumber
                                            .toString())),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text('', style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            // hartSftsNodeAddress
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Dirección SFTS'),
                              Spacer(),
                              Text(
                                (_.modelMultipurposeRS485.hartSftsNodeAddress ==
                                        0xFFFFFFFF)
                                    ? 'Error'
                                    : _.modelMultipurposeRS485
                                        .hartSftsNodeAddress
                                        .toString(),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text('', style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            // hartModbusAddressSensorScout
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Dirección MODBUS'),
                              Spacer(),
                              Text(
                                (_.modelMultipurposeRS485
                                            .hartModbusAddressSensorScout ==
                                        0xFFFF)
                                    ? 'Error'
                                    : _.modelMultipurposeRS485
                                        .hartModbusAddressSensorScout
                                        .toString(),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text('', style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            // hartRssiSensorScout
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('RSSI'),
                              Spacer(),
                              Text(
                                (_.modelMultipurposeRS485.hartRssiSensorScout ==
                                        -1)
                                    ? 'Error'
                                    : _.modelMultipurposeRS485
                                        .hartRssiSensorScout
                                        .toString(),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                  (_.modelMultipurposeRS485
                                              .hartRssiSensorScout ==
                                          -1)
                                      ? ''
                                      : 'dBm',
                                  style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            // hartSensorBatteryVoltage
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Batería del sensor'),
                              Spacer(),
                              Text(
                                (_.modelMultipurposeRS485
                                            .hartSensorBatteryVoltage ==
                                        0xFFFF)
                                    ? 'Error'
                                    : _.modelMultipurposeRS485
                                        .hartSensorBatteryVoltage
                                        .toString(),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                  (_.modelMultipurposeRS485
                                              .hartSensorBatteryVoltage ==
                                          0xFFFF)
                                      ? ''
                                      : 'mV',
                                  style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            // hartTimeToLive
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Tiempo para timeout'),
                              Spacer(),
                              Text(
                                (_.modelMultipurposeRS485.hartTimeToLive ==
                                        0xFFFF)
                                    ? 'Error'
                                    : _.modelMultipurposeRS485.hartTimeToLive
                                        .toString(),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              SizedBox(width: 5.0),
                              Text(
                                  (_.modelMultipurposeRS485.hartTimeToLive ==
                                          0xFFFF)
                                      ? ''
                                      : 'min',
                                  style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            // hartNumberOfRegisterCatched
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Registros leídos'),
                              Spacer(),
                              Text(
                                (_.modelMultipurposeRS485
                                            .hartNumberOfRegisterCatched ==
                                        0xFFFF)
                                    ? 'Error'
                                    : _.modelMultipurposeRS485
                                        .hartNumberOfRegisterCatched
                                        .toString(),
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text('', style: variableIndicatorUnit),
                            ],
                          ),
                          Row(
                            // hartSensorType
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Tipo de sensor'),
                              Spacer(),
                              Text(
                                (_.modelMultipurposeRS485.hartSensorType ==
                                        0xFFFF)
                                    ? 'Error'
                                    : (_.modelMultipurposeRS485
                                                .hartSensorType ==
                                            43)
                                        ? 'HART'
                                        : 'Undefined',
                                style: variableIndicatorMini,
                              ),
                              SizedBox(width: 5.0),
                              Text('', style: variableIndicatorUnit),
                            ],
                          ),
                          //
                        ],
                      )),
                ),
            ])));
  }
}
