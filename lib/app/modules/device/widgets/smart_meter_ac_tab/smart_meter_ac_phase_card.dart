import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iobix/app/modules/device/widgets/system_tab/system_tab_controller.dart';
import 'package:iobix/app/utils/helpers/helpers.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../theme/text_theme.dart';
import '../../../../theme/color_theme.dart';
import '../../../../widgets/default_card.dart';
import '../../../../widgets/normal_button.dart';
import '../../../../widgets/custom_dropdown/custom_dropdown.dart';
import './smart_meter_ac_tab_controller.dart';
import '../../../../utils/constants/ble_api/smart_meter_ac/smart_meter_ac_constants.dart';

class SmartMeterAcPhaseCard extends StatelessWidget {
  final double radiusSize;
  const SmartMeterAcPhaseCard({Key key, this.radiusSize = 50.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartMeterAcTabController>(
      id: 'smartMeterAcPhaseCard',
      builder: (_) {
        double voltagePercent = double.parse(_.phaseCardVoltage) / 140.0;
        if (voltagePercent > 1) voltagePercent = 1;
        double currentPercent = double.parse(_.phaseCardCurrent) / 10.0;
        if (currentPercent < 0) currentPercent *= (-1);
        if (currentPercent > 1) currentPercent = 1;

        List<String> variables = [
          _.phaseCardPositiveActiveEnergy,
          _.phaseCardNegativeActiveEnergy,
          _.phaseCardPositiveReactiveEnergy,
          _.phaseCardNegativeReactiveEnergy,
          if (_.isFwHigherOrEqual1_0_4 &&
              _.modelSmartMeterAc.deviceVersion == 3.1)
            _.phaseCardPositiveApparentEnergy,
          if (_.isFwHigherOrEqual1_0_4 &&
              _.modelSmartMeterAc.deviceVersion == 3.1)
            _.phaseCardNegativeApparentEnergy,
          _.phaseCardActivePower,
          _.phaseCardReactivePower,
          _.phaseCardApparentPower,
          _.phaseCardPowerFactor,
        ];

        List<String> variablesInfo = [
          'Energía Activa + (kWh)',
          'Energía Activa - (kWh)',
          'Energía Reactiva + (kVArh)',
          'Energía Reactiva - (kVArh)',
          if (_.isFwHigherOrEqual1_0_4 &&
              _.modelSmartMeterAc.deviceVersion == 3.1)
            'Energía Aparente + (kVAh)',
          if (_.isFwHigherOrEqual1_0_4 &&
              _.modelSmartMeterAc.deviceVersion == 3.1)
            'Energía Aparente - (kVAh)',
          'Potencia Activa (W)',
          'Potencia Reactiva (VAr)',
          'Potencia Aparente (VA)',
          'Factor de Potencia',
        ];

        return DefaultCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Información de fase',
                  style: textInfoBold,
                ),
              ),
              Obx(
                () => Row(
                  children: [
                    Flexible(
                      child: CustomDropdown(
                        showSetButton: false,
                        withBorder: false,
                        itemsMap: SMART_METER_AC_CONSTANTS.PHASE_CARD_TITLE_MAP,
                        onChanged: (k) => _.onChangedPhaseCard(k),
                        value: SMART_METER_AC_CONSTANTS
                            .PHASE_CARD_TITLE_MAP[_.currentPhaseInPhaseCard],
                        floatingLabel: '',
                        dropdownTitle: 'Fase',
                        dropdownSubtitle: 'Seleccione la fase',
                        errorText: null,
                        hintText: '',
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '${_.phaseCardTextVolAux1}: ',
                              style: textInfo,
                            ),
                            Text(
                              _.phaseCardVoltageAux1,
                              style: textInfoBold,
                            ),
                            Text(
                              ' V',
                              style: textInfoMiniBold,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${_.phaseCardTextVolAux2}: ',
                              style: textInfo,
                            ),
                            Text(
                              _.phaseCardVoltageAux2,
                              style: textInfoBold,
                            ),
                            Text(
                              ' V',
                              style: textInfoMiniBold,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        CircularPercentIndicator(
                          animateFromLastPercent: false,
                          radius: radiusSize > 100 ? 100 : radiusSize,
                          lineWidth: radiusSize / 5,
                          animation: true,
                          percent: voltagePercent,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: ColorsTheme.opaqueBlue,
                          center: Text(
                            _.phaseCardVoltage,
                            style: textInfoBold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Voltaje (V)',
                          style: variableIndicatorUnit,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        CircularPercentIndicator(
                          animateFromLastPercent: false,
                          radius: radiusSize > 100 ? 100 : radiusSize,
                          lineWidth: radiusSize / 5,
                          animation: true,
                          percent: currentPercent,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: ColorsTheme.salmon,
                          center: Text(
                            _.phaseCardCurrent,
                            style: textInfoBold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Corriente (A)',
                          style: variableIndicatorUnit,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Obx(
                () {
                  if (_.seeMorePhaseCard)
                    return Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: variables.length,
                          itemBuilder: (__, idx) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  variablesInfo[idx],
                                  style: textInfo,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  variables[idx],
                                  style: textInfoBold,
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        NormalButton(
                          text: 'Ocultar',
                          onPressed: _.onChangedSeeMorePhaseCard,
                        ),
                      ],
                    );
                  return NormalButton(
                    text: 'Ver más ...',
                    onPressed: _.onChangedSeeMorePhaseCard,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
