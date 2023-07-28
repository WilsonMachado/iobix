import 'package:get/get.dart';

import './device_controller.dart';
import './widgets/system_tab/system_tab_controller.dart';
import './widgets/lorawan_tab/lorawan_tab_controller.dart';

class DeviceBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LorawanTabController());
    Get.put(SystemTabController());
    Get.put(DeviceController());    
  }
}
