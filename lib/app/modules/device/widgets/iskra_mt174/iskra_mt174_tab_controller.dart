import 'package:get/get.dart';

import '../../device_controller.dart';
import '../../../../data/models/local/model_iskra_mt174.dart';
import '../../../../utils/constants/ble_api/iskra_mt174/iskra_mt174_commands.dart';

class IskraMt174TabController extends GetxController {
  ModelIskraMt174 modelIskraMt174 = ModelIskraMt174();

  Future<void> sendDataToDevice(List<int> frame, {String log}) async {
    await Get.find<DeviceController>().sendDataToDevice(frame, log: log);
  }

  Future<void> bleApiDataReport() async {
    await sendDataToDevice([ISKRA_MT174_CMDS.DATA_REPORT]);
  }
}
