import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import './system_tab_controller.dart';
import './battery_card.dart';
import '../../../../widgets/circular_button.dart';
import '../../../../widgets/custom_switch.dart';
import '../../../../widgets/feature_trigger_card.dart';
import '../../../../widgets/information_card.dart';
import '../../../../theme/text_theme.dart';
import '../../../../widgets/vertical_indicator_card.dart';
import '../../../../widgets/horizontal_indicator_card.dart';
import '../../../../widgets/features_set_card.dart';
import 'system_tab_memory_card.dart';
import '../../../../data/models/local/model_login.dart';
import '../../../../widgets/normal_button.dart';
import '../../../../utils/constants/ble_api/ble_general_constants.dart';

class SystemTabView extends StatelessWidget {
  const SystemTabView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemTabController>(
      builder: (_) => RefreshIndicator(
        onRefresh: _.bleApiGeneralReport,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: FeatureTriggerCard(
                        title: 'reset'.tr,
                        actionWidget: CircularButton(
                            icon: FontAwesomeIcons.rotateRight,
                            onPressed: _.bleApiMcuReset),
                        iconMain: FontAwesomeIcons.microchip),
                  ),
                  Expanded(
                    child: FeatureTriggerCard(
                        title: 'Buzzer',
                        actionWidget: CircularButton(
                            icon: FontAwesomeIcons.play,
                            onPressed: _.bleApiBuzzer),
                        iconMain: FontAwesomeIcons.drumSteelpan),
                  ),
                  Expanded(
                    child: Obx(
                      () => FeatureTriggerCard(
                          title: 'Leds                   ',
                          iconMain: Icons.wb_iridescent_rounded,
                          actionWidget: CustomSwitch(
                              value: _.modelDeviceGeneral.leds,
                              onChanged: (v) => _.bleApiLeds(v))),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => FeatureTriggerCard(
                          title: 'confirmed_msgs'.tr,
                          iconMain: FontAwesomeIcons.envelope,
                          actionWidget: CustomSwitch(
                              value: _.modelDeviceGeneral.confirmedMessages,
                              onChanged: (v) => _.bleApiConfirmedMessages(v))),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => FeatureTriggerCard(
                          title: 'tampering'.tr,
                          actionWidget: Text(_.modelDeviceGeneral.tampering.tr),
                          iconMain: FontAwesomeIcons.idBadge),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(() => FeaturesSetCard(
                        title: 'motion'.tr,
                        iconMain: Icons.screen_rotation_rounded,
                        leadingWidget: CustomSwitch(
                            value: _.modelDeviceGeneral.acelerometer,
                            onChanged: (v) => _.bleApiAcelerometer(v)),
                        widgetFeatures: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('orientation'.tr),
                                Text(
                                  _.modelDeviceGeneral.acelerometerOrientation
                                      .tr,
                                  style: textInfoMiniBold,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('fall_alarm'.tr),
                                Text(
                                  _.modelDeviceGeneral.acelerometerFallAlarm
                                      ? 'active'.tr
                                      : 'inactive'.tr,
                                  style: textInfoMiniBold,
                                )
                              ],
                            )
                          ],
                        ))),
                  ),
                  Obx(
                    () => FeatureTriggerCard(
                        title: 'Dato de prueba',
                        actionWidget: Column(
                          children: [
                            NormalButton(
                              text: 'Enviar',
                              onPressed: (_.isEnableSendTestData)
                                  ? _.bleApiSendTestData
                                  : null,
                            ),
                            if (!_.isEnableSendTestData)
                              Text('Espere...', style: textInfoMiniItalic)
                          ],
                        ),
                        iconMain: FontAwesomeIcons.paperPlane),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => FeaturesSetCard(
                        title: 'GPS',
                        iconMain: Icons.location_on_rounded,
                        leadingWidget: Row(
                          children: [
                            CustomSwitch(
                                value: _.modelDeviceGeneral.gnss,
                                onChanged: (v) => _.bleApiGnss(v)),
                            SizedBox(width: 8),
                            NormalButton(
                                text: 'Sincronizar',
                                onPressed: (!_.modelDeviceGeneral.isGpsSync &&
                                        _.modelDeviceGeneral.gnss)
                                    ? _.bleApiGpsSync
                                    : null),
                          ],
                        ),
                        widgetFeatures: (_.modelDeviceGeneral.isGpsSync ||
                                _.modelDeviceGeneral.gpsSyncStatus ==
                                    BLE_GENERAL_CONSTANTS.GPS_SYNC_OK)
                            ? Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                        (_.modelDeviceGeneral.isGpsSync)
                                            ? 'Sincronizando...\r\n(Este proceso puede tardar hasta 5 minutos, por favor espere)'
                                            : 'Su dispositivo se ha sincronizado correctamente',
                                        style: textInfoMiniItalic),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    height: 180,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.white),
                                    child: GoogleMap(
                                      onMapCreated: _.onMapCreated,
                                      markers: Set.of(
                                        _.modelDeviceGeneral.markersGoogleMap
                                            .values,
                                      ),
                                      initialCameraPosition: CameraPosition(
                                          target: LatLng(3.43477, -76.53905)),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Obx(
                      () => BatteryCard(
                        value: _.modelDeviceGeneral.batteryValue,
                        percentage: _.modelDeviceGeneral.batteryPercentage,
                        title: 'battery'.tr,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Obx(
                      () => HorizontalIndicatorCard(
                        title: 'Temperatura interna',
                        value: _.modelDeviceGeneral.temperature,
                        digits: 1,
                        unit: ' °C',
                        icon: FontAwesomeIcons.temperatureThreeQuarters,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => VerticalIndicatorCard(
                          title: 'solar_panel'.tr,
                          value: _.modelDeviceGeneral.solarPanel,
                          digits: 2,
                          unit: 'V',
                          icon: FontAwesomeIcons.solarPanel,
                          iconSize: 20),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => VerticalIndicatorCard(
                          title: 'aux_voltage'.tr,
                          value: _.modelDeviceGeneral.supply,
                          digits: 2,
                          unit: 'V',
                          icon: Icons.power_input_rounded,
                          iconSize: 20),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => InformationCard(
                        title: 'periods'.tr,
                        iconMain: FontAwesomeIcons.clock,
                        content: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${'measure'.tr} (s)', style: textInfo),
                              Text(_.modelDeviceGeneral.getMeasureTime,
                                  style: textInfoBold),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${'transmission'.tr} (m)', style: textInfo),
                              Text(_.modelDeviceGeneral.getTxTime,
                                  style: textInfoBold),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => InformationCard(
                        title: 'clock'.tr,
                        iconMain: FontAwesomeIcons.solidClock,
                        content: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('date'.tr, style: textInfo),
                              Text(
                                  _.modelDeviceGeneral.getRtcDate != null
                                      ? DateFormat.yMMMd().format(
                                          _.modelDeviceGeneral.getRtcDate)
                                      : '?',
                                  style: textInfoBold),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('hour'.tr, style: textInfo),
                              Text(
                                  _.modelDeviceGeneral.getRtcTime != null
                                      ? _.modelDeviceGeneral.getRtcTime
                                          .format(context)
                                      : '?',
                                  style: textInfoBold),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SystemTabMemoryCard(),
              Row(
                children: [
                  if (ModelLogin.isAdmin())
                    Obx(
                      () => FeatureTriggerCard(
                        title: 'maintenance'.tr,
                        actionWidget: CustomSwitch(
                            value: _.modelDeviceGeneral.maintenance,
                            onChanged: (v) => _.bleApiMaintenance(v)),
                        iconMain: FontAwesomeIcons.sliders,
                      ),
                    ),
                  Expanded(
                    child: Obx(
                      () => InformationCard(
                        title: 'device_info'.tr,
                        iconMain: Icons.info_outline_rounded,
                        reloadFnc: _.bleApiGetDeviceInformation,
                        content: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('developer'.tr, style: textInfo),
                              SizedBox(width: 10.0),
                              Text(_.modelDeviceInformation.developer,
                                  style: (ModelLogin.isAdmin())
                                      ? textInfoMiniBold
                                      : textInfoBold),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('information'.tr, style: textInfo),
                              SizedBox(width: 10.0),
                              Flexible(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(_.modelDeviceInformation.info.tr,
                                      style: (ModelLogin.isAdmin())
                                          ? textInfoMiniBold
                                          : textInfoBold),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Firmware', style: textInfo),
                              SizedBox(width: 10.0),
                              Text(
                                _.modelDeviceInformation.firmware.tr,
                                style: (ModelLogin.isAdmin())
                                    ? textInfoMiniBold
                                    : textInfoBold,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('API BLE', style: textInfo),
                              SizedBox(width: 10.0),
                              Text(_.modelDeviceInformation.apiBleVersion.tr,
                                  style: (ModelLogin.isAdmin())
                                      ? textInfoMiniBold
                                      : textInfoBold),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Id', style: textInfo),
                              SizedBox(width: 10.0),
                              Text(_.modelDeviceInformation.getId,
                                  style: (ModelLogin.isAdmin())
                                      ? textInfoMiniBold
                                      : textInfoBold),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0)
            ],
          ),
        ),
      ),
    );
  }
}
