import 'package:get/get.dart';

import '../../device_controller.dart';
import '../../../../data/models/local/model_multipurpose_rs485.dart';
import '../../../../utils/constants/ble_api/multipurpose_rs485/multipurpose_rs485_commands.dart';

class RS485Device {
  final int mask;
  final String name;

  RS485Device(this.mask, this.name);
}

class MultipurposeRS485TabController extends GetxController {
  ModelMultipurposeRS485 modelMultipurposeRS485 = ModelMultipurposeRS485();
  RxString _errorSetDevices = ''.obs;
  String get errorSetDevices => _errorSetDevices.value;

  Future<void> sendDataToDevice(List<int> frame, {String log}) async {
    await Get.find<DeviceController>().sendDataToDevice(frame, log: log);
  }

  Future<void> bleApiDataReport() async {
    await sendDataToDevice([MULTIPURPOSE_RS485_CMDS.DATA_REPORT]);

    await sendDataToDevice(
        [MULTIPURPOSE_RS485_CMDS.DATA_REPORT_PRESSURE_SCOUT]);
  }

  void onChangedSetDevices(bool v, int mask) {
    if (v) {
      modelMultipurposeRS485.setDevices |= mask;
    } else {
      modelMultipurposeRS485.setDevices &= ~mask;
    }

    if (_errorSetDevices.value.length > 0) _errorSetDevices.value = '';
  }

  bool getValueSetDevices(int mask) {
    return (modelMultipurposeRS485.setDevices & mask > 0) ? true : false;
  }

  Future<void> bleApiSetRS485Devices() async {
    if (modelMultipurposeRS485.setDevices > 0) {
      await sendDataToDevice([
        MULTIPURPOSE_RS485_CMDS.SET_DEVICES,
        modelMultipurposeRS485.setDevices
      ]);
    } else {
      _errorSetDevices.value = modelMultipurposeRS485.setDevices.toString();
    }
  }
}
