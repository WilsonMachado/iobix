import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../data/models/local/model_login.dart';
import '../../../../modules/device/widgets/level_sensor/level_sensor_tab_controller.dart';
import '../../../../utils/constants/ble_api/level_sensor/level_sensor_constants.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../widgets/custom_dropdown/custom_dropdown.dart';
import '../../../../widgets/feature_set_textfield.dart';
import '../../../../widgets/features_set_card.dart';
import '../../../../widgets/normal_button.dart';
import '../../../../widgets/feature_set_textfield_with_desc.dart';
import '../../../../theme/text_theme.dart';

class LevelSensorTabSetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LevelSensorTabController>(
      builder: (_) => Column(
        children: [
          if (ModelLogin.isRole(Roles.superAdmin))
            FeaturesSetCard(
              title: 'complementary_sensors'.tr,
              iconMain: Icons.developer_board_rounded,
              widgetFeatures: Column(
                children: [
                  SizedBox(height: 15),
                  Obx(
                    () => CustomDropdown<int>(
                      showSetButton: true,
                      onPressedSet: _.bleApiSetI2cSensor,
                      itemsMap: LEVEL_SENSOR_CONSTANTS.I2C_SENSOR_MAP,
                      onChanged: (int k) => _.onChangedI2cSensor(k),
                      floatingLabel: 'digital_sensor'.tr,
                      errorText: _.modelLevelSensor.errorSetI2cSensor,
                      dropdownTitle: 'select'.tr,
                      hintText: 'select'.tr,
                      dropdownSubtitle: 'select_digital_sensor'.tr,
                      value: LEVEL_SENSOR_CONSTANTS
                          .I2C_SENSOR_MAP[_.modelLevelSensor.setI2cSensor].tr,
                    ),
                  )
                ],
              ),
            ),
          Obx(() => FeaturesSetCard(
                title: 'alarm_parameters'.tr,
                iconMain: FontAwesomeIcons.bell,
                leadingWidget: NormalButton(
                    text: 'set'.tr, onPressed: _.bleApiSetAlarmParameters),
                widgetFeatures: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Text(
                        'Las medidas se deben ingresar en unidades de metros con 2 decimales'),
                    FeatureSetTextField(
                        showSetButton: false,
                        labelText: 'Delta',
                        hintText: '0.10 - 2.00',
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        onChangedText: (t) => _.onChangedDeltaValue(t),
                        initialValue: _.modelLevelSensor.setMaxsonarDelta,
                        errorText: _.modelLevelSensor.errorSetMaxsonarDelta),
                    FeatureSetTextField(
                        showSetButton: false,
                        labelText: 'lower_threshold'.tr,
                        hintText: '1.00 - 9.95',
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        onChangedText: (t) => _.onChangedMinValue(t),
                        initialValue: _.modelLevelSensor.setMaxsonarMin,
                        errorText: _.modelLevelSensor.errorSetMaxsonarMin),
                    FeatureSetTextField(
                        showSetButton: false,
                        labelText: 'upper_threshold'.tr,
                        hintText: '1.00 - 9.95',
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        onChangedText: (t) => _.onChangedMaxValue(t),
                        initialValue: _.modelLevelSensor.setMaxsonarMax,
                        errorText: _.modelLevelSensor.errorSetMaxsonarMax),
                    SizedBox(height: 8)
                  ],
                ),
              )),
          if(ModelLogin.isAdmin())
          Obx(
            () => FeaturesSetCard(
              title: 'Periodicidad del GNSS',
              iconMain: FontAwesomeIcons.clock,
              leadingWidget:
                  NormalButton(text: 'set'.tr, onPressed: _.bleApiSetGnssSync),
              widgetFeatures: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_.modelLevelSensor.isAnyEnableGnssSync)
                    Text('* Habilita algún tipo de sincronización a configurar',
                        style: textInfoErrorItalic),
                  SizedBox(height: 15),
                  Text(
                      'Para establecer un formato de periodicidad de sincronización del GNSS instalado en el dispostivo debe habilitar cada tipo de caracteristica. Así, por ejemplo, si habilita la opción minutal y establece un valor de 50 y, además, habilita la configuración por hora y establece un valor de 13; el GNSS instalado se "Sincronizará, cada día, a las 13:50"'),
                  Obx(
                    () => FeatureSetTextFieldWithDesc(
                      initialValue: _.modelLevelSensor.setGnssSyncMinute,
                      onChangedText: _.onChangedGnssSyncMinute,
                      errorText: _.modelLevelSensor.errorSetGnssSyncMinute,
                      hintext: '0 - 59',
                      description: Row(
                        children: [
                          SizedBox(
                            height: 25,
                            width: 15,
                            child: Checkbox(
                              onChanged: (v) =>
                                  _.onChangedGnssEnableSyncMinute(v),
                              value: _.modelLevelSensor.enableGnssSyncMinute,
                            ),
                          ),
                          SizedBox(width: 8),
                          RichText(
                            text: TextSpan(
                              style: textInfo,
                              children: [
                                TextSpan(text: 'Sincronizar al '),
                                TextSpan(text: 'minuto', style: textInfoBold),
                                TextSpan(text: ' de cada hora'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => FeatureSetTextFieldWithDesc(
                      initialValue: _.modelLevelSensor.setGnssSyncHour,
                      onChangedText: _.onChangedGnssSyncHour,
                      errorText: _.modelLevelSensor.errorSetGnssSyncHour,
                      hintext: '0 - 23',
                      description: Row(
                        children: [
                          SizedBox(
                            height: 25,
                            width: 15,
                            child: Checkbox(
                              onChanged: (v) =>
                                  _.onChangedGnssEnableSyncHour(v),
                              value: _.modelLevelSensor.enableGnssSyncHour,
                            ),
                          ),
                          SizedBox(width: 8),
                          RichText(
                            text: TextSpan(
                              style: textInfo,
                              children: [
                                TextSpan(text: 'Sincronizar a la '),
                                TextSpan(text: 'hora', style: textInfoBold),
                                TextSpan(text: ' de cada día'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Obx(
                    () => FeatureSetTextFieldWithDesc(
                      initialValue:
                          _.modelLevelSensor.setGnssSyncDayWeekOrMonth,
                      onChangedText: _.onChangedGnssSyncDayWeekOrMonth,
                      errorText:
                          _.modelLevelSensor.errorSetGnssSyncDayWeekOrMonth,
                      hintext:
                          (_.modelLevelSensor.selectGnssSyncDayWeekOrMonth == 0)
                              ? '0 - 6'
                              : '1 - 30',
                      description: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 25,
                                width: 15,
                                child: Checkbox(
                                    onChanged: (v) =>
                                        _.onChangedGnssEnableSyncDayWeekOrMonth(
                                            v),
                                    value: _.modelLevelSensor
                                        .enableGnssSyncDayWeekOrMonth),
                              ),
                              SizedBox(width: 8),
                              Text('Sincronizar '),
                              SizedBox(
                                height: 30,
                                width: 150,
                                child: CustomDropdown(
                                  showSetButton: false,
                                  floatingLabel: '',
                                  hintText: 'select'.tr,
                                  itemsMap: LEVEL_SENSOR_CONSTANTS
                                      .GNSS_PERIODICITY_MAP,
                                  onChanged: (k) => _
                                      .onChangedSelectGnssSyncDayWeekOrMonth(k),
                                  value: LEVEL_SENSOR_CONSTANTS
                                          .GNSS_PERIODICITY_MAP[
                                      _.modelLevelSensor
                                          .selectGnssSyncDayWeekOrMonth],
                                  dropdownTitle: 'select'.tr,
                                  dropdownSubtitle:
                                      'Seleccione un tipo de sincronización',
                                  errorText: null,
                                ),
                              ),
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              style: textInfo,
                              children: [
                                TextSpan(text: 'cada '),
                                TextSpan(text: 'día', style: textInfoBold)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      '* Cuando es una sincronización semanal el valor a configurar, del día correspondiente, puede estar entre 0 y 6; donde 0 corresponde a Domingo y 6 a Sábado',
                      style: textInfoItalic),
                ],
              ),
            ),
          ),
          SizedBox(height: 8)
        ],
      ),
    );
  }
}
