import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import './temperature_logger_tab_controller.dart';
import '../../../../widgets/features_set_card.dart';
import '../../../../widgets/feature_set_textfield.dart';
import '../../../../widgets/circular_button.dart';
import '../../../../widgets/normal_button.dart';
import '../../../../widgets/custom_dropdown/custom_dropdown.dart';
import '../../../../theme/color_theme.dart';
import '../../../../utils/constants/ble_api/temperature_logger/temperature_logger_constants.dart';
import '../../../../theme/text_theme.dart';
import '../../../../data/models/local/model_login.dart';
import '../../../../utils/constants/enums.dart';

class TemperatureLoggerTabSetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TemperatureLoggerTabController>(
        id: 'ntcSensorAlarmCard',
        builder: (_) => Column(children: [
              if (ModelLogin.isRole(Roles.superAdmin))
                FeaturesSetCard(
                  title: 'complementary_sensors'.tr,
                  iconMain: Icons.developer_board_rounded,
                  widgetFeatures: Column(
                    children: [
                      SizedBox(height: 15.0),
                      Obx(
                        () => CustomDropdown<int>(
                          showSetButton: true,
                          onPressedSet: _.bleApiSetI2cSensor,
                          itemsMap: TEMPERATURE_LOGGER_CONSTANTS.I2C_SENSOR_MAP,
                          onChanged: (int k) => _.onChangedI2cSensor(k),
                          floatingLabel: 'digital_sensor'.tr,
                          errorText: _.modelTemperatureLogger.errorSetI2cSensor,
                          dropdownTitle: 'select'.tr,
                          dropdownSubtitle: 'select_digital_sensor'.tr,
                          value: TEMPERATURE_LOGGER_CONSTANTS
                              .I2C_SENSOR_MAP[
                                  _.modelTemperatureLogger.setI2cSensor]
                              .tr,
                          hintText: 'select'.tr,
                        ),
                      )
                    ],
                  ),
                ),
              Obx(
                () => FeaturesSetCard(
                  title: 'alarm_parameters'.tr,
                  iconMain: FontAwesomeIcons.bell,
                  leadingWidget: NormalButton(
                      text: 'set'.tr, onPressed: _.bleApiSetAlarms),
                  widgetFeatures: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_.errorNoneAlarmToSet.length > 0)
                        Text(_.errorNoneAlarmToSet, style: textInfoError),
                      if (_.numNtcSensorToSet == 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('set_all'.tr),
                            Checkbox(
                              value: _.setAllSameAlarms,
                              onChanged: (v) => _.onChangedSetAllSameAlarms(v),
                            ),
                          ],
                        ),
                      SizedBox(height: 15.0),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _.numNtcSensorToSet,
                          itemBuilder: (__, idx) {
                            int dropdownValue = _.alarmValuesToSet.length > idx
                                ? _.alarmValuesToSet[idx][0]
                                : null;

                            return Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          border: Border.all(
                                              color: ColorsTheme.opaqueBlue,
                                              width: 2)),
                                      padding: EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          CustomDropdown<int>(
                                              showSetButton: false,
                                              itemsMap: ((_
                                                      .isFwHigherOrEqual1_0_3)
                                                  ? _.ntcSensorMapDynamicV103
                                                  : _.ntcSensorMapDynamic),
                                              onChanged: (v) =>
                                                  _.onChangedDropdownNtcSensor(
                                                      v, dropdownValue),
                                              value: (_.isFwHigherOrEqual1_0_3)
                                                  ? _.ntcSensorMapV103[
                                                      dropdownValue]
                                                  : _.ntcSensorMap[
                                                      dropdownValue],
                                              hintText: 'select'.tr,
                                              floatingLabel: 'Sensor',
                                              dropdownTitle: 'select'.tr,
                                              dropdownSubtitle:
                                                  'what_sensor_set'.tr,
                                              errorText: null),
                                          if (dropdownValue != null)
                                            Column(
                                              children: [
                                                FeatureSetTextField(
                                                    showSetButton: false,
                                                    labelText: 'Delta',
                                                    hintText: '1 - 10',
                                                    keyboardType:
                                                        TextInputType.number,
                                                    maxLength: 2,
                                                    onChangedText: (t) =>
                                                        _.onChangedDeltaValue(
                                                            t, idx),
                                                    initialValue:
                                                        _.alarmValuesToSet[idx]
                                                            [1],
                                                    errorText:
                                                        _.alarmValuesToSet[idx]
                                                            [4]),
                                                FeatureSetTextField(
                                                    showSetButton: false,
                                                    labelText:
                                                        'lower_threshold'.tr,
                                                    hintText: '1 - 99',
                                                    keyboardType:
                                                        TextInputType.number,
                                                    maxLength: 2,
                                                    onChangedText: (t) =>
                                                        _.onChangedMinValue(
                                                            t, idx),
                                                    initialValue:
                                                        _.alarmValuesToSet[idx]
                                                            [2],
                                                    errorText:
                                                        _.alarmValuesToSet[idx]
                                                            [5]),
                                                FeatureSetTextField(
                                                    showSetButton: false,
                                                    labelText:
                                                        'upper_threshold'.tr,
                                                    hintText: '1 - 99',
                                                    keyboardType:
                                                        TextInputType.number,
                                                    maxLength: 2,
                                                    onChangedText: (t) =>
                                                        _.onChangedMaxValue(
                                                            t, idx),
                                                    initialValue:
                                                        _.alarmValuesToSet[idx]
                                                            [3],
                                                    errorText:
                                                        _.alarmValuesToSet[idx]
                                                            [6])
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15.0)
                                  ],
                                ),
                                if (_.numNtcSensorToSet > 1)
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: CircularButton(
                                        onPressed: () =>
                                            _.removeSensorToSet(idx),
                                        icon: FontAwesomeIcons.xmark,
                                      )),
                              ],
                            );
                          }),
                      if ((!_.setAllSameAlarms) &&
                          (_.numNtcSensorToSet < _.totalNtcSensor) &&
                          !(_.modelTemperatureLogger.deviceVersion == 3.0 &&
                              _.isFwHigherOrEqual1_0_3))
                        Center(
                          child: CircularButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: _.addSensorToSet),
                        ),
                      if ((!_.setAllSameAlarms) &&
                          (_.numNtcSensorToSet < 6) &&
                          (_.modelTemperatureLogger.deviceVersion == 3.0 &&
                              _.isFwHigherOrEqual1_0_3))
                        Center(
                          child: CircularButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: _.addSensorToSet),
                        )
                    ],
                  ),
                ),
              )
            ]));
  }
}
