import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../widgets/circular_button.dart';
import './system_tab_controller.dart';
import '../../../../widgets/features_set_card.dart';
import '../../../../utils/constants/ble_api/ble_general_constants.dart';
import '../../../../widgets/normal_button.dart';
import '../../../../widgets/custom_dropdown/custom_dropdown.dart';
import '../../../../widgets/custom_alert_modal_bottom_sheet.dart';
import '../../../../theme/text_theme.dart';
import '../../../../theme/color_theme.dart';
import '../../../../widgets/loading/loading.dart';
import '../../../../data/models/local/model_login.dart';
import '../../../../utils/constants/enums.dart';

class SystemTabMemoryCard extends StatelessWidget {
  const SystemTabMemoryCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemTabController>(
        builder: (_) => FeaturesSetCard(
              title: 'memory'.tr,
              iconMain: FontAwesomeIcons.memory,
              leadingWidget: Obx(
                () => Row(
                  children: [
                    if (ModelLogin.isRole(Roles.superAdmin))
                      CircularButton(
                          icon: FontAwesomeIcons.exclamation,
                          onPressed: _.modelDeviceMemory.isReadData
                              ? null
                              : () {
                                  showCupertinoModalBottomSheet(
                                      barrierColor: Colors.black38,
                                      expand: false,
                                      context: context,
                                      builder: (context) =>
                                          CustomAlertModalBottomSheet(
                                              title: 'alert_title'.tr,
                                              message:
                                                  'memory_clear_logsys_msg'.tr,
                                              actionYes: () =>
                                                  _.bleApiClearLogSys()));
                                }),
                    SizedBox(width: 8.0),
                    CircularButton(
                        icon: FontAwesomeIcons.trash,
                        onPressed: _.modelDeviceMemory.isReadData
                            ? null
                            : () {
                                showCupertinoModalBottomSheet(
                                    barrierColor: Colors.black38,
                                    expand: false,
                                    context: context,
                                    builder: (context) =>
                                        CustomAlertModalBottomSheet(
                                            title: 'alert_title'.tr,
                                            message: 'memory_clear_msg'.tr,
                                            actionYes: () =>
                                                _.bleApiClearLogApp()));
                              }),
                  ],
                ),
              ),
              widgetFeatures: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.0),
                  Obx(
                    () => CustomDropdown<int>(
                        showSetButton: false,
                        floatingLabel: 'memory_block'.tr,
                        itemsMap: BLE_GENERAL_CONSTANTS.MEMORY_LOG_TYPE,
                        onChanged: _.modelDeviceMemory.isReadData
                            ? null
                            : (int k) => _.onChangedMemoryLogType(k),
                        value: BLE_GENERAL_CONSTANTS
                            .MEMORY_LOG_TYPE[_.modelDeviceMemory.logType].tr,
                        hintText: 'select'.tr,
                        errorText: null,
                        dropdownTitle: 'select'.tr,
                        dropdownSubtitle: 'select_memory_block'.tr),
                  ),
                  SizedBox(height: 15.0),
                  Obx(
                    () => CustomDropdown<int>(
                        showSetButton: false,
                        floatingLabel: 'event_type'.tr,
                        itemsMap: _.memoryDataTypeMap(),
                        onChanged: _.modelDeviceMemory.isReadData
                            ? null
                            : (int k) => _.onChangedMemoryDataType(k),
                        value: _
                            .memoryDataTypeMap()[_.modelDeviceMemory.dataType]
                            .tr,
                        hintText: 'select'.tr,
                        valueFontSize: 12.0,
                        errorText: _.modelDeviceMemory.errordataType,
                        dropdownTitle: 'select'.tr,
                        dropdownSubtitle: 'select_event_type'.tr),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text('date_range'.tr, style: textInfoBold),
                      SizedBox(width: 10.0),
                      Obx(
                        () => CircularButton(
                            icon: FontAwesomeIcons.calendar,
                            iconSize: 15.0,
                            onPressed: _.modelDeviceMemory.isReadData
                                ? null
                                : () => _.getDateRangePickerMemory(context)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('from'.tr, style: textInfo),
                      Obx(
                        () => Text(
                            DateFormat.yMMMd()
                                .format(_.modelDeviceMemory.readInitDate),
                            style: textInfoBold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('to'.tr, style: textInfo),
                      Obx(
                        () => Text(
                            DateFormat.yMMMd()
                                .format(_.modelDeviceMemory.readFinishDate),
                            style: textInfoBold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Obx(
                    () {
                      if (_.modelDeviceMemory.isReadData) {
                        return Column(
                          children: [
                            Loading(),
                            Text('reading_memory'.tr,
                                textAlign: TextAlign.center),
                            Text(_.modelDeviceMemory.counterFrames.toString(),
                                style: textInfoBold),
                            Text('data_found'.tr),
                            NormalButton(text: 'Cancelar', onPressed: _.cancelMemoryRead)
                          ],
                        );
                      } else
                        return Column(
                          children: [
                            (_.modelDeviceMemory.isDataNotFound)
                                ? Text('data_not_found_msg'.tr,
                                    textAlign: TextAlign.center)
                                : (_.modelDeviceMemory.isDataFound)
                                    ? Column(
                                        children: [
                                          Text(
                                              'finish_read_memory'.trArgs([
                                                _.modelDeviceMemory
                                                    .counterFrames
                                                    .toString()
                                              ]),
                                              textAlign: TextAlign.center),
                                          SizedBox(height: 8.0),
                                          if (ModelLogin.isAdmin())
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text('see_data_console'.tr),
                                                    CircularButton(
                                                        icon: FontAwesomeIcons
                                                            .windowRestore,
                                                        iconColor: ColorsTheme
                                                            .darkBlue,
                                                        iconSize: 15.0,
                                                        onPressed:
                                                            _.readMemoryLogs),
                                                  ],
                                                ),
                                                SizedBox(height: 8.0)
                                              ],
                                            ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text('share_file'.tr),
                                              CircularButton(
                                                  icon: FontAwesomeIcons.share,
                                                  iconColor:
                                                      ColorsTheme.darkBlue,
                                                  iconSize: 15.0,
                                                  onPressed: _.shareMemoryLogs)
                                            ],
                                          ),
                                          SizedBox(height: 8.0)
                                        ],
                                      )
                                    : Container(),
                            Align(
                                alignment: Alignment.center,
                                child: NormalButton(
                                    text: 'read_data'.tr,
                                    onPressed: () => _.bleApiMemoryRead()))
                          ],
                        );
                    },
                  )
                ],
              ),
            ));
  }
}
