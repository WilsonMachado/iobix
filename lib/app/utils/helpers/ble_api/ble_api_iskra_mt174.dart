import '../../../data/models/local/model_log_console.dart';
import '../../../data/models/local/model_iskra_mt174.dart';
import '../../../utils/constants/ble_api/ble_general_constants.dart';
import '../../../utils/helpers/helpers.dart';
import '../../../utils/constants/ble_api/iskra_mt174/iskra_mt174_commands.dart';
import '../../../utils/constants/ble_api/iskra_mt174/iskra_mt174_constants.dart';

ModelLogConsole bleApiIskraMt174(
    List<int> frame, ModelIskraMt174 modelIskraMt174) {
  final int cmd = frame[0], status = frame[1];

  int ptr = 2, cmdError = 0x00;
  String log = '';
  bool isResponseOk = true;

  if (status != BLE_GENERAL_CONSTANTS.STATUS_OK) {
    log += BLE_GENERAL_CONSTANTS.STATUS[status];
    isResponseOk = false;
    cmdError = status;
  } else {
    switch (cmd) {
      case ISKRA_MT174_CMDS.DATA_REPORT:
        int payloadStatus = frame[ptr];
        ptr++;

        if (payloadStatus == 0) {
          int payloadType = frame[ptr];
          ptr++;

          switch (payloadType) {
            case ISKRA_MT174_CONSTANTS.ACTIVE_ENERGY_PAYLOAD:
              int selByte = toIntAndLsbMsb(frame, ptr, 3);
              ptr += 3;

              if (edisSelector(selByte, 1)) {
                modelIskraMt174.totalPositiveActiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 2)) {
                modelIskraMt174.t1PositiveActiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 3)) {
                modelIskraMt174.t2PositiveActiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 4)) {
                modelIskraMt174.t3PositiveActiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 5)) {
                modelIskraMt174.t4PositiveActiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 6)) {
                modelIskraMt174.totalNegativeActiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 7)) {
                modelIskraMt174.t1NegativeActiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 8)) {
                modelIskraMt174.t2NegativeActiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 9)) {
                modelIskraMt174.t3NegativeActiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 10)) {
                modelIskraMt174.t4NegativeActiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 11)) {
                modelIskraMt174.totalAbsoluteActiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 12)) {
                modelIskraMt174.t1AbsoluteActiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 13)) {
                modelIskraMt174.t2AbsoluteActiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 14)) {
                modelIskraMt174.t3AbsoluteActiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 15)) {
                modelIskraMt174.t4AbsoluteActiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 16)) {
                modelIskraMt174.totalSumOfActiveEnergyWithoutReverseBlocking =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 17)) {
                modelIskraMt174.t1SumOfActiveEnergyWithoutReverseBlocking =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 18)) {
                modelIskraMt174.t2SumOfActiveEnergyWithoutReverseBlocking =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 19)) {
                modelIskraMt174.t3SumOfActiveEnergyWithoutReverseBlocking =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 20)) {
                modelIskraMt174.t4SumOfActiveEnergyWithoutReverseBlocking =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              break;

            case ISKRA_MT174_CONSTANTS.REACTIVE_ENERGY_PAYLOAD:
              int selByte = toIntAndLsbMsb(frame, ptr, 4);
              ptr += 4;

              if (edisSelector(selByte, 1)) {
                modelIskraMt174.totalPositiveReactiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 2)) {
                modelIskraMt174.t1PositiveReactiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 3)) {
                modelIskraMt174.t2PositiveReactiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 4)) {
                modelIskraMt174.t3PositiveReactiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 5)) {
                modelIskraMt174.t4PositiveReacctiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 6)) {
                modelIskraMt174.totalNegativeReactiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 7)) {
                modelIskraMt174.t1NegativeReactiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 8)) {
                modelIskraMt174.t2NegativeReactiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 9)) {
                modelIskraMt174.t3NegativeReactiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 10)) {
                modelIskraMt174.t4NegativeReactiveEnergy =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 11)) {
                modelIskraMt174.totalInductiveReactiveEnergyInQ1 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 12)) {
                modelIskraMt174.t1InductiveReactiveEnergyInQ1 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 13)) {
                modelIskraMt174.t2InductiveReactiveEnergyInQ1 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 14)) {
                modelIskraMt174.t3InductiveReactiveEnergyInQ1 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 15)) {
                modelIskraMt174.t4InductiveReactiveEnergyInQ1 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 16)) {
                modelIskraMt174.totalCapacitiveReactiveEnergyInQ2 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 17)) {
                modelIskraMt174.t1CapacitiveReactiveEnergyInQ2 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 18)) {
                modelIskraMt174.t2CapacitiveReactiveEnergyInQ2 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 19)) {
                modelIskraMt174.t3CapacitiveReactiveEnergyInQ2 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 20)) {
                modelIskraMt174.t4CapacitiveReactiveEnergyInQ2 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 21)) {
                modelIskraMt174.totalInductiveReactiveEnergyInQ3 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 22)) {
                modelIskraMt174.t1InductiveReactiveEnergyInQ3 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 23)) {
                modelIskraMt174.t2InductiveReactiveEnergyInQ3 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 24)) {
                modelIskraMt174.t3InductiveReactiveEnergyInQ3 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 25)) {
                modelIskraMt174.t4InductiveReactiveEnergyInQ3 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 26)) {
                modelIskraMt174.totalCapacitiveReactiveEnergyInQ4 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 27)) {
                modelIskraMt174.t1CapacitiveReactiveEnergyInQ4 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 28)) {
                modelIskraMt174.t2CapacitiveReactiveEnergyInQ4 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 29)) {
                modelIskraMt174.t3CapacitiveReactiveEnergyInQ4 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              if (edisSelector(selByte, 30)) {
                modelIskraMt174.t4CapacitiveReactiveEnergyInQ4 =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }
              break;

            case ISKRA_MT174_CONSTANTS.ELECTRICITY_NETWORK_QUALITY_PAYLOAD:
              int selByte = toIntAndLsbMsb(frame, ptr, 3);
              ptr += 3;

              if (edisSelector(selByte, 1)) {
                modelIskraMt174.instantaneousCurrent =
                    (toIntAndLsbMsb(frame, ptr, 2) / 100).toStringAsFixed(2);
                ptr += 2;
              }

              if (edisSelector(selByte, 2)) {
                modelIskraMt174.instantaneousCurrentInPhase1 =
                    (toIntAndLsbMsb(frame, ptr, 2) / 100).toStringAsFixed(2);
                ptr += 2;
              }

              if (edisSelector(selByte, 3)) {
                modelIskraMt174.instantaneousCurrentInPhase2 =
                    (toIntAndLsbMsb(frame, ptr, 2) / 100).toStringAsFixed(2);
                ptr += 2;
              }

              if (edisSelector(selByte, 2)) {
                modelIskraMt174.instantaneousCurrentInPhase3 =
                    (toIntAndLsbMsb(frame, ptr, 2) / 100).toStringAsFixed(2);
                ptr += 2;
              }

              if (edisSelector(selByte, 5)) {
                modelIskraMt174.instantaneousCurrentInNeutro =
                    (toIntAndLsbMsb(frame, ptr, 2) / 100).toStringAsFixed(2);
                ptr += 2;
              }

              if (edisSelector(selByte, 6)) {
                modelIskraMt174.maxCurrent =
                    (toIntAndLsbMsb(frame, ptr, 2) / 100).toStringAsFixed(2);
                ptr += 2;
              }

              if (edisSelector(selByte, 7)) {
                modelIskraMt174.maxCurrentInPhase1 =
                    (toIntAndLsbMsb(frame, ptr, 2) / 100).toStringAsFixed(2);
                ptr += 2;
              }

              if (edisSelector(selByte, 8)) {
                modelIskraMt174.maxCurrentInPhase2 =
                    (toIntAndLsbMsb(frame, ptr, 2) / 100).toStringAsFixed(2);
                ptr += 2;
              }

              if (edisSelector(selByte, 9)) {
                modelIskraMt174.maxCurrentInPhase3 =
                    (toIntAndLsbMsb(frame, ptr, 2) / 100).toStringAsFixed(2);
                ptr += 2;
              }

              if (edisSelector(selByte, 10)) {
                modelIskraMt174.maxCurrentInNeutro =
                    (toIntAndLsbMsb(frame, ptr, 2) / 100).toStringAsFixed(2);
                ptr += 2;
              }

              if (edisSelector(selByte, 11)) {
                modelIskraMt174.instantaneousVoltage =
                    (toIntAndLsbMsb(frame, ptr, 2) / 10).toStringAsFixed(1);
                ptr += 2;
              }

              if (edisSelector(selByte, 12)) {
                modelIskraMt174.instantaneousVoltageInPhase1 =
                    (toIntAndLsbMsb(frame, ptr, 2) / 10).toStringAsFixed(1);
                ptr += 2;
              }

              if (edisSelector(selByte, 13)) {
                modelIskraMt174.instantaneousVoltageInPhase2 =
                    (toIntAndLsbMsb(frame, ptr, 2) / 10).toStringAsFixed(1);
                ptr += 2;
              }

              if (edisSelector(selByte, 14)) {
                modelIskraMt174.instantaneousVoltageInPhase3 =
                    (toIntAndLsbMsb(frame, ptr, 2) / 10).toStringAsFixed(1);
                ptr += 2;
              }

              if (edisSelector(selByte, 15)) {
                modelIskraMt174.instantaneousPowerFactor =
                    (toIntAndLsbMsb(frame, ptr, 2) / 1000).toStringAsFixed(3);
                ptr += 2;
              }

              if (edisSelector(selByte, 16)) {
                modelIskraMt174.instantaneousPowerFactorInPhase1 =
                    (toIntAndLsbMsb(frame, ptr, 2) / 1000).toStringAsFixed(3);
                ptr += 2;
              }

              if (edisSelector(selByte, 17)) {
                modelIskraMt174.instantaneousPowerFactorInPhase2 =
                    (toIntAndLsbMsb(frame, ptr, 2) / 1000).toStringAsFixed(3);
                ptr += 2;
              }

              if (edisSelector(selByte, 18)) {
                modelIskraMt174.instantaneousPowerFactorInPhase3 =
                    (toIntAndLsbMsb(frame, ptr, 2) / 1000).toStringAsFixed(3);
                ptr += 2;
              }

              if (edisSelector(selByte, 19)) {
                modelIskraMt174.frequency =
                    (toIntAndLsbMsb(frame, ptr, 2) / 100).toStringAsFixed(2);
                ptr += 2;
              }

              break;

            case ISKRA_MT174_CONSTANTS.MISCELLANEOUS_PAYLOAD:
              int selByte = toIntAndLsbMsb(frame, ptr, 3);
              ptr += 3;

              if (edisSelector(selByte, 1)) {
                modelIskraMt174.currentTime =
                    '${frame[ptr]}:${frame[ptr + 1]}:${frame[ptr + 2]}';
                ptr += 3;
              }

              if (edisSelector(selByte, 2)) {
                modelIskraMt174.currentDate =
                    '20${frame[ptr]}-${frame[ptr + 1]}-${frame[ptr + 2]}';
                ptr += 3;
              }

              if (edisSelector(selByte, 3)) {
                modelIskraMt174.serie =
                    toIntAndLsbMsb(frame, ptr, 4).toString();
                ptr += 4;
              }

              break;
            default:
            // Anunciar si no hay ese tipo de payloads?
          }
        }

        break;

      default:
        log += BLE_GENERAL_CONSTANTS.CMD_UNSUPPORTED;
        cmdError = BLE_GENERAL_CONSTANTS.SNACKBAR_ERROR_APP;
    }
  }

  return ModelLogConsole(
      cmd: cmd, log: log, isResponseOk: isResponseOk, cmdError: cmdError);
}

bool edisSelector(byte, bit) {
  return ((byte >> (bit - 1)) & 0x01 == 1);
}

int toIntAndLsbMsb(frame, ptr, n) {
  return listBytesToInt(listIntLsbToMsb(frame.sublist(ptr, ptr + n)));
}
