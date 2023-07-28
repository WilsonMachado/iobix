import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './widgets/device_body.dart';
import 'widgets/device_bottom_nav_bar.dart';
import './device_controller.dart';

class DevicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceController>(
      id: 'device_page',
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Scaffold(
              body: DeviceBody(),
              bottomNavigationBar: _.isApiLogin ? DeviceBottomNavBar() : null
            ),
          ),
        ),
      ),
    );
  }
}
