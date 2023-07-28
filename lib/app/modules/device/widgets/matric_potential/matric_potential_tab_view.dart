import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iobix/app/widgets/i2c_bme280_card.dart';

import '../../../../utils/helpers/helpers.dart';
import './matric_potential_tab_controller.dart';
import './matric_potential_custom_linear_indicator.dart';
import '../../../../theme/text_theme.dart';
import '../../../../utils/constants/ble_api/matric_potential/matric_potential_constants.dart';
import '../../../../widgets/features_set_card.dart';
import '../../../../widgets/normal_button.dart';
import '../../../../widgets/row_info.dart';
import './pluviometer_widget.dart';
import './temperature_widget.dart';
import './pressure_widget.dart';

class MatricPotentialTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatricPotentialTabController>(
      builder: (_) => RefreshIndicator(
        onRefresh: _.bleApiReloadView,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: FeaturesSetCard(
                      leadingWidget: Obx(() => NormalButton(
                          text: _.mgVariable, onPressed: _.changeMgVariable)),
                      widgetFeatures: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.0),
                          if (_.modelMatricPotential.deviceVersion == 1)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Obx(() => TemperatureWidget(
                                      value: _
                                          .modelMatricPotential.soilTemperature,
                                      desc: 'T. del suelo (°C)',
                                    )),
                                SizedBox(width: 15),
                                Obx(() => Expanded(
                                      child: PluviometerWidget(
                                        value: _.modelMatricPotential.pluv,
                                      ),
                                    )),
                              ],
                            ),
                          if (_.modelMatricPotential.deviceVersion == 4 ||
                              _.modelMatricPotential.deviceVersion == 3.1)
                            Column(
                              children: [
                                Obx(() => PluviometerWidget(
                                    value: _.modelMatricPotential.pluv)),
                                SizedBox(height: 15),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Obx(() => TemperatureWidget(
                                          value: _.modelMatricPotential
                                              .soilTemperature,
                                          desc: 'Canal 1 (°C)',
                                        )),
                                    (!(_.modelMatricPotential.deviceVersion ==
                                            3.1))
                                        ? Obx(() => TemperatureWidget(
                                            value: _.modelMatricPotential
                                                .soilTemperature2,
                                            desc: 'Canal 2 (°C)'))
                                        : Container(),
                                  ],
                                ),
                              ],
                            ),
                          Obx(() {
                            return (!_.isMgVariableRes)
                                ? Column(children: [
                                    SizedBox(height: 8.0),
                                    Text(
                                        '* Los cálculos de las mediciones en unidades de presión, de los sensores conectados, dependen de la temperatura del suelo. Así, cuando el sensor de temperatura del suelo esta desconectado (Canal 1), se toma como referencia 24.0 °C para realizar los cálculos pertinentes',
                                        style: textInfoMiniItalic),
                                  ])
                                : Container();
                          }),
                          SizedBox(height: 15.0),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                (_.modelMatricPotential.mgResistance.length / 2)
                                    .round(),
                            itemBuilder: (__, idx) => Obx(() {
                              int _evenSensor = 2 * idx + 2;
                              int _oddSensor = 2 * idx + 1;

                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: MatricPotentialCustomLinearIndicator(
                                              title: 'Sensor $_oddSensor',
                                              unit: _.mgVariableUnit,
                                              value: (_.isMgVariableRes)
                                                  ? _.modelMatricPotential
                                                          .mgResistance[
                                                      _oddSensor - 1]
                                                  : _.modelMatricPotential
                                                      .mgKpa[_oddSensor - 1],
                                              maxValue: (_.isMgVariableRes)
                                                  ? 100000
                                                  : 300,
                                              progressColor: Colors.blue[300]),
                                        ),
                                        Expanded(
                                          child:
                                              MatricPotentialCustomLinearIndicator(
                                                  customHeight: 25.0,
                                                  title: 'Sensor $_evenSensor',
                                                  unit: _.mgVariableUnit,
                                                  value: (_
                                                          .isMgVariableRes)
                                                      ? _.modelMatricPotential
                                                              .mgResistance[
                                                          _evenSensor - 1]
                                                      : _.modelMatricPotential
                                                              .mgKpa[
                                                          _evenSensor - 1],
                                                  maxValue:
                                                      (_.isMgVariableRes)
                                                          ? 100000
                                                          : 300,
                                                  progressColor:
                                                      Colors.green[300]),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15.0)
                                  ]);
                            }),
                          ),
                          SizedBox(height: 5.0),
                        ],
                      ),
                      iconMain: FontAwesomeIcons.seedling,
                      title: 'Mediciones',
                    ),
                  ),
                ],
              ),
              // Obx(() {
              //   return (_.modelMatricPotential.irrigationStatus)
              //       ?
              //       : Container();
              // }),

              ///? Para el PM V1.

              if (_.modelMatricPotential.deviceVersion == 1)
                Obx(() {
                  return (_.modelMatricPotential.irrigationStatus)
                      ? Row(
                          children: [
                            Expanded(
                                child: FeaturesSetCard(
                              title: 'Electroválvula',
                              iconMain: FontAwesomeIcons.faucet,
                              leadingWidget: NormalButton(
                                  text: (_.modelMatricPotential
                                          .electrovalveStatus)
                                      ? 'Cerrar'
                                      : 'Abrir',
                                  onPressed: (!_.isWorkElectovalve)
                                      ? _.bleApiSetElectrovalveControl
                                      : null),
                              widgetFeatures: Column(children: [
                                if (MATRIC_POTENTIAL_CONSTANTS
                                    .IRRIGATION_CYCLE_MAP
                                    .containsKey(_.modelMatricPotential
                                        .getIrrigationCycleStatus))
                                  Text(
                                      MATRIC_POTENTIAL_CONSTANTS
                                              .IRRIGATION_CYCLE_MAP[
                                          _.modelMatricPotential
                                              .getIrrigationCycleStatus],
                                      style: textInfo,
                                      textAlign: TextAlign.left),
                                SizedBox(height: 12.0),
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                          _.modelMatricPotential
                                                  .electrovalveStatus
                                              ? 'Abierta'
                                              : 'Cerrada',
                                          style: variableIndicator,
                                          textAlign: TextAlign.center),
                                      Text('Estado de la electroválvula',
                                          style: variableIndicatorUnit),
                                      Text(
                                          'Control: ' +
                                              getMapValueByKey(
                                                  MATRIC_POTENTIAL_CONSTANTS
                                                      .ELECTROVALVE_CONTROL_MAP,
                                                  _.modelMatricPotential
                                                      .getElectrovalveControl,
                                                  'Desconocido'),
                                          style: textInfoMiniItalic)
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12.0),
                                RowInfo(
                                    label: 'Tiempo de irrigación (minutos)',
                                    value: _.modelMatricPotential
                                        .getIrrigationTime),
                                RowInfo(
                                    label:
                                        'Tiempo de espera para irrigación (minutos)',
                                    value: _.modelMatricPotential
                                        .getIrrigationWaitTime),
                                RowInfo(
                                    label: 'Umbral para iniciar el riego (kPa)',
                                    value: _.modelMatricPotential
                                        .getPvToStartIrrigation),
                                RowInfo(
                                    label:
                                        'Umbral para finalizar el riego (kPa)',
                                    value: _.modelMatricPotential
                                        .getPvToStopIrrigation),
                                RowInfo(
                                    label:
                                        'Sensor que controla la electroválvula',
                                    value: getMapValueByKey(
                                        MATRIC_POTENTIAL_CONSTANTS
                                            .GM_SENSOR_MAP,
                                        _.modelMatricPotential
                                            .getGmIrrigationControl,
                                        'Desconocido'))
                              ]),
                            )),
                          ],
                        )
                      : Container();
                }),

              ///? Para el PM V3.1
              if (_.modelMatricPotential.deviceVersion == 3.1 &&
                  (_.modelMatricPotential.i2cStatus == 0))
                Column(children: [
                  Obx(() => I2cBme280Card(
                      showPressure: true,
                      title: 'Condiciones dentro del dispositivo',
                      status: (_.modelMatricPotential.i2cStatus == 0)
                          ? 'Ok'
                          : 'Error ${_.modelMatricPotential.i2cStatus}',
                      temperature: (double.tryParse(
                                  _.modelMatricPotential.getSoilTemp) !=
                              null)
                          ? _.modelMatricPotential.getSoilTemp
                          : '0.0',
                      humidity:
                          (int.tryParse(_.modelMatricPotential.getSoilHum) !=
                                  null)
                              ? _.modelMatricPotential.getSoilHum
                              : '0',
                      pressure: (double.tryParse(
                                  _.modelMatricPotential.getSoilElectro) !=
                              null)
                          ? _.modelMatricPotential.getSoilElectro
                          : '0.0')),
                ]),

              SizedBox(height: 5.0),

              ///? Para el PM V4
              if (_.modelMatricPotential.deviceVersion == 4)

                ///! A partir de aquí se deben renderizar los widgets específicos
                Column(
                  children: [
                    _.modelMatricPotential.deviceVariation == 1
                        ? Obx(() => FeaturesSetCard(
                              title: 'Actuador de irrigación',
                              iconMain: FontAwesomeIcons.faucet,
                              leadingWidget: NormalButton(
                                  text: 'Generar pulso',
                                  onPressed: _.bleApiStartIrrigation),
                              widgetFeatures: Column(children: [
                                if (MATRIC_POTENTIAL_CONSTANTS
                                    .IRRIGATION_CYCLE_MAP
                                    .containsKey(_.modelMatricPotential
                                        .getIrrigationCycleStatus))
                                  Text(
                                      MATRIC_POTENTIAL_CONSTANTS
                                              .IRRIGATION_CYCLE_MAP[
                                          _.modelMatricPotential
                                              .getIrrigationCycleStatus],
                                      style: textInfo,
                                      textAlign: TextAlign.left),
                                SizedBox(height: 12.0),
                                RowInfo(
                                    label: 'Umbral para iniciar el riego (kPa)',
                                    value: _.modelMatricPotential
                                        .setIrrigationThreshold),
                                RowInfo(
                                    label: 'Última activación del riego',
                                    value: _.modelMatricPotential
                                        .electrovalveActivationSource),
                                RowInfo(
                                    label: 'Sensores que controlan el riego',
                                    value: _.modelMatricPotential
                                        .gmIrrigationControlSensors),
                                RowInfo(
                                    label: 'Hora establecida para el riego',
                                    value: _.modelMatricPotential
                                        .getIrrigationTime),
                              ]),
                            ))
                        : Container(),
                    SizedBox(height: 5.0),

                    //! Feature Card para los parámetros de el sensor Gemho de suelo

                    _.modelMatricPotential.deviceVariation == 1
                        ? Obx(() => FeaturesSetCard(
                              title: 'Variables del suelo',
                              iconMain: FontAwesomeIcons.arrowUpFromGroundWater,
                              leadingWidget: Container(),
                              widgetFeatures: Column(children: [
                                SizedBox(height: 12.0),
                                RowInfo(
                                    label: 'Temperatura (°C)',
                                    value: _.modelMatricPotential.getSoilTemp),
                                RowInfo(
                                    label: 'Humedad relativa  (%)',
                                    value: _.modelMatricPotential.getSoilHum),
                                RowInfo(
                                    label: 'Electroconductividad (μS/cm)',
                                    value:
                                        _.modelMatricPotential.getSoilElectro),
                                RowInfo(
                                    label: 'pH',
                                    value: _.modelMatricPotential.getSoilpH),
                                RowInfo(
                                    label: 'Nitrógeno (mg/kg)',
                                    value: _.modelMatricPotential.getSoilN),
                                RowInfo(
                                    label: 'Potasio (mg/kg)',
                                    value: _.modelMatricPotential.getSoilK),
                                RowInfo(
                                    label: 'Fósforo (mg/kg)',
                                    value: _.modelMatricPotential.getSoilP),
                              ]),
                            ))
                        : Container(),

                    SizedBox(height: 5.0),

                    _.modelMatricPotential.deviceVariation == 0
                        ? Obx(() => PressureWidget(
                              // Card para las variables de presión
                              units: (_.modelMatricPotential.deviceVersion == 4)
                                  ? 'PSI'
                                  : 'kPa',
                              value1: _.modelMatricPotential.pressure1,
                              value2: _.modelMatricPotential.pressure2,
                              status1: MATRIC_POTENTIAL_CONSTANTS_V4
                                      .PRESSURE_STATUS_SENSOR[
                                  _.modelMatricPotential.pressureStatus1],
                              status2: MATRIC_POTENTIAL_CONSTANTS_V4
                                      .PRESSURE_STATUS_SENSOR[
                                  _.modelMatricPotential.pressureStatus2],
                            ))
                        : Container(),
                  ],
                ),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
