import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import './smart_meter_dc_tab_controller.dart';
import '../../../../widgets/information_card.dart';
import '../../../../widgets/vertical_indicator_card.dart';
import '../../../../data/models/local/model_login.dart';
import '../../../../theme/color_theme.dart';
import '../../../../theme/text_theme.dart';

import './smart_meter_dc_phase_card.dart';

class SmartMeterDcTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartMeterDcTabController>(
        builder: (_) => RefreshIndicator(
              onRefresh: _.bleApiDataReport,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Obx(() => Expanded(
                              child: SmartMeterDcPhaseCard(
                                title: 'Canal 1',
                                voltage: _.modelSmartMeterDc.vdc1,
                                current: _.modelSmartMeterDc.idc1,
                                maxVoltage: 60,
                                maxCurrent: 1000,
                                delta: _.modelSmartMeterDc.delta1,
                                min: _.modelSmartMeterDc.min1,
                                max: _.modelSmartMeterDc.max1,
                              ),
                            )),
                        Obx(() => Expanded(
                              child: SmartMeterDcPhaseCard(
                                title: 'Canal 2',
                                voltage: _.modelSmartMeterDc.vdc2,
                                current: _.modelSmartMeterDc.idc2,
                                maxVoltage: 60,
                                maxCurrent: 1000,
                                delta: _.modelSmartMeterDc.delta2,
                                min: _.modelSmartMeterDc.min2,
                                max: _.modelSmartMeterDc.max2,
                              ),
                            ))
                      ],
                    ),
                    Obx(
                      () => InformationCard(
                        title: 'Sensores externos',
                        iconMain: Icons.info_outline_rounded,
                        content: [
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        _.modelSmartMeterDc.externalTemperature,
                                        style: (_
                                                    .modelSmartMeterDc
                                                    .externalTemperature
                                                    .length <
                                                8)
                                            ? variableIndicator
                                            : TextStyle(
                                                color: ColorsTheme.darkBlue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                    Text('Temperatura (°C)',
                                        style: variableIndicatorUnit)
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        _.modelSmartMeterDc
                                            .externalSupplyStatus,
                                        style: (_
                                                    .modelSmartMeterDc
                                                    .externalSupplyStatus
                                                    .length <
                                                8)
                                            ? variableIndicator
                                            : TextStyle(
                                                color: ColorsTheme.opaqueBlue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                    Text('Adaptador de corriente',
                                        style: variableIndicatorUnit)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        if (ModelLogin.isAdmin())
                          Expanded(
                            child: Obx(
                              () => VerticalIndicatorCard(
                                title: 'Salida DC-DC',
                                value: double.parse(
                                    _.modelSmartMeterDc.dcdcReading),
                                digits: 2,
                                unit: 'V',
                                icon: Icons.power_input_rounded,
                                iconSize: 20,
                              ),
                            ),
                          ),
                        Expanded(
                          child: Obx(
                            () => VerticalIndicatorCard(
                              title: 'Rango de corriente',
                              unit: 'A',
                              digits: 0,
                              value: _.modelSmartMeterDc.getCurrentRange
                                  .toDouble(),
                              icon: FontAwesomeIcons.bolt,
                              iconSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
