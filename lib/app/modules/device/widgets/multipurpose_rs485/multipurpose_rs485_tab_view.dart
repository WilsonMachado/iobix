import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iobix/app/modules/device/widgets/multipurpose_rs485/pressure_scout_card_view.dart';

import 'ammonia_sensor_gemho_card_view.dart';
import 'multipurpose_rs485_tab_controller.dart';
import 'noise_sensor_rika_card_view.dart';
import 'noise_sensor_gemho_card_view.dart';
import 'soil_sensor_gemho_card_view.dart';
import 'temphumilux_sensor_gemho_card_view.dart';
import 'cws_sensor_honde_card_view.dart';
import 'noise_sensor_renke_card_view.dart';
import 'particle_sensor_renke_card_view.dart';

class MultipurposeRS485TabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MultipurposeRS485TabController>(
        builder: (_) => RefreshIndicator(
            onRefresh: _.bleApiDataReport,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Obx(() {
                    if (!_.modelMultipurposeRS485.isNoiseSensorRika &&
                        !_.modelMultipurposeRS485.isNoiseSensorGemho &&
                        !_.modelMultipurposeRS485.isAmmoniaSensorGemho &&
                        !_.modelMultipurposeRS485.isTemphumiluxSensorGemho &&
                        !_.modelMultipurposeRS485.isSoilSensorGemho &&
                        !_.modelMultipurposeRS485.isCwsSensorHonde &&
                        !_.modelMultipurposeRS485.isParticleSensorRenke &&
                        !_.modelMultipurposeRS485.isNoiseSensorRenke &&
                        !_.modelMultipurposeRS485.isPressureScout)
                      return Center(
                          child: Text('Obteniendo información ...',
                              style: TextStyle(fontStyle: FontStyle.italic)));
                    else
                      return Container();
                  }),
                  Obx(() {
                    return _.modelMultipurposeRS485.isNoiseSensorRika
                        ? NoiseSensorRikaCardView()
                        : Container();
                  }),
                  Obx(() {
                    return _.modelMultipurposeRS485.isNoiseSensorGemho
                        ? NoiseSensorGemhoCardView()
                        : Container();
                  }),
                  Obx(() {
                    return _.modelMultipurposeRS485.isAmmoniaSensorGemho
                        ? AmmoniaSensorGemhoCardView()
                        : Container();
                  }),
                  Obx(() {
                    return _.modelMultipurposeRS485.isTemphumiluxSensorGemho
                        ? TempHumIluxSensorGemhoCardView()
                        : Container();
                  }),
                  Obx(() {
                    return _.modelMultipurposeRS485.isSoilSensorGemho
                        ? SoilSensorGemhoCardView()
                        : Container();
                  }),
                  Obx(() {
                    return _.modelMultipurposeRS485.isCwsSensorHonde
                        ? CwsSensorHondeCardView()
                        : Container();
                  }),
                  Obx(() {
                    return _.modelMultipurposeRS485.isParticleSensorRenke
                        ? ParticleSensorRenkeCardView()
                        : Container();
                  }),
                  Obx(() {
                    return _.modelMultipurposeRS485.isNoiseSensorRenke
                        ? NoiseSensorRenkeCardView()
                        : Container();
                  }),
                  Obx(() {
                    return _.modelMultipurposeRS485.isPressureScout
                        ? PressureScoutCardView()
                        : Container();
                  }),
                ],
              ),
            )));
  }
}
