import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iobix/app/utils/helpers/ble_api/ble_api_matric_potential.dart';

import '../../../../theme/text_theme.dart';
import '../../../../theme/color_theme.dart';
import '../../../../widgets/circular_indicator_card.dart';
import '../../../../widgets/horizontal_indicator_card.dart';
import '../../../../widgets/information_card.dart';
import '../../../../widgets/vertical_indicator_card.dart';
import 'vantage_logger_tab_wind_card.dart';
import 'vantage_logger_tab_controller.dart';

class VantageLoggerTabView extends StatelessWidget {
  const VantageLoggerTabView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VantageLoggerTabController>(
        builder: (_) => (_.modelVantageLogger.deviceVersion == 2.0)
            ? SingleChildScrollView(
                child: Column(children: [
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => VantageLoggerTabWindCard(
                          unitSpeed: (_.modelVantageLogger.deviceVersion == 2.0)
                              ? 'mph'
                              : 'km/h',
                          title: 'wind'.tr,
                          direction: _.modelVantageLogger.windDirection,
                          speed: _.modelVantageLogger.windSpeed,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Obx(
                      () => CircularIndicatorCard(
                          title: 'humidity'.tr,
                          radiusSize: 60.0,
                          value: _.modelVantageLogger.humidity,
                          digits: 1,
                          unit: ' %',
                          progressColor: ColorsTheme.opaqueBlue,
                          icon: FontAwesomeIcons.droplet),
                    ),
                    Expanded(
                      child: Obx(
                        () => HorizontalIndicatorCard(
                            title: 'temperature'.tr,
                            value: _.modelVantageLogger.temperature,
                            digits: 1,
                            unit: ' °C',
                            icon: FontAwesomeIcons.temperatureThreeQuarters),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => VerticalIndicatorCard(
                          title: 'precipitation'.tr,
                          titleStyle: textInfoMiniBold,
                          value: (_.isPrecipitationVariable)
                              ? _.modelVantageLogger.rainCount * 0.01

                              ///! inches
                              : _.modelVantageLogger.rainCount * 0.2,

                          ///! mm
                          digits: 2,
                          unit: _.precipitationVariableUnit,
                          icon: FontAwesomeIcons.cloudRain,
                          showButton: true,
                          onPressed: _.changeMgVariable,
                          textButton: (_.isPrecipitationVariable) ? 'mm' : 'in',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => VerticalIndicatorCard(
                            title: 'radiation'.tr,
                            value: _.modelVantageLogger.solarRadiation,
                            unit: 'W/m²',
                            icon: FontAwesomeIcons.sun),
                      ),
                    ),
                    Obx(
                      () => VerticalIndicatorCard(
                          title: 'UV',
                          value: _.modelVantageLogger.uvIndex,
                          digits: 1,
                          unit: 'index'.tr,
                          icon: Icons.wb_sunny_rounded),
                    ),
                  ],
                )
              ]))
            : RefreshIndicator(
                onRefresh: _.getInstantValues,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => VantageLoggerTabWindCard(
                                      unitSpeed:
                                          (_.modelVantageLogger.deviceVersion ==
                                                  2.0)
                                              ? 'mph'
                                              : 'km/h',
                                      title: 'wind'.tr,
                                      direction:
                                          _.modelVantageLogger.windDirection,
                                      speed: _.modelVantageLogger.windSpeed,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Obx(
                                  () => CircularIndicatorCard(
                                      title: 'humidity'.tr,
                                      radiusSize: 60.0,
                                      value: _.modelVantageLogger.humidity,
                                      digits: 1,
                                      unit: ' %',
                                      progressColor: ColorsTheme.opaqueBlue,
                                      icon: FontAwesomeIcons.droplet),
                                ),
                                Expanded(
                                  child: Obx(
                                    () => HorizontalIndicatorCard(
                                        title: 'temperature'.tr,
                                        value: _.modelVantageLogger.temperature,
                                        digits: 1,
                                        unit: ' °C',
                                        icon: FontAwesomeIcons
                                            .temperatureThreeQuarters),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => VerticalIndicatorCard(
                                      title: 'precipitation'.tr,
                                      titleStyle: textInfoMiniBold,
                                      value: (_.isPrecipitationVariable)
                                          ? _.modelVantageLogger.rainCount *
                                              0.01

                                          ///! inches
                                          : _.modelVantageLogger.rainCount *
                                              0.2,

                                      ///! mm
                                      digits: 2,
                                      unit: _.precipitationVariableUnit,
                                      icon: FontAwesomeIcons.cloudRain,
                                      showButton: true,
                                      onPressed: _.changeMgVariable,
                                      textButton: (_.isPrecipitationVariable)
                                          ? 'mm'
                                          : 'in',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Obx(
                                    () => VerticalIndicatorCard(
                                        title: 'radiation'.tr,
                                        value:
                                            _.modelVantageLogger.solarRadiation,
                                        unit: 'W/m²',
                                        icon: FontAwesomeIcons.sun),
                                  ),
                                ),
                                Obx(
                                  () => VerticalIndicatorCard(
                                      title: 'UV',
                                      value: _.modelVantageLogger.uvIndex,
                                      digits: 1,
                                      unit: 'index'.tr,
                                      icon: Icons.wb_sunny_rounded),
                                ),
                              ],
                            ),

                            ///! Datos instantáneos de la calidad del aire
                            (_.modelVantageLogger.deviceVersion == 3.0)
                                ? SizedBox(height: 8.0)
                                : Container(),
                            (_.modelVantageLogger.deviceVersion == 3.0)
                                ? Obx(
                                    () => InformationCard(
                                        iconMain: FontAwesomeIcons.paperPlane,
                                        title:
                                            "Datos instantáneos de calidad del aire",
                                        reloadFnc: null,
                                        content: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('PM1.0 [µg/m³]',
                                                  style: textInfo),
                                              SizedBox(width: 10.0),
                                              SelectableText(
                                                  _.modelVantageLogger
                                                      .instantPM1_0
                                                      .toString(),
                                                  style: textInfoMiniBold,
                                                  textAlign: TextAlign.right),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('PM2.5 [µg/m³]',
                                                  style: textInfo),
                                              SizedBox(width: 10.0),
                                              SelectableText(
                                                  _.modelVantageLogger
                                                      .instantPM2_5
                                                      .toString(),
                                                  style: textInfoMiniBold),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('PM4.0 [µg/m³]',
                                                  style: textInfo),
                                              SizedBox(width: 10.0),
                                              SelectableText(
                                                  _.modelVantageLogger
                                                      .instantPM4_0
                                                      .toString(),
                                                  style: textInfoMiniBold),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('PM10 [µg/m³]',
                                                  style: textInfo),
                                              SizedBox(width: 10.0),
                                              SelectableText(
                                                  _.modelVantageLogger
                                                      .instantPM10
                                                      .toString(),
                                                  style: textInfoMiniBold),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Humedad relativa [%]',
                                                  style: textInfo),
                                              SizedBox(width: 10.0),
                                              SelectableText(
                                                  _.modelVantageLogger.instantRH
                                                      .toString(),
                                                  style: textInfoMiniBold),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Temperatura [°C]',
                                                  style: textInfo),
                                              SizedBox(width: 10.0),
                                              SelectableText(
                                                  _.modelVantageLogger
                                                      .instantTemp
                                                      .toString(),
                                                  style: textInfoMiniBold),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('VOC', style: textInfo),
                                              SizedBox(width: 10.0),
                                              SelectableText(
                                                  _.modelVantageLogger
                                                      .instantVOC
                                                      .toString(),
                                                  style: textInfoMiniBold),
                                            ],
                                          ),

                                          ///! Aquí terminan los datos instantáneos de la calidad del aire
                                        ]),
                                  )
                                : Container(),

                            ///! Datos instantáneos de sensor de ruido
                            (_.modelVantageLogger.deviceVersion == 3.0)
                                ? SizedBox(height: 8.0)
                                : Container(),
                            (_.modelVantageLogger.deviceVersion == 3.0)
                                ? Obx(
                                    () => InformationCard(
                                        iconMain: FontAwesomeIcons.paperPlane,
                                        title:
                                            "Datos instantáneos de sensor de ruido",
                                        reloadFnc: null,
                                        content: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Sensor Rika [dB]',
                                                  style: textInfo),
                                              SizedBox(width: 10.0),
                                              SelectableText(
                                                  (_.modelVantageLogger
                                                              .instantNoiseRika ==
                                                          0)
                                                      ? 'Sin respuesta del sensor'
                                                      : _.modelVantageLogger
                                                          .instantNoiseRika
                                                          .toString(),
                                                  style: textInfoMiniBold,
                                                  textAlign: TextAlign.right),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Sensor GEMHO [dB]',
                                                  style: textInfo),
                                              SizedBox(width: 10.0),
                                              SelectableText(
                                                  (_.modelVantageLogger
                                                              .instantNoiseGemho ==
                                                          0)
                                                      ? 'Sin respuesta del sensor'
                                                      : _.modelVantageLogger
                                                          .instantNoiseGemho
                                                          .toString(),
                                                  style: textInfoMiniBold),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Sensor PR300 [dB]',
                                                  style: textInfo),
                                              SizedBox(width: 10.0),
                                              SelectableText(
                                                  (_.modelVantageLogger
                                                              .instantNoisePR300 ==
                                                          0)
                                                      ? 'Sin respuesta del sensor'
                                                      : _.modelVantageLogger
                                                          .instantNoisePR300
                                                          .toString(),
                                                  style: textInfoMiniBold),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Sensor Renke [dB]',
                                                  style: textInfo),
                                              SizedBox(width: 10.0),
                                              SelectableText(
                                                  (_.modelVantageLogger
                                                              .instantNoiseRenke ==
                                                          0)
                                                      ? 'Sin respuesta del sensor'
                                                      : _.modelVantageLogger
                                                          .instantNoiseRenke
                                                          .toString(),
                                                  style: textInfoMiniBold),
                                            ],
                                          ),
                                        ]),
                                  )
                                : Container(),

                            (_.modelVantageLogger.deviceVersion == 3.0)
                                ? SizedBox(
                                    height: 8.0,
                                  )
                                : Container(),

                            (_.modelVantageLogger.deviceVersion == 3.0)
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: Obx(
                                          () => InformationCard(
                                              iconMain: Icons.air_sharp,
                                              title:
                                                  "Datos estadísticos de calidad del aire",
                                              reloadFnc:
                                                  _.getAirQualitySensorStats,
                                              content: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text('PM1.0'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [µg/m³]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxPM1_0 ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .maxPM1_0
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),

                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [µg/m³]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minPM1_0 ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .minPM1_0
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            "Promedio [µg/m³]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgPM1_0 ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .avgPM1_0
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Divider(),
                                                    ////////////////////////////////////////////
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text('PM2.5'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [µg/m³]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxPM2_5 ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .maxPM2_5
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [µg/m³]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minPM2_5 ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .minPM2_5
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            "Promedio [µg/m³]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgPM2_5 ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .avgPM2_5
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),

                                                    Divider(),
                                                    ////////////////////////////////////////////
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text('PM4.0'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [µg/m³]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxPM4 ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .maxPM4
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [µg/m³]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minPM4 ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .minPM4
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            "Promedio [µg/m³]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgPM4 ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .avgPM4
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),

                                                    Divider(),
                                                    ////////////////////////////////////////////
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text('PM10'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [µg/m³]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxPM10 ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .maxPM10
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [µg/m³]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minPM10 ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .minPM10
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            "Promedio [µg/m³]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgPM10 ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .avgPM10
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Divider(),
                                                    ////////////////////////////////////////////
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text('Humedad Relativa'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [%]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxRH ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .maxRH
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [%]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minRH ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .minRH
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Promedio [%]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgRH ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .avgRH
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),

                                                    Divider(),
                                                    ////////////////////////////////////////////
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text('Temperatura'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [°C]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxTemp ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .maxTemp
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [°C]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minTemp ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .minTemp
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Promedio [°C]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgTemp ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .avgTemp
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),

                                                    Divider(),
                                                    ////////////////////////////////////////////
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text('VOC'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [VOC]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxVOC ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .maxVOC
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [VOC]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minVOC ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .minVOC
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Promedio [VOC]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgVOC) ==
                                                                    -1
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .avgVOC
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),

                                                    ///! Aquí terminan los datos estadísiticos de calidad del aire
                                                  ],
                                                )
                                              ]),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),

                            ///! Datos estadísiticos de la estación meteorológica
                            (_.modelVantageLogger.deviceVersion == 3.0)
                                ? SizedBox(height: 8.0)
                                : Container(),
                            (_.modelVantageLogger.deviceVersion == 3.0)
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: Obx(
                                          () => InformationCard(
                                              iconMain: Icons.sunny_snowing,
                                              title:
                                                  "Datos estadísticos de la estación meteorológica",
                                              reloadFnc: _.getDavisStats,
                                              content: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text('Radiación Solar'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [W/m²]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxSolarRad ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .maxSolarRad
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),

                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [W/m²]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minSolarRad ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .minSolarRad
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Promedio [W/m²]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgSolarRad ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .avgSolarRad
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Divider(),
                                                    ////////////////////////////////////////////
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                        'Radiación ultravioleta'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [UV]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxUV ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .maxUV
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [UV]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minUV ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .minUV
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Promedio [UV]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgUV ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .avgUV
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),

                                                    Divider(),
                                                    ////////////////////////////////////////////
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text('Temperatura'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [°C]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxTempDavis ==
                                                                    -40.1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .maxTempDavis
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [°C]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minTempDavis ==
                                                                    -40.1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .minTempDavis
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Promedio [°C]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgTempDavis ==
                                                                    -40.1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .avgTempDavis
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),

                                                    Divider(),
                                                    ////////////////////////////////////////////
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text('Humedad Relativa'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [%]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxRHDavis ==
                                                                    -2.05)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .maxRHDavis
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [%]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minRHDavis ==
                                                                    -2.05)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .minRHDavis
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Promedio [%]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgRHDavis ==
                                                                    -2.05)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .avgRHDavis
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Divider(),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            "Acumulado de pluviómetro:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .accPluv ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .accPluv
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),

                                                    Divider(),
                                                    ////////////////////////////////////////////
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                        'Velocidad del viento'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [km/h]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxWindSpeed ==
                                                                    -1)
                                                                ? "No data"
                                                                : (roundDouble(
                                                                        1.60934 *
                                                                            (_.modelVantageLogger
                                                                                .maxWindSpeed),
                                                                        2))
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [km/h]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minWindSpeed ==
                                                                    -1)
                                                                ? "No data"
                                                                : (roundDouble(
                                                                        1.60934 *
                                                                            (_.modelVantageLogger
                                                                                .minWindSpeed),
                                                                        2))
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Promedio [km/h]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgWindSpeed ==
                                                                    -1)
                                                                ? "No data"
                                                                : (roundDouble(
                                                                        1.60934 *
                                                                            (_.modelVantageLogger
                                                                                .avgWindSpeed),
                                                                        2))
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),

                                                    Divider(),
                                                    ////////////////////////////////////////////
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                        'Dirección del viento'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [°]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxWindDirection ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .maxWindDirection
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [°]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minWindDirection ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .minWindDirection
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Promedio [°]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgWindDirection ==
                                                                    -1)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .avgWindDirection
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ]),
                                        ),
                                      ),
                                    ],
                                  )

                                ///! Aquí terminan los datos estadísiticos de la estación meteorológica
                                : Container(),

                            ///! Datos estadísiticos de los sensores RS485
                            (_.modelVantageLogger.deviceVersion == 3.0)
                                ? SizedBox(height: 8.0)
                                : Container(),
                            (_.modelVantageLogger.deviceVersion == 3.0)
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: Obx(
                                          () => InformationCard(
                                              iconMain: Icons.sunny_snowing,
                                              title:
                                                  "Datos estadísticos de los sensores de ruido RS485",
                                              reloadFnc: _.getRS485SensorStats,
                                              content: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text('Sensor Rika'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [dB]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxNoiseRika ==
                                                                    0)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .maxNoiseRika
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [dB]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minNoiseRika ==
                                                                    0)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .minNoiseRika
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Promedio [dB]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgNoiseRika ==
                                                                    0)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .avgNoiseRika
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Divider(),
                                                    Text('Sensor GEMHO'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [dB]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxNoiseGemho ==
                                                                    0)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .maxNoiseGemho
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [dB]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minNoiseGemho ==
                                                                    0)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .minNoiseGemho
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Promedio [dB]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgNoiseGemho ==
                                                                    0)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .avgNoiseGemho
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Divider(),
                                                    Text('Sensor PR300'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [dB]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxNoisePR300 ==
                                                                    0)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .maxNoisePR300
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [dB]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minNoisePR300 ==
                                                                    0)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .minNoisePR300
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Promedio [dB]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgNoisePR300 ==
                                                                    0)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .avgNoisePR300
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Divider(),
                                                    Text('Sensor Renke'),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Máximo [dB]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .maxNoiseRenke ==
                                                                    0)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .maxNoiseRenke
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Mínimo [dB]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .minNoiseRenke ==
                                                                    0)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .minNoiseRenke
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Promedio [dB]:",
                                                            style: textInfo),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                            (_.modelVantageLogger
                                                                        .avgNoiseRenke ==
                                                                    0)
                                                                ? "No data"
                                                                : _.modelVantageLogger
                                                                    .avgNoiseRenke
                                                                    .toString(),
                                                            style:
                                                                textInfoBold),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ]),
                                        ),
                                      ),
                                    ],
                                  )

                                ///! Aquí terminan los datos estadísiticos de los sensores RS485
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
