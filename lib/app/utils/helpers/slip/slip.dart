import 'crc.dart';

const int slipEnd = 0xC0;
const int slipEsc = 0xDB;
const int slipEscEnd = 0xDC;
const int slipEscEsc = 0xDD;

class Slip {

  // Variables slip protocol
  int lastRxByte = 0;
  bool receivingFg = false;
  bool inputScapingFg = false;
  bool readyFg = false;
  int calCrc = 0;
  int rxCrcError = 0;
  List<int> bufferRx = [];
  List<int> bufferCrc = [];

  List<int> txFrame(List<int> frame) {
    // Variables to Calc CRC16
    int crc = 0;
    int crcHigh = 0;
    int crcLow = 0;
    List<int> _frameSlip = [];

    crc = crc16Calculate(frame);
    crcHigh = (crc >> 8) & 0xFF;
    crcLow = crc & 0xFF;
    frame.add(crcLow);
    frame.add(crcHigh);

    _frameSlip.add(slipEnd);
    for (int i in frame) {
      if (i == slipEnd) {
        _frameSlip.add(slipEsc);
        _frameSlip.add(slipEscEnd);
      } else if (i == slipEsc) {
        _frameSlip.add(slipEsc);
        _frameSlip.add(slipEscEsc);
      } else {
        _frameSlip.add(i);
      }
    }
    _frameSlip.add(slipEnd);

    return _frameSlip;
  }

  void cleanLists() {
    bufferRx.clear();
    bufferCrc.clear();
  }

  List<int> rxFrame(List<int> frame) {
    cleanLists();

    if (frame.length > 0) {
      for (int byte in frame) {
        if (!receivingFg && lastRxByte == slipEnd && byte != slipEnd) {
          receivingFg = true;
          rxFrameStart();
          rxFrameAddByte(byte);
        } else if (receivingFg && byte != slipEnd) {
          rxFrameAddByte(byte);
        } else if (receivingFg && byte == slipEnd) {
          rxFrameClose();
          if (readyFg) {
            receivingFg = false;
            return bufferRx;
          } else {
            rxCrcError++;
          }
          receivingFg = false;
        }
        lastRxByte = byte;
      }
    }
    return null; // Error in CRC or lenght list
  }

  void rxFrameStart() {
    calCrc = CRC16_INIT_VALUE;
  }

  void rxFrameAddByte(int byte) {
    if (byte == slipEsc) {
      inputScapingFg = true;
    } else {
      if (inputScapingFg) {
        byte = (byte == slipEscEnd) ? slipEnd : slipEsc;
        inputScapingFg = false;
      }

      bufferRx.add(byte);
      calCrc = crc16Append(byte, calCrc);
      bufferCrc.add(calCrc);
    }
  }

  void rxFrameClose() {
    if (calCrc == (~CRC16_GOOD_VALUE).toUnsigned(CRC16_GOOD_VALUE) & 0xFFFF) {
      readyFg = true;
      // Remove CRC Bytes

      bufferRx.removeLast();
      bufferRx.removeLast();
    } else {
      readyFg = false;
    }
    inputScapingFg = false;
  }
}
