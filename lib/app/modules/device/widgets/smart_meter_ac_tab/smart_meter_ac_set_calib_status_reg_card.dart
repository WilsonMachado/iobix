import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import './smart_meter_ac_tab_controller.dart';
import '../../../../widgets/features_set_card.dart';
import '../../../../widgets/normal_button.dart';
import '../../../../theme/text_theme.dart';

class SmartMeterAcSetCalibStatusRegCard extends StatelessWidget {
  const SmartMeterAcSetCalibStatusRegCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartMeterAcTabController>(
        id: 'SmartMeterAcSetCalibStatusRegCard',
        builder: (_) {
          List<String> variablesInfo = [
            'Ganancia de corriente RMS',
            'Offset de corriente RMS',
            'Offset de corriente Fundamental RMS',
            'Ganancia de voltaje RMS',
            'Offset de voltaje RMS',
            'Offset de voltaje Fundamental RMS',
            'Fase (ángulo)',
            'Ganancia de potencia',
            'Offset de potencia activa',
            'Offset de potencia activa Fundamental',
            'Offset de potencia reactiva',
            'Offset de potencia reactiva Fundamental',
          ];

          RxList<bool> variables = [
            _.modelSmartMeterAc.setRmsCurrentGainCalib,
            _.modelSmartMeterAc.setRmsCurrentOffsetCalib,
            _.modelSmartMeterAc.setRmsFundamentalCurrentOffsetCalib,
            _.modelSmartMeterAc.setRmsVoltageGainCalib,
            _.modelSmartMeterAc.setRmsVoltageOffsetCalib,
            _.modelSmartMeterAc.setRmsFundamentalVoltageOffsetCalib,
            _.modelSmartMeterAc.setPhaseCalib,
            _.modelSmartMeterAc.setPowerGainCalib,
            _.modelSmartMeterAc.setActivePowerOffsetCalib,
            _.modelSmartMeterAc.setFundamentalActivePowerOffsetCalib,
            _.modelSmartMeterAc.setReactivePowerOffsetCalib,
            _.modelSmartMeterAc.setFundamentalReactivePowerOffsetCalib,
          ].obs;

          return FeaturesSetCard(
            title: 'Ajuste de calibración',
            iconMain: FontAwesomeIcons.sliders,
            leadingWidget: NormalButton(
              text: 'set'.tr,
              onPressed: () => _.bleApiSetCalibStatusReg(variables),
            ),
            widgetFeatures: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Text(
                  '*Nota: Para que esta configuración surta efecto debe reiniciar el dispositivo luego de establecer la configuración',
                  style: textInfoErrorMiniItalic,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Actualizar configuración establecida',
                      style: textInfo,
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.rotateRight,
                          color: Theme.of(context).primaryColor,
                          size: 10,
                        ),
                        onPressed: _.bleApiGetCalibStatusReg,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: variablesInfo.length,
                  itemBuilder: (__, idx) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          variablesInfo[idx],
                          style: textInfo,
                        ),
                        SizedBox(width: 10.0),
                        SizedBox(
                          height: 25,
                          width: 15,
                          child: Obx(
                            () => Checkbox(
                              onChanged: (v) =>
                                  _.onChangedSetCalibStatusRegType(idx, v),
                              value: variables[idx],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          );
        });
  }
}
