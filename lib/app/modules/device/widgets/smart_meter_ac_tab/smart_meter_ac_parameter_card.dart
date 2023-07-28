import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './smart_meter_ac_tab_controller.dart';
import '../../../../utils/constants/ble_api/smart_meter_ac/smart_meter_ac_constants.dart';
import '../../../../widgets/default_card.dart';
import '../../../../theme/text_theme.dart';
import '../../../../widgets/custom_dropdown/custom_dropdown.dart';

class SmartMeterAcParameterCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartMeterAcTabController>(
      id: 'smartMeterAcParameterCard',
      builder: (_) {
        List<String> variables = [
          _.parameterCardPhaseA,
          _.parameterCardPhaseB,
          _.parameterCardPhaseC,
        ];

        if (_.isCurrentParameterCardCurrent(_.currentParameterInParameterCard))
          variables.add(_.parameterCardNeutro);

        List<String> variablesInfo =
            _.isCurrentParameterCardCurrent(_.currentParameterInParameterCard)
                ? SMART_METER_AC_CONSTANTS.CURRENT_PHASE_CARD_TITLE_MAP.values
                    .toList()
                : SMART_METER_AC_CONSTANTS.PHASE_CARD_TITLE_MAP.values.toList();

        return DefaultCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Información de los parámetros de fase',
                style: textInfoBold,
              ),
              Obx(() {
                return (_.currentParameterInParameterCard ==
                            SMART_METER_AC_CONSTANTS.CURRENT_VAR_TYPE_CODE ||
                        _.currentParameterInParameterCard ==
                            SMART_METER_AC_CONSTANTS.VOLTAGE_VAR_TYPE_CODE ||
                        _.currentParameterInParameterCard ==
                            SMART_METER_AC_CONSTANTS.POWER_VAR_TYPE_CODE ||
                        _.currentParameterInParameterCard ==
                            SMART_METER_AC_CONSTANTS.ENERGY_VAR_TYPE_CODE)
                    ? Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '*Nota: Los valores de los últimos decimales pueden ser diferentes a los configurados debido al error acumulado de conversión punto flotante',
                            style: textInfoErrorMiniItalic,
                          ),
                        ],
                      )
                    : Container();
              }),
              Obx(
                () => CustomDropdown(
                  showSetButton: false,
                  withBorder: false,
                  itemsMap: SMART_METER_AC_CONSTANTS.VAR_TYPE_MAP,
                  onChanged: (k) => _.onChangedParameterCard(k),
                  value: SMART_METER_AC_CONSTANTS
                      .VAR_TYPE_MAP[_.currentParameterInParameterCard],
                  floatingLabel: '',
                  dropdownTitle: 'Parámetro',
                  dropdownSubtitle: 'Seleccione un parámetro',
                  errorText: null,
                  hintText: '',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Unidad: ',
                    style: textInfo,
                  ),
                  Text(
                    SMART_METER_AC_CONSTANTS
                        .VAR_TYPE_UNIT_MAP[_.currentParameterInParameterCard],
                    style: textInfoBold,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
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
                        variables[idx].tr,
                        style: textInfoBold,
                      ),
                    ],
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
