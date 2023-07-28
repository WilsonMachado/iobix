import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iobix/app/theme/color_theme.dart';
import 'package:iobix/app/widgets/feature_set_textfield.dart';
import 'package:iobix/app/widgets/features_set_card.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../../theme/text_theme.dart';
import 'smart_fault_detector_tab_controller.dart';

class SmartFaultDetectorTabSetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartFaultDetectorTabController>(
        builder: (_) => Column(children: [
              Obx(() => FeaturesSetCard(
                  title: 'Configuración de detonación de alarmas',
                  iconMain: FontAwesomeIcons.screwdriverWrench,
                  widgetFeatures: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text('Alarma permanente'),
                        Spacer(),
                        Text(
                            _.modelSmartFaultDetector
                                .getTicksToDetonatePermanentAlarm
                                .toString(),
                            style: variableIndicatorMini),
                        SizedBox(width: 5.0),
                        Text('ticks', style: variableIndicatorUnit)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text('Alarma transitoria'),
                        Spacer(),
                        Text(
                            _.modelSmartFaultDetector
                                .getTicksToDetonateTransitoryAlarm
                                .toString(),
                            style: variableIndicatorMini),
                        SizedBox(width: 5.0),
                        Text('ticks', style: variableIndicatorUnit)
                      ],
                    ),
                    FeatureSetTextField(
                      showSetButton: true,
                      labelText: 'Alarma permanente',
                      hintText: '[1 - 255] tick',
                      initialValue: null,
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      onChangedText: (t) => _.onChangedSetTicksPermanent(t),
                      onPressedSet: _.bleApiSetTicksToDetonatePermanentAlarm,
                      errorText: _.modelSmartFaultDetector
                          .errorSetTicksToDetonatePermanentAlarm,
                    ),
                    FeatureSetTextField(
                      showSetButton: true,
                      labelText: 'Alarma transitoria',
                      hintText: '[1 - 255] ticks',
                      initialValue: null,
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      onChangedText: (t) => _.onChangedSetTicksTransitory(t),
                      onPressedSet: _.bleApiSetTicksToDetonateTransitoryAlarm,
                      errorText: _.modelSmartFaultDetector
                          .errorSetTicksToDetonateTransitoryAlarm,
                    ),
                  ]))),

              Obx(() => FeaturesSetCard(
                  title: 'Configuraciones de tiempo para las alarmas',
                  iconMain: FontAwesomeIcons.clock,
                  widgetFeatures: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text('¿Retransmitir en alarma?'),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlutterSwitch(
                              activeText: 'Sí',
                              inactiveText: 'No',
                              showOnOff: true,
                              activeTextColor: ColorsTheme.lightSalmon,
                              inactiveTextColor: Colors.blue[50],
                              activeColor: ColorsTheme.salmon,
                              value: (_.modelSmartFaultDetector
                                          .isTimeReportChangingInAlarmMode ==
                                      0x01)
                                  ? true
                                  : false,
                              height: 25,
                              width: 55,
                              valueFontSize: 10,
                              onToggle: (v) =>
                                  _.updateAlarmMode((v) ? 0x01 : 0x00),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    if (_.modelSmartFaultDetector
                            .isTimeReportChangingInAlarmMode ==
                        0x01)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('Tiempo'),
                              Spacer(),
                              Text(
                                  ((_.modelSmartFaultDetector
                                              .getTimeToReportFault) ~/
                                          60)
                                      .toString(),
                                  style: variableIndicatorMini),
                              SizedBox(width: 5.0),
                              Text('min', style: variableIndicatorUnit)
                            ],
                          ),
                          FeatureSetTextField(
                            showSetButton: true,
                            labelText: 'Retransmisión en alarma',
                            hintText: '[1 - 120] minutos',
                            initialValue: null,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            onChangedText: (t) =>
                                _.onChangedSetTimeToReportFault(t),
                            onPressedSet: _.bleApiSetTimeToReportFault,
                            errorText: _.modelSmartFaultDetector
                                .errorSetTimeToReportFault,
                          ),
                        ],
                      ),
                    SizedBox(height: 12),
                    Divider(),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text('Reinicio de alarma'),
                        Spacer(),
                        Text(
                            _.modelSmartFaultDetector.getTimeToFaultTimeOut
                                .toString(),
                            style: variableIndicatorMini),
                        SizedBox(width: 5.0),
                        Text('s', style: variableIndicatorUnit)
                      ],
                    ),
                    FeatureSetTextField(
                      showSetButton: true,
                      labelText: 'Reinicio de alarma',
                      hintText: '[1 - 255] segundos',
                      initialValue: null,
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      onChangedText: (t) => _.onChangedSetTimeToFaultTimeOut(t),
                      onPressedSet: _.bleApiSetTimeToFaultTimeOut,
                      errorText:
                          _.modelSmartFaultDetector.errorSetTimeToFaultTimeOut,
                    ),
                  ]))),

              ///! Para configuraciones asociadas a los tiempos
            ]));
  }
}
