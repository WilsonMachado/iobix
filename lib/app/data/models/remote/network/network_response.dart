import 'package:meta/meta.dart';
import 'dart:convert';

class NetworkResponse {
    NetworkResponse({
        @required this.ok,
        @required this.msg,
        @required this.data,
    });

    final bool ok;
    final String msg;
    final Data data;

    factory NetworkResponse.fromRawJson(String str) => NetworkResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NetworkResponse.fromJson(Map<String, dynamic> json) => NetworkResponse(
        ok: json["ok"] == null ? null : json["ok"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok == null ? null : ok,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        @required this.msgId,
        @required this.rxData,
        @required this.gwData,
    });

    final String msgId;
    final RxData rxData;
    final GwData gwData;

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        msgId: json["msgId"] == null ? null : json["msgId"],
        rxData: json["rxData"] == null ? null : RxData.fromJson(json["rxData"]),
        gwData: json["gwData"] == null ? null : GwData.fromJson(json["gwData"]),
    );

    Map<String, dynamic> toJson() => {
        "msgId": msgId == null ? null : msgId,
        "rxData": rxData == null ? null : rxData.toJson(),
        "gwData": gwData == null ? null : gwData.toJson(),
    };
}

class GwData {
    GwData({
        @required this.gws,
    });

    final List<Gw> gws;

    factory GwData.fromRawJson(String str) => GwData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GwData.fromJson(Map<String, dynamic> json) => GwData(
        gws: json["gws"] == null ? null : List<Gw>.from(json["gws"].map((x) => Gw.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "gws": gws == null ? null : List<dynamic>.from(gws.map((x) => x.toJson())),
    };
}

class Gw {
    Gw({
        @required this.rssi,
        @required this.snr,
        @required this.ts,
        @required this.time,
        @required this.gweui,
        @required this.ant,
        @required this.lat,
        @required this.lon,
        @required this.name,
    });

    final int rssi;
    final double snr;
    final int ts;
    final DateTime time;
    final String gweui;
    final int ant;
    final double lat;
    final double lon;
    final String name;

    factory Gw.fromRawJson(String str) => Gw.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Gw.fromJson(Map<String, dynamic> json) => Gw(
        rssi: json["rssi"] == null ? null : json["rssi"],
        snr: json["snr"] == null ? null : json["snr"].toDouble(),
        ts: json["ts"] == null ? null : json["ts"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        gweui: json["gweui"] == null ? null : json["gweui"],
        ant: json["ant"] == null ? null : json["ant"],
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lon: json["lon"] == null ? null : json["lon"].toDouble(),
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "rssi": rssi == null ? null : rssi,
        "snr": snr == null ? null : snr,
        "ts": ts == null ? null : ts,
        "time": time == null ? null : time.toIso8601String(),
        "gweui": gweui == null ? null : gweui,
        "ant": ant == null ? null : ant,
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
        "name": name == null ? null : name,
    };
}

class RxData {
    RxData({
        @required this.freq,
        @required this.rssi,
        @required this.snr,
        @required this.dr,
    });

    final int freq;
    final int rssi;
    final double snr;
    final String dr;

    factory RxData.fromRawJson(String str) => RxData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RxData.fromJson(Map<String, dynamic> json) => RxData(
        freq: json["freq"] == null ? null : json["freq"],
        rssi: json["rssi"] == null ? null : json["rssi"],
        snr: json["snr"] == null ? null : json["snr"].toDouble(),
        dr: json["dr"] == null ? null : json["dr"],
    );

    Map<String, dynamic> toJson() => {
        "freq": freq == null ? null : freq,
        "rssi": rssi == null ? null : rssi,
        "snr": snr == null ? null : snr,
        "dr": dr == null ? null : dr,
    };
}
