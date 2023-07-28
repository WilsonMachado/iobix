import 'dart:convert';
import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'dart:math' as Math;
import 'package:convert/convert.dart';

String getCurrentHour() {
  DateFormat format = DateFormat('HH:mm:ss');
  return format.format(DateTime.now());
}

List<int> divideIntInNBytes(int integer, int n) {
  List<int> list = [];

  for (var i = n; i > 0; i--) {
    list.add((integer >> (i - 1) * 8) & 0x000000FF);
  }

  return list;
}

double adcToValue(int measure, int resolution, double ref) {
  return resolution != 0 ? (measure * ref) / resolution : 0.0;
}

double batteryToPercentage(double nominalMax, nominalMin, measure) {
  if (nominalMax - nominalMin == 0) return 0.00;
  double value = (measure - nominalMin) / (nominalMax - nominalMin);
  if (value > 1)
    value = 1.00;
  else if (value < 0) value = 0.00;
  return double.parse(value.toStringAsFixed(2));
}

double adcToTemperature(int adc, int res, int ro, int rf, int b) {
  double logValue = ((adc * rf) / (res - adc) / ro);

  double temp = double.parse(
      (1.0 / (((Math.log(logValue) / Math.log(Math.e)) / b) + 1 / 298.15) -
              273.15)
          .toStringAsFixed(2));
  if (temp < 0) temp = 0.00;
  return temp;
}

int temperatureToAdc(double temp, int res, int ro, int rf, int b) {
  int adc = ((res *
              ro *
              Math.pow(Math.e, ((b / (temp + 273.15)) - (b / 298.15)))) /
          (ro * Math.pow(Math.e, ((b / (temp + 273.15)) - (b / 298.15))) + rf))
      .round();

  return adc;
}

int listBytesToInt(List<int> data) {
  int value = 0;

  for (int i = 0; i < data.length; i++) {
    value |= data[i] << (data.length - 1 - i) * 8;
  }
  return value;
}

int concatenateBytes(int high, int low, int shift) {
  int c = ((high << (shift)) + low);
  return c;
}

int hexC2ToDecimal(int hex, int bytes) { // Convertir el número hexadecimal en C2 a decimal 
   
 if ((hex & (1 << ((8 * bytes) - 1))) != 0) {  // Verificar si el número es negativo  
    hex = hex.toSigned(8 * bytes);
  }
  return hex; // Devolver el número en decimal como un entero
}

List<int> listIntLsbToMsb(List<int> data) {
  List<int> value = [];

  for (var i = data.length; i > 0; i--) {
    value.add(data[i - 1]);
  }

  return value;
}

List<int> hexaAsciiToListInt(String hexas) {
  List<int> value = [];

  hexas = hexas.toUpperCase();

  for (var i = 0; i <= hexas.length - 2; i += 2) {
    String hexa = hexas.substring(i, i + 2);
    value.add(int.parse(hexa, radix: 16));
  }

  return value;
}

String hexaToAscii(List<int> hexas) {
  return hex.encode(hexas).toString().toUpperCase();
}

String getMapValueByKey(Map<int, String> map, int key, String notFoundText) {
  if (map.containsKey(key))
    return map[key];
  else
    return notFoundText;
}

double gnssCoordProcess(List<int> hexas) {
  String coor = utf8.decode(hexas);
  int ptr = 0;

  int len = coor.length;
  int init = len == 10 ? 2 : 3;

  int sign = int.parse(((coor.substring(coor.length - 1) == 'N' ||
              coor.substring(coor.length - 1) == 'E')
          ? ''
          : '-') +
      '1');

  double degrees = double.parse(coor.substring(0, init));
  ptr += init;
  double decimal = double.parse(coor.substring(ptr, len - 1)) / 60.0;

  double result = (degrees + decimal) * sign;

  return double.parse(result.toStringAsFixed(8));
}

int getSignedNumber(List<int> bytes) {
  Int8List _number = new Int8List(4)
    ..[0] = bytes[0]
    ..[1] = bytes[1]
    ..[2] = bytes[2]
    ..[3] = bytes[3];

  return ByteData.sublistView(_number).getInt32(0);
}

int getSignedNumber16(List<int> bytes) {
  Int8List _number = new Int8List(2)
    ..[0] = bytes[0]
    ..[1] = bytes[1];

  return ByteData.sublistView(_number).getInt16(0);
}

bool isFirmwareVersionIsHigherOrEqualThat(
  String version,
  String versionToCompare,
) {
  // Remove 'v'
  String _version = version.substring(1);
  String _versionToCompare = (versionToCompare[0] == 'v')
      ? versionToCompare.substring(1)
      : versionToCompare;

  List<int> _versionArray = [];
  _version.split('.').forEach((e) => {_versionArray.add(int.parse(e))});
  List<int> _versionToCompareArray = [];
  _versionToCompare
      .split('.')
      .forEach((e) => {_versionToCompareArray.add(int.parse(e))});

  for (int i = 0; i < _versionArray.length; i++) {
    if (_versionArray[i] == _versionToCompareArray[i]) continue;
    return (_versionArray[i] > _versionToCompareArray[i]) ? true : false;
  }

  return true;
}
