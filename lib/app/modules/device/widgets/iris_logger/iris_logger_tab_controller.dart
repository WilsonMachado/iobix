import 'package:get/get.dart';
import 'package:iobix/app/data/models/local/model_iris_logger.dart';
import 'package:iobix/app/utils/constants/ble_api/iris_logger/iris_logger_commands.dart';

import '../../device_controller.dart';

class IrisLoggerTabController extends GetxController {
  ModelIrisLogger modelIrisLogger = ModelIrisLogger();

  Future<void> sendDataToDevice(List<int> frame, {String log}) async {
    await Get.find<DeviceController>().sendDataToDevice(frame, log: log);
  }

  Future<void> bleApiDataReport() async {
    await sendDataToDevice([IRIS_LOGGER_CMDS.DATA_REPORT]);
  }
}