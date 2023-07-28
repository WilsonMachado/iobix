import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './smart_meter_ac_tab_controller.dart';
import './smart_meter_ac_phase_card.dart';
import './smart_meter_ac_parameter_card.dart';
import '../../../../widgets/custom_linear_indicator.dart';
import '../../../../theme/color_theme.dart';
import '../../../../modules/device/widgets/smart_meter_ac_tab/smart_meter_ac_debug_card.dart';
import '../../../../widgets/information_card.dart';
import '../../../../theme/text_theme.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../data/models/local/model_login.dart';

class SmartMeterAcTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartMeterAcTabController>(
      builder: (_) => RefreshIndicator(
        onRefresh: _.bleApiDataReport,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SmartMeterAcPhaseCard(),
              Obx(
                () => InformationCard(
                  title: 'Información adicional',
                  iconMain: Icons.info_outline_rounded,
                  content: [
                    CustomLinearPercentIndicator(
                      title: 'Corriente de neutro',
                      unit: 'A',
                      value: double.parse(_.modelSmartMeterAc.getIN),
                      digits: 2,
                      maxValue: 2000.0,
                      progressColor: ColorsTheme.opaqueBlue,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_.modelSmartMeterAc.externalTemperature.tr,
                                  style: (_.modelSmartMeterAc
                                              .externalTemperature.length <
                                          8)
                                      ? variableIndicatorMini
                                      : TextStyle(
                                          color: ColorsTheme.darkBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                              Text('Temperatura externa (°C)',
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
                              Text(_.modelSmartMeterAc.externalSupplyStatus.tr,
                                  style: (_.modelSmartMeterAc
                                              .externalSupplyStatus.length <
                                          8)
                                      ? variableIndicatorMini
                                      : TextStyle(
                                          color: ColorsTheme.opaqueBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                              Text('Adaptador de corriente externo',
                                  style: variableIndicatorUnit)
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SmartMeterAcParameterCard(),
              if (ModelLogin.isRole(Roles.superAdmin)) SmartMeterAcDebugCard(),
              SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
