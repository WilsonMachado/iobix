import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../home_controller.dart';
import '../../../../widgets/loading/loading.dart';
import '../../../../widgets/vertical_step_progress.dart';
import '../../../../widgets/big_button.dart';
import '../../../../utils/helpers/size_config.dart';
import '../../../../theme/text_theme.dart';
import '../../../../theme/color_theme.dart';

class BluetoothDevicesWidget extends StatelessWidget {
  const BluetoothDevicesWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white),
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  Text('ble_card_title'.tr,
                      style: miniTitle, textAlign: TextAlign.center),
                  SizedBox(height: 15.0),
                  Text('ble_card_content'.tr,
                      style: textContent, textAlign: TextAlign.center),
                  SizedBox(height: 15.0),
                  Image.asset('assets/images/splash/ble_devices.jpg'),
                  SizedBox(height: 15.0),
                  Obx(() {
                    switch (_.blueState) {
                      case BluetoothState.off:
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ble_card_off'.tr),
                            Text('Bluetooth', style: textInfoBold)
                          ],
                        );
                        break;

                      case BluetoothState.turningOn:
                        return Text('ble_card_turning_on'.tr,
                            style: textInfo, textAlign: TextAlign.center);
                        break;

                      case BluetoothState.on:
                        return _.blueTryConnectToDevice
                            ? Column(
                                children: [
                                  Text('ble_card_connecting'.tr,
                                      style: textInfo,
                                      textAlign: TextAlign.center),
                                  SizedBox(height: 8.0),
                                  Loading(),
                                  VerticalStepProgress(
                                    lenSteps: _.stepsProgressTryConnectToDevice,
                                    currentStep: _
                                        .currentIndexStepProgressTryConnectToDevice,
                                    msgStep: _.msgProgressTryConnectToDevice,
                                    successIcon: FontAwesomeIcons.check,
                                  )
                                ],
                              )
                            : _.blueIsScanning
                                ? Column(
                                    children: [
                                      Text('ble_card_scanning'.tr,
                                          style: textInfo,
                                          textAlign: TextAlign.center),
                                      SizedBox(height: 8.0),
                                      Loading()
                                    ],
                                  )
                                : Column(
                                    children: [
                                      _.blueErrorTryConnectToDevice
                                          ? Column(
                                              children: [
                                                Text('ble_card_error'.tr,
                                                    style: textInfo,
                                                    textAlign:
                                                        TextAlign.center),
                                                Text(
                                                    _.blueErrorMsgTryConnectToDevice
                                                        .tr,
                                                    style: textInfoBold,
                                                    textAlign:
                                                        TextAlign.center),
                                                SizedBox(height: 8.0),
                                              ],
                                            )
                                          : Container(),
                                      BigButton(
                                          text: 'ble_card_start_scan'.tr,
                                          onPressed: _.initBlueScan,
                                          colorButton: ColorsTheme.salmon,
                                          width:
                                              getProportionateScreenWidth(0.8),
                                          height: getProportionateScreenHeight(
                                              0.05))
                                    ],
                                  );
                        break;

                      case BluetoothState.turningOff:
                        return Text('ble_card_turning_off'.tr,
                            style: textInfo, textAlign: TextAlign.center);
                        break;

                      default:
                        return Text('ble_card_error_interface'.tr,
                            style: textInfo, textAlign: TextAlign.center);
                    }
                  }),
                  SizedBox(height: 15.0),
                ],
              ))
        ],
      ),
    );
  }
}
