import 'package:get/instance_manager.dart';

import '../../providers/remote/network_api.dart';
import '../../models/remote/network/network_response.dart';

class NetworkRepository {
  final NetworkAPI _networkAPI = Get.find<NetworkAPI>();

  Future<NetworkResponse> requestNetworkCoverage(String deviceId) =>
      _networkAPI.requestNetworkCoverage(deviceId);
}
