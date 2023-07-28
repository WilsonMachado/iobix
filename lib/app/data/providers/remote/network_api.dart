import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

import '../../models/remote/network/network_response.dart';

class NetworkAPI {
  final Dio _dio = Get.find<Dio>();

  Future<NetworkResponse> requestNetworkCoverage( String deviceId ) async {
    final Response response = await _dio.get('/network/$deviceId');
    return NetworkResponse.fromJson(response.data);
  }
}
