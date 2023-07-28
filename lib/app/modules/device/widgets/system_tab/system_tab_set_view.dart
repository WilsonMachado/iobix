import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iobix/app/widgets/custom_dropdown/custom_dropdown.dart';

import '../../../../utils/constants/enums.dart';
import './system_tab_controller.dart';
import '../../../../widgets/normal_button.dart';
import '../../../../theme/text_theme.dart';
import '../../../../widgets/features_set_card.dart';
import '../../../../widgets/feature_set_textfield.dart';
import '../../../../widgets/circular_button.dart';
import '../../../../theme/color_theme.dart';
import '../../../../data/models/local/model_login.dart';

class SystemTabSetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemTabController>(
        id: 'systemTapSetView',
        builder: (_) => RefreshIndicator(
            onRefresh: _.getUpdatedData,
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      if (ModelLogin.isRole(Roles.superAdmin))
                        Obx(() => FeaturesSetCard(
                            title: 'Configuración automática de dispositivo',
                            iconMain: FontAwesomeIcons.microchip,
                            widgetFeatures: Column(children: [
                              SizedBox(height: 10),
                              Obx(() => CustomDropdown<String>(
                                  showSetButton: false,
                                  floatingLabel: 'Hoja de trabajo',
                                  hintText: 'select'.tr,
                                  itemsMap: Map.fromIterable(
                                      _.gsheetSheetNames.keys,
                                      key: (k) => k.toString(),
                                      value: (v) => _.gsheetSheetNames[v]),
                                  onChanged: (code) =>
                                      _.changeGSheetToWork(code),
                                  value: _.gsheetSheetNames[_.currentGSheetId],
                                  dropdownTitle: 'select'.tr,
                                  dropdownSubtitle:
                                      'Seleccione una hoja de trabajo',
                                  errorText: null)),
                              FeatureSetTextField(
                                showSetButton: true,
                                onPressedSet: _.getIDFromGSheet,
                                labelText:
                                    'Configurar identificador automáticamente',
                                hintText:
                                    'Consecutivo del dispositivo [1 - 999]',
                                initialValue:
                                    _.modelDeviceInformation.setAutomaticID,
                                maxLength: 3,
                                keyboardType: TextInputType.number,
                                onChangedText: (t) =>
                                    _.onChangedSetAutomaticID(t),
                                errorText: _
                                    .modelDeviceInformation.errorSetAutomaticID,
                              ),
                            ]))),
                      FeaturesSetCard(
                        title: 'Configuración manual de dispositivo',
                        iconMain: FontAwesomeIcons.microchip,
                        widgetFeatures: Column(
                          children: [
                            Obx(
                              () => FeatureSetTextField(
                                labelText: 'measure_time'.tr,
                                hintText: 'seconds'.tr,
                                initialValue:
                                    _.modelDeviceGeneral.setMeasureTime,
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                onChangedText: (t) => _.onChangedMeasureTime(t),
                                onPressedSet: _.bleApiMeasureTime,
                                errorText:
                                    _.modelDeviceGeneral.errorMeasureTime,
                              ),
                            ),
                            Obx(
                              () => FeatureSetTextField(
                                labelText: 'tx_time'.tr,
                                hintText: 'minutes'.tr,
                                initialValue: _.modelDeviceGeneral.setTxTime,
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                onChangedText: (t) => _.onChangedTxTime(t),
                                onPressedSet: _.bleApiTxTime,
                                errorText: _.modelDeviceGeneral.errorTxTime,
                              ),
                            ),
                            if (ModelLogin.isRole(Roles.superAdmin))
                              Obx(() => FeatureSetTextField(
                                    labelText: 'identifier'.tr,
                                    hintText: 'hex_format'.tr,
                                    initialValue:
                                        _.modelDeviceInformation.setId,
                                    maxLength: 10,
                                    onChangedText: (t) => _.onChangedSetId(t),
                                    onPressedSet: _.bleApiSetId,
                                    errorText:
                                        _.modelDeviceInformation.errorSetId,
                                  )),
                          ],
                        ),
                      ),
                      Obx(
                        () => FeaturesSetCard(
                          title: 'clock'.tr,
                          iconMain: FontAwesomeIcons.clock,
                          leadingWidget: NormalButton(
                            text: 'set'.tr,
                            onPressed: () => _.bleApiSetRtc(),
                          ),
                          widgetFeatures: Column(
                            children: [
                              InkWell(
                                onTap: () => _.getDatePickerRtc(context),
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                      labelText: 'date'.tr, enabled: true),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                          DateFormat.yMMMMd().format(
                                              _.modelDeviceGeneral.setRtcDate),
                                          style: textInfoBold),
                                      Icon(FontAwesomeIcons.angleDown,
                                          size: 20),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => _.getTimePickerRtc(context),
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                      labelText: 'hour'.tr, enabled: true),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                          _.modelDeviceGeneral.setRtcTime
                                              .format(context),
                                          style: textInfoBold),
                                      Icon(FontAwesomeIcons.angleDown,
                                          size: 20),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      if (ModelLogin.isAdmin())
                        FeaturesSetCard(
                          title: 'Bluetooth',
                          iconMain: FontAwesomeIcons.bluetooth,
                          leadingWidget: CircularButton(
                              icon: FontAwesomeIcons.powerOff,
                              onPressed: () => _.bleApiTurnOffBle()),
                          widgetFeatures: Column(
                            children: [
                              /*Obx(
                    () => FeatureSetTextField(
                        labelText: 'name'.tr,
                        hintText: 'announcement_name'.tr,
                        initialValue: _.modelDeviceBluetooth.setDeviceName,
                        maxLength: 20,
                        onChangedText: (t) => _.onChangedSetDeviceName(t),
                        onPressedSet: _.bleApiSetDeviceName,
                        errorText: _.modelDeviceBluetooth.errorSetDeviceName),
                  )*/
                            ],
                          ),
                        ),
                      FeaturesSetCard(
                        title: 'security'.tr,
                        iconMain: FontAwesomeIcons.lock,
                        leadingWidget: NormalButton(
                            text: 'set'.tr, onPressed: _.bleApiSetPassword),
                        widgetFeatures: Column(
                          children: [
                            Obx(
                              () => Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  FeatureSetTextField(
                                      showSetButton: false,
                                      enableSuggestions: false,
                                      obscureText: _.hideOldPassword,
                                      labelText: 'old_password'.tr,
                                      hintText: '4 ${'characters'.tr}',
                                      initialValue:
                                          _.modelDeviceBluetooth.setOldPassword,
                                      maxLength: 4,
                                      onChangedText: (t) =>
                                          _.onChangedSetOldPassword(t),
                                      errorText: _.modelDeviceBluetooth
                                          .errorSetOldPassword),
                                  IconButton(
                                    icon: Icon(
                                      _.hideOldPassword
                                          ? Icons.visibility_off_rounded
                                          : Icons.visibility_rounded,
                                      color: ColorsTheme.salmon,
                                    ),
                                    onPressed: _.onChangedHideOldPassword,
                                  )
                                ],
                              ),
                            ),
                            Obx(
                              () => Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  FeatureSetTextField(
                                      showSetButton: false,
                                      enableSuggestions: false,
                                      obscureText: _.hideNewPassword,
                                      labelText: 'new_password'.tr,
                                      hintText: '4 ${'characters'.tr}',
                                      initialValue:
                                          _.modelDeviceBluetooth.setNewPassword,
                                      maxLength: 4,
                                      onChangedText: (t) =>
                                          _.onChangedSetNewPassword(t),
                                      errorText: _.modelDeviceBluetooth
                                          .errorSetNewPassword),
                                  IconButton(
                                    icon: Icon(
                                        _.hideNewPassword
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded,
                                        color: ColorsTheme.salmon),
                                    onPressed: _.onChangedHideNewPassword,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0)
                    ],
                  ),
                ))));
  }
}
