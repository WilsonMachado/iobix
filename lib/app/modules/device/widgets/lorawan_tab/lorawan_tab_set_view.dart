import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import './lorawan_tab_controller.dart';
import '../../../../utils/constants/ble_api/lorawan_constants.dart';
import '../../../../widgets/normal_button.dart';
import '../../../../widgets/features_set_card.dart';
import '../../../../widgets/feature_set_textfield.dart';
import '../../../../widgets/custom_switch.dart';
import '../../../../widgets/default_card.dart';
import '../../../../theme/text_theme.dart';
import '../../../../widgets/custom_dropdown/custom_dropdown.dart';
import '../../../../data/models/local/model_login.dart';
import '../../../../utils/constants/enums.dart';

class LorawanTabSetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LorawanTabController>(
      builder: (_) => Column(
        children: [
          if (ModelLogin.isRole(Roles.superAdmin))
            DefaultCard(
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Cansado?, Inicia la configuración automatica',
                      textAlign: TextAlign.center,
                      style: textInfoMiniBold,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    NormalButton(
                        text: 'Iniciar',
                        onPressed: (_.isAutomaticConfig)
                            ? null
                            : () => _.automaticConfig(0)),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      _.automaticConfigMsg,
                      style: textInfoMiniItalic,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          if (ModelLogin.isAdmin())
            Obx(
              () => FeaturesSetCard(
                title: 'x_active'.trArgs(['OTAA']),
                iconMain: FontAwesomeIcons.paperPlane,
                leadingWidget: Row(
                  children: [
                    NormalButton(
                        text: 'Join',
                        onPressed: (_.modelDeviceLorawan.isTryJoin)
                            ? null
                            : _.bleApiJoinOtaa),
                    SizedBox(
                      width: 8.0,
                    ),
                    NormalButton(
                      text: 'set'.tr,
                      onPressed: () => _.bleApiLoraActiveOTAA(),
                    ),
                  ],
                ),
                widgetFeatures: Column(
                  children: [
                    FeatureSetTextField(
                      labelText: 'Dev EUI',
                      hintText: '8 Bytes',
                      initialValue: _.modelDeviceLorawan.setDevEui,
                      maxLength: 16,
                      onChangedText: (t) => _.onChangedSetEui(t),
                      showSetButton: false,
                      errorText: _.modelDeviceLorawan.errorSetDevEui,
                    ),
                    FeatureSetTextField(
                        labelText: 'App EUI',
                        hintText: '8 Bytes',
                        initialValue: _.modelDeviceLorawan.setAppEui,
                        maxLength: 16,
                        onChangedText: (t) => _.onChangedSetAppEui(t),
                        showSetButton: false,
                        errorText: _.modelDeviceLorawan.errorSetAppEui),
                    FeatureSetTextField(
                        labelText: 'App Key',
                        hintText: '16 Bytes',
                        initialValue: _.modelDeviceLorawan.setAppKey,
                        maxLength: 32,
                        onChangedText: (t) => _.onChangedSetAppKey(t),
                        showSetButton: false,
                        errorText: _.modelDeviceLorawan.errorSetAppKey)
                  ],
                ),
              ),
            ),
          if (ModelLogin.isAdmin())
            Obx(
              () => FeaturesSetCard(
                title: 'x_active'.trArgs(['ABP']),
                iconMain: FontAwesomeIcons.solidPaperPlane,
                leadingWidget: NormalButton(
                  text: 'set'.tr,
                  onPressed: () => _.bleApiLoraActiveABP(),
                ),
                widgetFeatures: Column(
                  children: [
                    Center(
                      child: Text('Activación ABP manual'),
                    ),
                    FeatureSetTextField(
                      labelText: 'Device Address',
                      hintText: '4 Bytes',
                      initialValue: _.modelDeviceLorawan.setDeviceAddress,
                      maxLength: 8,
                      onChangedText: (t) => _.onChangedSetDeviceAddress(t),
                      showSetButton: false,
                      errorText: _.modelDeviceLorawan.errorSetDeviceAddress,
                    ),
                    FeatureSetTextField(
                      labelText: 'Network Session Key',
                      hintText: '16 Bytes',
                      initialValue: _.modelDeviceLorawan.setNwsKey,
                      maxLength: 32,
                      onChangedText: (t) => _.onChangedSetNwsKey(t),
                      showSetButton: false,
                      errorText: _.modelDeviceLorawan.errorSetNwsKey,
                    ),
                    FeatureSetTextField(
                        labelText: 'App Session Key',
                        hintText: '16 Bytes',
                        initialValue: _.modelDeviceLorawan.setAppsKey,
                        maxLength: 32,
                        onChangedText: (t) => _.onChangedSetAppsKey(t),
                        showSetButton: false,
                        errorText: _.modelDeviceLorawan.errorSetAppsKey),
                    SizedBox(
                      height: 15,
                    ),
                    if (ModelLogin.isRole(Roles.superAdmin)) Divider(),
                    if (ModelLogin.isRole(Roles.superAdmin))
                      Center(
                        child: Text('Activación ABP automática'),
                      ),
                    if (ModelLogin.isRole(Roles.superAdmin))
                      Obx(
                        () => FeatureSetTextField(
                          showSetButton: true,
                          onPressedSet: _.getABPParamsFromGSheet,
                          labelText: 'Consecutivo del dispositivo',
                          hintText: '1 - 999',
                          initialValue:
                              _.modelDeviceLorawan.setConsecutiveDeviceNumber,
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          onChangedText: (t) =>
                              _.onChangedConsecutiveDeviceNumber(t),
                          errorText:
                              _.modelDeviceLorawan.errorConsecutiveDeviceNumber,
                        ),
                      ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          if (_.isImstModule())
            FeaturesSetCard(
              title: 'x_param'.trArgs(['LoRaWAN']),
              iconMain: FontAwesomeIcons.gear,
              widgetFeatures: Column(
                children: [
                  SizedBox(height: 15.0),
                  Obx(
                    () => CustomDropdown<int>(
                      showSetButton: true,
                      onPressedSet: _.bleApiSetOperationMode,
                      itemsMap: LORAWAN_CONSTANTS.OPERATION_MODE,
                      onChanged: (int k) => _.onChangedOperationMode(k),
                      floatingLabel: 'oper_mode'.tr,
                      errorText: _.modelDeviceLorawan.errorSetOperationMode,
                      dropdownTitle: 'select'.tr,
                      dropdownSubtitle: 'select_oper_mode'.tr,
                      value: LORAWAN_CONSTANTS.OPERATION_MODE[
                          _.modelDeviceLorawan.setOperationMode],
                      hintText: 'select'.tr,
                    ),
                  ),
                ],
              ),
            ),
          FeaturesSetCard(
            title: 'x_param'.trArgs(['Radiostack']),
            iconMain: FontAwesomeIcons.sliders,
            leadingWidget: _.isImstModule()
                ? NormalButton(text: 'set'.tr, onPressed: _.bleApiSetRadioStack)
                : null,
            widgetFeatures: Column(
              children: [
                Obx(
                  () => FeatureSetTextField(
                    showSetButton: !_.isImstModule(),
                    onPressedSet:
                        !_.isImstModule() ? _.bleApiSetRetransmissions : null,
                    labelText: 'forwardings'.tr,
                    hintText: '0 - ${_.isImstModule() ? '15' : '7'}',
                    initialValue: _.modelDeviceLorawan.setRetransmissions,
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    onChangedText: (t) => _.onChangedRetransmissions(t),
                    errorText: _.modelDeviceLorawan.errorRetransmissions,
                  ),
                ),
                SizedBox(height: 15.0),
                Obx(
                  () => CustomDropdown<int>(
                      showSetButton: !_.isImstModule(),
                      onPressedSet: !_.isImstModule() ? _.bleApiSetBand : null,
                      itemsMap: _.isImstModule()
                          ? LORAWAN_CONSTANTS.IMST_BAND_INDEX
                          : LORAWAN_CONSTANTS.RAK_BAND_INDEX,
                      onChanged: (int k) => _.onChangedBand(k),
                      floatingLabel: 'oper_band'.tr,
                      errorText: _.modelDeviceLorawan.errorSetBand,
                      dropdownTitle: 'select'.tr,
                      dropdownSubtitle: 'select_oper_band'.tr,
                      value: _.isImstModule()
                          ? LORAWAN_CONSTANTS
                              .IMST_BAND_INDEX[_.modelDeviceLorawan.setBand]
                          : LORAWAN_CONSTANTS
                              .RAK_BAND_INDEX[_.modelDeviceLorawan.setBand],
                      hintText: 'select'.tr),
                ),
                SizedBox(height: 15.0),
                Obx(
                  () => CustomDropdown<int>(
                      showSetButton: false,
                      itemsMap: LORAWAN_CONSTANTS.AU915_SUB_BAND_1,
                      onChanged: (int k) => _.onChangedSubBand1(k),
                      floatingLabel: 'sub_band'.trArgs(['1']),
                      errorText: _.modelDeviceLorawan.errorSetSubBand1,
                      dropdownTitle: 'select'.tr,
                      dropdownSubtitle: 'select_sub_band'.trArgs(['1']),
                      value: LORAWAN_CONSTANTS
                          .AU915_SUB_BAND_1[_.modelDeviceLorawan.setSubBand1],
                      hintText: 'select'.tr),
                ),
                SizedBox(height: 15.0),
                Obx(
                  () => CustomDropdown<int>(
                      showSetButton: !_.isImstModule(),
                      onPressedSet:
                          !_.isImstModule() ? _.bleApiSetSubBands : null,
                      itemsMap: LORAWAN_CONSTANTS.AU915_SUB_BAND_2,
                      onChanged: (int k) => _.onChangedSubBand2(k),
                      floatingLabel: 'sub_band'.trArgs(['2']),
                      errorText: _.modelDeviceLorawan.errorSetSubBand2,
                      dropdownTitle: 'select'.tr,
                      dropdownSubtitle: 'select_sub_band'.trArgs(['2']),
                      value: LORAWAN_CONSTANTS
                          .AU915_SUB_BAND_2[_.modelDeviceLorawan.setSubBand2],
                      hintText: 'select'.tr),
                ),
                SizedBox(height: 15.0),
                Obx(
                  () => CustomDropdown<int>(
                      showSetButton: !_.isImstModule(),
                      onPressedSet:
                          !_.isImstModule() ? _.bleApiSetDataRate : null,
                      itemsMap: LORAWAN_CONSTANTS.SPREADING_FACTOR,
                      onChanged: (int k) => _.onChangedSpreadingFactor(k),
                      floatingLabel: 'spread_factor'.tr,
                      errorText: _.modelDeviceLorawan.errorSetSpreadingFactor,
                      dropdownTitle: 'select'.tr,
                      dropdownSubtitle: 'select_spread_factor'.tr,
                      value: LORAWAN_CONSTANTS.SPREADING_FACTOR[
                          _.modelDeviceLorawan.setSpreadingFactor],
                      hintText: 'select'.tr),
                ),
                Obx(
                  () => FeatureSetTextField(
                    showSetButton: !_.isImstModule(),
                    onPressedSet: !_.isImstModule() ? _.bleApiSetTxPower : null,
                    labelText: 'tx_power'.tr,
                    hintText:
                        'dbm (${_.isImstModule() ? '0 - 22' : '10 - 20'})',
                    initialValue: _.modelDeviceLorawan.setPotency,
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    onChangedText: (t) => _.onChangedPotency(t),
                    errorText: _.modelDeviceLorawan.errorPotency,
                  ),
                ),
                SizedBox(height: 15.0),
                if (_.getDeviceVersion() !=
                        ColbitsCompatibleVersion.smartMeterAcV3 ||
                    ModelLogin.isRole(Roles.superAdmin))
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('lora_adr'.tr),
                      Obx(
                        () => CustomSwitch(
                            value: _.modelDeviceLorawan.setAdr,
                            onChanged: (v) => _.onChangeAdr(v)),
                      )
                    ],
                  ),
                if (ModelLogin.isRole(Roles.superAdmin))
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('duty_cycle'.tr),
                      Obx(
                        () => CustomSwitch(
                            value: _.modelDeviceLorawan.setDutyCycle,
                            onChanged: (v) => _.onChangeDutyCycle(v)),
                      )
                    ],
                  ),
                SizedBox(height: 10.0),
                if (ModelLogin.isRole(Roles.superAdmin))
                  Obx(
                    () => CustomDropdown<int>(
                        showSetButton: !_.isImstModule(),
                        onPressedSet:
                            !_.isImstModule() ? _.bleApiSetClass : null,
                        itemsMap: _.mapLoraClassByModule(),
                        onChanged: (int k) => _.onChangedClass(k),
                        floatingLabel: 'class'.tr,
                        errorText: _.modelDeviceLorawan.errorSetClass,
                        dropdownTitle: 'select'.tr,
                        dropdownSubtitle: 'select_class'.tr,
                        value: _.mapLoraClassByModule()[
                            _.modelDeviceLorawan.setClass],
                        hintText: 'select'.tr),
                  )
              ],
            ),
          ),
          SizedBox(height: 8.0)
        ],
      ),
    );
  }
}
