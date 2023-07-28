import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/ble_api/smart_meter_ac/smart_meter_ac_constants.dart';
import './smart_meter_ac_tab_controller.dart';
import '../../../../widgets/information_card.dart';
import '../../../../theme/text_theme.dart';

class SmartMeterAcDebugCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartMeterAcTabController>(
      id: 'smartMeterAcDebugCard',
      builder: (_) {
        List<int> processes = [
          _.modelSmartMeterAc.analogMeasureProcess,
          _.modelSmartMeterAc.loraMeasureProcess,
          _.modelSmartMeterAc.bleMeasureProcess,
          _.modelSmartMeterAc.loraApiProcess,
          _.modelSmartMeterAc.rak4600Process,
          _.modelSmartMeterAc.adeProcess,
          _.modelSmartMeterAc.adeIrq0Process,
          _.modelSmartMeterAc.adeIrq1Process,
          _.modelSmartMeterAc.adeBurstReadProcess,
          _.modelSmartMeterAc.rakSendDataStatus,
          _.modelSmartMeterAc.rakSendingProcess,
        ];

        List<String> processesInfo = [
          'Medición Análoga',
          'Medición LoRa',
          'Medición BLE',
          'API LoRa',
          'RAK4600',
          'ADE',
          'ADE IRQ0',
          'ADE IRQ1',
          'Lectura ADE Burst',
          'Estado de envio RAK',
          'Transmitiendo RAK',
        ];

        return InformationCard(
          iconMain: Icons.info_outline_rounded,
          title: 'Lectura de procesos',
          reloadFnc: _.bleApiDebugRead,
          content: [
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tipo de ADE instalado',
                  style: textInfo,
                ),
                SizedBox(width: 10.0),
                Obx(
                  () => Text(
                    SMART_METER_AC_CONSTANTS
                        .ADE_TYPE_MAP[_.modelSmartMeterAc.adeType].tr,
                    style: textInfoBold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: processes.length,
              itemBuilder: (__, idx) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    processesInfo[idx],
                    style: textInfo,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    processes[idx].toString(),
                    style: textInfoBold,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
