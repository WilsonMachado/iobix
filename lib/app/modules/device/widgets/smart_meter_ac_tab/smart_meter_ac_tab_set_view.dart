import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../theme/text_theme.dart';
import './smart_meter_ac_tab_controller.dart';
import '../../../../data/models/local/model_login.dart';
import '../../../../widgets/features_set_card.dart';
import '../../../../widgets/custom_dropdown/custom_dropdown.dart';
import '../../../../widgets/feature_set_textfield.dart';
//import '../../../../widgets/custom_switch.dart';
import '../../../../widgets/normal_button.dart';
import '../../../../widgets/custom_alert_modal_bottom_sheet.dart';
import '../../../../widgets/circular_button.dart';
import '../../../../utils/constants/ble_api/smart_meter_ac/smart_meter_ac_constants.dart';
//import '../../../../theme/text_theme.dart';
import './smart_meter_ac_set_calib_status_reg_card.dart';

class SmartMeterAcTabSetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartMeterAcTabController>(
        builder: (_) => Column(
              children: [
                /*if (ModelLogin.isRole(Roles.superAdmin))
                  FeaturesSetCard(
                    title: 'Configuración de registros',
                    iconMain: Icons.settings,
                    widgetFeatures: Column(
                      children: [
                        SizedBox(height: 15.0),
                        Obx(() => CustomDropdown(
                              itemsMap: SMART_METER_AC_CONSTANTS.REG_TYPE_MAP,
                              showSetButton: false,
                              onChanged: (int k) =>
                                  _.onChangedSetWriteRegType(k),
                              floatingLabel: 'Tipo de registro',
                              errorText:
                                  _.modelSmartMeterAc.errorSetWriteRegType,
                              value: SMART_METER_AC_CONSTANTS.REG_TYPE_MAP[
                                  _.modelSmartMeterAc.setWriteRegType],
                              dropdownTitle: 'select'.tr,
                              dropdownSubtitle:
                                  'Seleccione el tipo de registro que desea configurar',
                              hintText: 'select'.tr,
                            )),
                        Obx(() {
                          if (_.selectSetRegType &&
                              _.modelSmartMeterAc.setWriteRegType !=
                                  SMART_METER_AC_CONSTANTS.PHASE_REG_TYPE_CODE)
                            return Column(
                              children: [
                                SizedBox(height: 20.0),
                                CustomDropdown(
                                    itemsMap: _.getSetWriteRegSubtype(),
                                    showSetButton: false,
                                    onChanged: (int k) =>
                                        _.onChangedSetWriteRegSubtype(k),
                                    value: _.getSetWriteRegSubtype()[
                                        _.modelSmartMeterAc.setWriteRegSubtype],
                                    floatingLabel: 'Subtipo de registro',
                                    errorText: _.modelSmartMeterAc
                                        .errorSetWriteRegSubtype,
                                    dropdownTitle: 'select'.tr,
                                    dropdownSubtitle:
                                        'Seleccione el subtipo de registro que desea configurar',
                                    hintText: 'select'.tr),
                              ],
                            );
                          return Container();
                        }),
                        Obx(() {
                          if (_.selectSetRegSubtype)
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _.getSetWriteRegAddress().length,
                              itemBuilder: (__, idx) {
                                Map<int, String> mapRegAddress =
                                    _.getSetWriteRegAddress();
                                return GetBuilder<SmartMeterAcTabController>(
                                  id: 'setWriteRegDataUI',
                                  builder: (_) => Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        children: [
                                          Text(mapRegAddress[idx + 1],
                                              style: textInfoBold),
                                          SizedBox(width: 15.0),
                                          Expanded(
                                            child: FeatureSetTextField(
                                              labelText: 'Data',
                                              hintText: 'Hexadecimal',
                                              initialValue: _.modelSmartMeterAc
                                                  .setWriteRegDataList[idx],
                                              onChangedText: (t) =>
                                                  _.onChangedSetWriteRegData(
                                                      t, idx),
                                              showSetButton: true,
                                              onPressedSet: () =>
                                                  _.bleApiWriteRegAddress(idx),
                                              errorText: _.modelSmartMeterAc
                                                              .errorSetWriteRegDataList[
                                                          idx] ==
                                                      ''
                                                  ? null
                                                  : _.modelSmartMeterAc
                                                          .errorSetWriteRegDataList[
                                                      idx],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0)
                                    ],
                                  ),
                                );
                              },
                            );
                          return Container();
                        }),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),*/
                if (ModelLogin.isAdmin())
                  FeaturesSetCard(
                    title: 'Configuración de parámetros',
                    iconMain: Icons.settings,
                    leadingWidget: NormalButton(
                      text: 'set'.tr,
                      onPressed: _.bleApiWriteParameter,
                    ),
                    widgetFeatures: Column(
                      children: [
                        SizedBox(height: 15.0),
                        Obx(() => CustomDropdown(
                              itemsMap: SMART_METER_AC_CONSTANTS.VAR_TYPE_MAP,
                              showSetButton: false,
                              onChanged: (int k) =>
                                  _.onChangedSetWriteParameter(k),
                              floatingLabel: 'Parámetro',
                              errorText:
                                  _.modelSmartMeterAc.errorSetWriteParameter,
                              value: SMART_METER_AC_CONSTANTS.VAR_TYPE_MAP[
                                  _.modelSmartMeterAc.setWriteParameter],
                              dropdownTitle: 'select'.tr,
                              dropdownSubtitle:
                                  'Seleccione el parámetro que desea configurar',
                              hintText: 'select'.tr,
                            )),
                        Obx(() {
                          return (_.selectSetVarType)
                              ? Column(
                                  children: [
                                    SizedBox(height: 20.0),
                                    CustomDropdown(
                                      itemsMap:
                                          _.getSetParameterPhaseIndexMap(),
                                      showSetButton: false,
                                      onChanged: (int k) => _
                                          .onChangedSetWriteParameterPhaseIndex(
                                              k),
                                      value: _.getSetParameterPhaseIndexMap()[_
                                          .modelSmartMeterAc
                                          .setParameterPhaseIndex],
                                      floatingLabel: 'Índice de la fase',
                                      errorText: _.modelSmartMeterAc
                                          .errorSetParameterPhaseIndex,
                                      dropdownTitle: 'select'.tr,
                                      dropdownSubtitle:
                                          'Seleccione el indice de la fase que desea configurar',
                                      hintText: 'select'.tr,
                                    ),
                                  ],
                                )
                              : Container();
                        }),
                        Obx(
                          () {
                            return (_.selectSetParameterPhaseIndex)
                                ? FeatureSetTextField(
                                    labelText: 'Valor',
                                    maxLength:
                                        _.getMaxLengthSetWriteParameterValue(),
                                    keyboardType: SMART_METER_AC_CONSTANTS
                                                    .VAR_TYPE_UNIT_MAP[
                                                _.modelSmartMeterAc
                                                    .setWriteParameter] ==
                                            'Hexadecimal'
                                        ? TextInputType.text
                                        : TextInputType.number,
                                    hintText: SMART_METER_AC_CONSTANTS
                                            .VAR_TYPE_UNIT_MAP[
                                        _.modelSmartMeterAc.setWriteParameter],
                                    initialValue: _.modelSmartMeterAc
                                        .setWriteParameterValue,
                                    onChangedText: (t) =>
                                        _.onChangedSetWriteParameterValue(t),
                                    showSetButton: false,
                                    errorText: _.modelSmartMeterAc
                                        .errorSetWriteParameterValue,
                                  )
                                : Container();
                          },
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                if (ModelLogin.isAdmin()) SmartMeterAcSetCalibStatusRegCard(),
                if (ModelLogin.isAdmin())
                  FeaturesSetCard(
                    title: 'Ajustes y lecturas adicionales',
                    iconMain: FontAwesomeIcons.sliders,
                    widgetFeatures: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Reiniciar valores de energía'),
                            CircularButton(
                              icon: FontAwesomeIcons.angleRight,
                              onPressed: () {
                                showCupertinoModalBottomSheet(
                                  barrierColor: Colors.black38,
                                  expand: false,
                                  context: context,
                                  builder: (context) =>
                                      CustomAlertModalBottomSheet(
                                    title: 'alert_title'.tr,
                                    message:
                                        '¿Desea reiniciar los valores de energía acumulados en el dispositivo?',
                                    actionYes: _.bleApiResetEnergyAccumulation,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Leer registro de promedio de lecturas RMS',
                          style: textInfo,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Obx(
                                () => CustomDropdown(
                                  itemsMap:
                                      SMART_METER_AC_CONSTANTS.RMS_REG_ADDRESS,
                                  onChanged: (int k) =>
                                      _.onChangedSetRmsRegAddress(k),
                                  value:
                                      SMART_METER_AC_CONSTANTS.RMS_REG_ADDRESS[
                                          _.modelSmartMeterAc.setRmsRegAddress],
                                  floatingLabel: 'Registro RMS',
                                  errorText: null,
                                  dropdownTitle: 'select'.tr,
                                  dropdownSubtitle:
                                      'Seleccione el registro RMS a leer',
                                  showSetButton: false,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            NormalButton(
                              text: 'Leer',
                              onPressed: _.bleApiSetRmsRegAddress,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Lectura',
                              style: textInfo,
                            ),
                            SizedBox(width: 10.0),
                            Obx(
                              () => Text(
                                _.modelSmartMeterAc.getRmsRegValue.tr,
                                style: textInfoBold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ));
  }
}
