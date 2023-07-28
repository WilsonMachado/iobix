import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iobix/app/modules/device/widgets/iris_logger/iris_logger_tab_controller.dart';
import 'package:iobix/app/modules/device/widgets/iris_logger/iris_logger_tab_view.dart';
import 'package:iobix/app/modules/device/widgets/smart_fault_detector/smart_fault_detector_tab_set_view.dart';
import 'package:iobix/app/modules/device/widgets/smart_fault_detector/smart_fault_detector_tab_view.dart';
import 'package:iobix/app/modules/device/widgets/tilt_sensor/tilt_sensor_tab_set_view.dart';
import 'package:iobix/app/modules/device/widgets/tilt_sensor/tilt_sensor_tab_view.dart';
import 'package:iobix/app/modules/device/widgets/vantage_logger_tab/vantage_logger_tab_set_view.dart';

import '../device_controller.dart';
import '../../../utils/helpers/size_config.dart';

import './temperature_logger_tab/temperature_logger_tab_view.dart';
import './temperature_logger_tab/temperature_logger_tab_set_view.dart';
import 'device_top_bar.dart';
import 'system_tab/system_tab_view.dart';
import 'system_tab/system_tab_set_view.dart';
import 'lorawan_tab/lorawan_tab_view.dart';
import 'lorawan_tab/lorawan_tab_set_view.dart';
import 'vantage_logger_tab/vantage_logger_tab_view.dart';
import '../../../utils/constants/enums.dart';
import '../../../widgets/custom_switch.dart';
import 'device_floating_console.dart';
import '../../../widgets/circular_button.dart';
import '../../../theme/text_theme.dart';
import '../../../theme/color_theme.dart';
import '../../../widgets/feature_set_textfield.dart';
import '../../../widgets/loading/loading.dart';
import '../../../widgets/normal_button.dart';
import '../../../widgets/default_card.dart';
import './multipurpose_rs485/multipurpose_rs485_tab_view.dart';
import './multipurpose_rs485/multipurpose_rs485_tab_set_view.dart';
import './matric_potential/matric_potential_tab_view.dart';
import './matric_potential/matric_potential_tab_set_view.dart';
import './smart_meter_ac_tab/smart_meter_ac_tab_set_view.dart';
import './smart_meter_ac_tab/smart_meter_ac_tab_view.dart';
import './level_sensor/level_sensor_tab_set_view.dart';
import './level_sensor/level_sensor_tab_view.dart';
import './iskra_mt174/iskra_mt174_tab_view.dart';
import './smart_meter_dc/smart_meter_dc_tab_view.dart';
import './smart_meter_dc/smart_meter_dc_tab_set_view.dart';
import '../../../data/models/local/model_login.dart';

class DeviceBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceController>(
        builder: (_) => Column(
              children: [
                Obx(
                  () => DeviceTopBar(
                      title: _.title[0],
                      subtitle: '${'version'.tr}: ${_.title[1]}',
                      disconnectFnc: _.disconnectDevice,
                      disconnectTitle: 'alert_title'.tr,
                      disconnectMsg: 'ble_disconnect_alert_msg'.tr),
                ),
                Obx(() {
                  if (_.isApiLogin) {
                    switch (_.bottomNavBarIdx) {
                      case BottomNavBarDevice.home:
                        return Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                  height: getProportionateScreenHeight(0.02)),
                              PreferredSize(
                                preferredSize: Size(30.0, 30.0),
                                child: Container(
                                  height: 30,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: TabBar(
                                      controller: _.tabController,
                                      tabs: _.tabViews,
                                      labelColor: Colors.white,
                                      indicator: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          color:
                                              Theme.of(context).primaryColor),
                                      unselectedLabelColor:
                                          Theme.of(context).primaryColor),
                                ),
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(0.01)),
                              Expanded(
                                child: TabBarView(
                                  controller: _.tabController,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: SpecificDeviceTabView(),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: SystemTabView(),
                                    ),
                                    SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: LorawanTabView(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Obx(() => DeviceFloatingConsole(
                                  title: 'console'.tr,
                                  content: _.consoleText,
                                  control: _.floatingConsole,
                                  closeFnc: () =>
                                      _.onChangedFloatingConsole(false),
                                  trashFnc: _.clearConsole))
                            ],
                          ),
                        );
                        break;

                      case BottomNavBarDevice.config:
                        return Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                  height: getProportionateScreenHeight(0.02)),
                              PreferredSize(
                                preferredSize: Size(30.0, 30.0),
                                child: Container(
                                  height: 30,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: TabBar(
                                      controller: _.tabController,
                                      tabs: _.tabViews,
                                      labelColor: Colors.white,
                                      indicator: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          color:
                                              Theme.of(context).primaryColor),
                                      unselectedLabelColor:
                                          Theme.of(context).primaryColor),
                                ),
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(0.01)),
                              Expanded(
                                child: TabBarView(
                                  controller: _.tabController,
                                  children: [
                                    SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: SpecificDeviceTabSetView(),
                                      ),
                                    ),
                                    SystemTabSetView(),
                                    SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: LorawanTabSetView(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Obx(() => DeviceFloatingConsole(
                                  title: 'console'.tr,
                                  content: _.consoleText,
                                  control: _.floatingConsole,
                                  closeFnc: () =>
                                      _.onChangedFloatingConsole(false),
                                  trashFnc: _.clearConsole))
                            ],
                          ),
                        );
                        break;

                      case BottomNavBarDevice.console:
                        return Expanded(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (ModelLogin.isMegaAdmin)
                                    DefaultCard(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Prueba de tramas (BLE)',
                                            style: textInfoBold,
                                          ),
                                          Obx(
                                            () => FeatureSetTextField(
                                              onPressedSet:
                                                  _.sendTramaBluetooth,
                                              labelText: 'Trama',
                                              hintText: 'Hexadecimal',
                                              maxLength: 500,
                                              onChangedText: (t) =>
                                                  _.onChangedSetTramaBluetooth(
                                                      t),
                                              initialValue: _.setTramaBluetooth,
                                              errorText:
                                                  _.errorSetTramaBluetooth
                                                              .length >
                                                          0
                                                      ? _.errorSetTramaBluetooth
                                                      : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  SizedBox(
                                    height: 30,
                                    child: ListTile(
                                      title: Text('floating_console'.tr),
                                      trailing: CustomSwitch(
                                          onChanged: (v) =>
                                              _.onChangedFloatingConsole(v),
                                          value: _.floatingConsole),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: ListTile(
                                        title: Text('registers'.tr),
                                        trailing: CircularButton(
                                            icon: FontAwesomeIcons.trash,
                                            onPressed: _.clearConsole)),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      reverse: false,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: double.infinity,
                                        child: Text(_.consoleText),
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                        );
                        break;

                      default:
                        return Container();
                    }
                  } else
                    return Expanded(
                        child: Obx(
                      () => Container(
                        padding: EdgeInsets.all(15.0),
                        child: Center(
                          child: !_.isWaitRespApiLogin
                              ? SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('device_security'.tr,
                                          style: textInfoBold),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 80.0),
                                          child: Stack(
                                            alignment: Alignment.centerRight,
                                            children: [
                                              FeatureSetTextField(
                                                  enableSuggestions: false,
                                                  obscureText:
                                                      _.hideApiPassword,
                                                  labelText: '',
                                                  hintText:
                                                      '4 ${'characters'.tr}',
                                                  maxLength: 4,
                                                  initialValue:
                                                      _.passwordApiLogin,
                                                  textAlign: TextAlign.center,
                                                  showSetButton: false,
                                                  onChangedText: (t) => _
                                                      .onChangedPasswordApiLogin(
                                                          t)),
                                              IconButton(
                                                  icon: Icon(
                                                      _.hideApiPassword
                                                          ? Icons
                                                              .visibility_off_rounded
                                                          : Icons
                                                              .visibility_rounded,
                                                      color:
                                                          ColorsTheme.salmon),
                                                  onPressed: _
                                                      .onChangedHideApiPassword)
                                            ],
                                          )),
                                      SizedBox(height: 8.0),
                                      Text(_.errorApiLogin.tr,
                                          style: textInfoError,
                                          textAlign: TextAlign.center),
                                      SizedBox(height: 50.0),
                                      NormalButton(
                                          text: 'send'.tr,
                                          onPressed: _.sendPasswordApiLogin)
                                    ],
                                  ),
                                )
                              : Loading(),
                        ),
                      ),
                    ));
                })
              ],
            ));
  }
}

class SpecificDeviceTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceController>(builder: (_) {
      switch (_.currentDeviceConnect) {
        case ColbitsCompatibleVersion.vantageLoggerV2:
        case ColbitsCompatibleVersion.vantageLoggerV3:
          return VantageLoggerTabView();

        case ColbitsCompatibleVersion.smartFaultDetector:
          return SmartFaultDetectorTabView();

        case ColbitsCompatibleVersion.tiltSensor:
          return TiltSensorTabView();

        case ColbitsCompatibleVersion.temperatureLoggerV2:
        case ColbitsCompatibleVersion.temperatureLoggerV3:
          return TemperatureLoggerTabView();

        //case ColbitsCompatibleVersion.smartMeterAcV2:
        case ColbitsCompatibleVersion.smartMeterAcV3:
        case ColbitsCompatibleVersion.smartMeterAcV3_1:
          return SmartMeterAcTabView();

        case ColbitsCompatibleVersion.multipurposeRS485V1:
          return MultipurposeRS485TabView();

        case ColbitsCompatibleVersion.loggerRS485:
          return Center(
            child: Text('Logger RS485 working!'),
          );

        case ColbitsCompatibleVersion.matricPotentialV1:
        case ColbitsCompatibleVersion.matricPotentialV3_1:
        case ColbitsCompatibleVersion.matricPotentialV4:
          return MatricPotentialTabView();

        case ColbitsCompatibleVersion.levelSensorV1:
          return LevelSensorTabView();

        case ColbitsCompatibleVersion.iskraMt174V1:
          return IskraMt174TabView();

        case ColbitsCompatibleVersion.iRISLogger:
          return IrisLoggerTabView();

        case ColbitsCompatibleVersion.smartMeterDcV2:
        case ColbitsCompatibleVersion.smartMeterDcV3:
          return SmartMeterDcTabView();

        default:
          return Text(
            'device_version_error'.tr,
            style: textInfoItalic,
            textAlign: TextAlign.center,
          );
      }
    });
  }
}

class SpecificDeviceTabSetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceController>(builder: (_) {
      switch (_.currentDeviceConnect) {
        case ColbitsCompatibleVersion.vantageLoggerV3:
          return VantageLoggerTabSetView();
        case ColbitsCompatibleVersion.smartFaultDetector:
          return SmartFaultDetectorTabSetView();
        case ColbitsCompatibleVersion.tiltSensor:
          return TiltSensorTabSetView();
        case ColbitsCompatibleVersion.temperatureLoggerV2:
        case ColbitsCompatibleVersion.temperatureLoggerV3:
          return TemperatureLoggerTabSetView();

        //case ColbitsCompatibleVersion.smartMeterAcV2:
        case ColbitsCompatibleVersion.smartMeterAcV3:
        case ColbitsCompatibleVersion.smartMeterAcV3_1:
          return SmartMeterAcTabSetView();

        case ColbitsCompatibleVersion.multipurposeRS485V1:
          return MultipurposeRS485TabSetView();

        case ColbitsCompatibleVersion.matricPotentialV1:
        case ColbitsCompatibleVersion.matricPotentialV3_1:
        case ColbitsCompatibleVersion.matricPotentialV4:
          return MatricPotentialTabSetView();

        case ColbitsCompatibleVersion.levelSensorV1:
          return LevelSensorTabSetView();

        case ColbitsCompatibleVersion.smartMeterDcV2:
        case ColbitsCompatibleVersion.smartMeterDcV3:
          return SmartMeterDcTabSetView();

        default:
          return Center(
              child: Text('no_specific_settings'.tr, style: textInfoItalic));
      }
    });
  }
}
