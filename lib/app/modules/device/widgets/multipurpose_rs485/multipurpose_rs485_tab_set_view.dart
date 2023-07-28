import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'multipurpose_rs485_tab_controller.dart';
import '../../../../widgets/normal_button.dart';
import '../../../../widgets/features_set_card.dart';
import '../../../../theme/color_theme.dart';
import '../../../../theme/text_theme.dart';
import '../../../../utils/constants/ble_api/multipurpose_rs485/multipurpose_rs485_constants.dart';

class MultipurposeRS485TabSetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MultipurposeRS485TabController>(
        builder: (_) => Column(
              children: [
                FeaturesSetCard(
                    iconMain: Icons.settings,
                    title: 'Configuración de dispositivos',
                    leadingWidget:
                        NormalButton(text: 'Establecer', onPressed: _.bleApiSetRS485Devices),
                    widgetFeatures: Column(children: [
                      SizedBox(height: 10),
                      Text(
                          'Seleccione los dispositivos conectados al dispositivo IoT'),
                      Obx(() {
                        return (_.errorSetDevices.length > 0)
                            ? Text(_.errorSetDevices, style: textInfoError)
                            : Container();
                      }),
                      SizedBox(height: 10),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount:
                            MULTIPURPOSE_RS485_CONSTANTS.RS485_DEVICES.length,
                        itemBuilder: (__, idx) {
                          List<RS485Device> rs485Device =
                              MULTIPURPOSE_RS485_CONSTANTS.RS485_DEVICES.entries
                                  .map((entry) =>
                                      RS485Device(entry.key, entry.value))
                                  .toList();

                          return Obx(
                            () => SizedBox(
                              height: 25.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(rs485Device[idx].name,
                                      style: textInfoBold),
                                  Checkbox(
                                    activeColor: ColorsTheme.salmon,
                                    onChanged: (v) => _.onChangedSetDevices(
                                        v, rs485Device[idx].mask),
                                    value: _.getValueSetDevices(
                                        rs485Device[idx].mask),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ])),
              ],
            ));
  }
}
