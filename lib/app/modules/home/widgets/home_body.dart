import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:get/get.dart';

import '../home_controller.dart';
import '../../../utils/constants/constants.dart';
import 'bluetooth/bluetooth_device_item.dart';
import 'bluetooth/bluetooth_devices_widget.dart';
import 'home_top_bar.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'home',
      builder: (_) => GestureDetector(
        onTap: _.isDrawerOpen ? _.showDrawer : null,
        child: AnimatedContainer(
          transform:
              Matrix4.translationValues(_.xOffsetDrawer, _.yOffsetDrawer, 0)
                ..scale(_.scaleFactorDrawer)
                ..rotateY(_.isDrawerOpen ? -0.5 : 0),
          duration: CONSTANTS.ANIMATION_DURATION,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(_.isDrawerOpen ? 40.0 : 0.0)),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                HomeTopBar(
                    isDrawerOpenFgControl: _.isDrawerOpen,
                    showDrawerFunction: _.showDrawer,
                    title: 'discover'.tr),
                SizedBox(height: 8.0),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                  child: BluetoothDevicesWidget(),
                ),
                Obx(() => _.blueDevices.length > 0 && _.blueIsScanning
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _.blueDevices.length,
                        itemBuilder: (__, index) {
                          final BluetoothDevice device = _.blueDevices[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                BluetoothDeviceItem(
                                    deviceName: device.name,
                                    deviceType: _.checkDeviceType(device).tr,
                                    buttonText: 'ble_connect'.tr,
                                    onPressed: () => _.connectToDevice(device)),
                                SizedBox(height: 12.0),
                              ],
                            ),
                          );
                        },
                      )
                    : Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
