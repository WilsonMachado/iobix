import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import './smart_meter_dc_tab_controller.dart';
import '../../../../widgets/features_set_card.dart';
import '../../../../widgets/normal_button.dart';
import '../../../../widgets/circular_button.dart';
import '../../../../widgets/custom_dropdown/custom_dropdown.dart';
import '../../../../widgets/feature_set_textfield.dart';
import '../../../../theme/text_theme.dart';
import '../../../../theme/color_theme.dart';

class SmartMeterDcTabSetView extends StatelessWidget {
  const SmartMeterDcTabSetView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartMeterDcTabController>(
      id: 'tabSetView',
      builder: (_) => Column(
        children: [
          Obx(
            () => FeaturesSetCard(
              title: 'alarm_parameters'.tr,
              iconMain: FontAwesomeIcons.bell,
              leadingWidget: NormalButton(
                text: 'set'.tr,
                onPressed: _.bleApiSetDataAlarms,
              ),
              widgetFeatures: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_.errorNoneAlarmToSet.length > 0)
                    Text(
                      _.errorNoneAlarmToSet,
                      style: textInfoError,
                    ),
                  if (_.numChannelsToSet == 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'set_all'.tr,
                        ),
                        Checkbox(
                          value: _.setAllSameAlarms,
                          onChanged: (v) => _.onChangedSetAllSameAlarms(v),
                        )
                      ],
                    ),
                  SizedBox(height: 15.0),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _.numChannelsToSet,
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
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    color: ColorsTheme.opaqueBlue,
                                    width: 2,
                                  ),
                                ),
                                padding: EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    CustomDropdown<int>(
                                      showSetButton: false,
                                      itemsMap: _.dynamicChannelMap,
                                      onChanged: (v) =>
                                          _.onChangedDropdownChannel(
                                        v,
                                        dropdownValue,
                                      ),
                                      value: _.channelMap[dropdownValue],
                                      hintText: 'select'.tr,
                                      floatingLabel: 'Canal',
                                      dropdownTitle: 'select'.tr,
                                      dropdownSubtitle:
                                          '¿Qué canal desea configurar?'.tr,
                                      errorText: null,
                                    ),
                                    if (dropdownValue != null)
                                      Column(
                                        children: [
                                          FeatureSetTextField(
                                            showSetButton: false,
                                            labelText: 'Delta',
                                            hintText: '1 - 10',
                                            keyboardType: TextInputType.number,
                                            maxLength: 2,
                                            onChangedText: (t) =>
                                                _.onChangedDeltaValue(
                                              t,
                                              idx,
                                            ),
                                            initialValue:
                                                _.alarmValuesToSet[idx][1],
                                            errorText: _.alarmValuesToSet[idx]
                                                [4],
                                          ),
                                          FeatureSetTextField(
                                            showSetButton: false,
                                            labelText: 'lower_threshold'.tr,
                                            hintText: '1 - 48',
                                            keyboardType: TextInputType.number,
                                            maxLength: 2,
                                            onChangedText: (t) =>
                                                _.onChangedMinValue(
                                              t,
                                              idx,
                                            ),
                                            initialValue:
                                                _.alarmValuesToSet[idx][2],
                                            errorText: _.alarmValuesToSet[idx]
                                                [5],
                                          ),
                                          FeatureSetTextField(
                                            showSetButton: false,
                                            labelText: 'upper_threshold'.tr,
                                            hintText: '48 - 60',
                                            keyboardType: TextInputType.number,
                                            maxLength: 2,
                                            onChangedText: (t) =>
                                                _.onChangedMaxValue(
                                              t,
                                              idx,
                                            ),
                                            initialValue:
                                                _.alarmValuesToSet[idx][3],
                                            errorText: _.alarmValuesToSet[idx]
                                                [6],
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                            ],
                          ),
                          if (_.numChannelsToSet > 1)
                            Align(
                              alignment: Alignment.topRight,
                              child: CircularButton(
                                onPressed: () => _.removeChannelToSet(idx),
                                icon: FontAwesomeIcons.xmark,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  if (_.numChannelsToSet < _.totalChannel)
                    Center(
                      child: CircularButton(
                        icon: FontAwesomeIcons.plus,
                        onPressed: _.addSensorToSet,
                      ),
                    ),
                ],
              ),
            ),
          ),
          FeaturesSetCard(
            title: 'Ajustes adicionales',
            iconMain: FontAwesomeIcons.sliders,
            widgetFeatures: Column(
              children: [
                Obx(
                  () => FeatureSetTextField(
                    labelText: 'Rango de corriente',
                    hintText: 'Rango (0 - 9999) A',
                    initialValue: _.modelSmartMeterDc.setCurrentRange,
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    onChangedText: (t) => _.onChangedSetCurrentRange(t),
                    onPressedSet: _.bleApiSetCurrentRange,
                    showSetButton: true,
                    errorText: _.modelSmartMeterDc.errorSetCurrentRange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
