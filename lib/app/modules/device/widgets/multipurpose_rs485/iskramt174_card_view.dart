// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';

// import 'multipurpose_rs485_tab_controller.dart';
// import 'iskramt174_phase_card.dart';
// import '../../../../widgets/default_card.dart';
// import '../../../../theme/color_theme.dart';
// import '../../../../theme/text_theme.dart';
// import '../../../../widgets/information_card.dart';
// import '../../../../widgets/custom_linear_indicator.dart';
// import '../../../../widgets/vertical_indicator_card.dart';
// import '../../../../utils/constants/ble_api/ble_general_constants.dart';

// class IskraMT174CardView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<MultipurposeRS485TabController>(
//       builder: (_) => Column(
//         children: [
//           Obx(
//             () => DefaultCard(
//               color: Colors.lightBlue[50],
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text('ISKRA MT174', style: miniTitle),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text('Estado del sensor: '),
//                       Text(
//                           BLE_GENERAL_CONSTANTS.STATUS[
//                               _.modelMultipurposeRS485.iskramt174Status],
//                           style: textInfoBold)
//                     ],
//                   ),
//                   if (_.modelMultipurposeRS485.iskramt174Serie.length > 0)
//                     Row(
//                       children: [
//                         Text('Serie: '),
//                         Text(
//                           _.modelMultipurposeRS485.iskramt174Serie,
//                           style: textInfoBold,
//                         ),
//                       ],
//                     ),
//                   if (_.modelMultipurposeRS485.iskramt174Firmware.length > 0)
//                     Row(
//                       children: [
//                         Text('Firmware: '),
//                         Text(
//                           _.modelMultipurposeRS485.iskramt174Firmware,
//                           style: textInfoBold,
//                         ),
//                       ],
//                     ),
//                   if (_.modelMultipurposeRS485.iskramt174Status ==
//                       BLE_GENERAL_CONSTANTS.STATUS_OK)
//                     Row(
//                       children: [
//                         Text('Batería: '),
//                         Text(
//                             _.modelMultipurposeRS485.iskramt174InternalBattery
//                                     .toStringAsFixed(2) +
//                                 ' %',
//                             style: textInfoBold)
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//           ),
//           Obx(() {
//             return _.modelMultipurposeRS485.iskramt174Status ==
//                     BLE_GENERAL_CONSTANTS.STATUS_OK
//                 ? Column(
//                     children: [
//                       Row(children: [
//                         Expanded(
//                           child: VerticalIndicatorCard(
//                             title: 'C. Instantánea',
//                             digits: 2,
//                             value: _
//                                 .modelMultipurposeRS485.iskramt174TotalICurrent,
//                             unit: 'A',
//                             icon: FontAwesomeIcons.plug,
//                             iconSize: 20,
//                           ),
//                         ),
//                         IskraMT174PhaseCard(
//                             title: 'Fase 1',
//                             voltage: _.modelMultipurposeRS485
//                                 .iskramt174Phase1IVoltage,
//                             current: _.modelMultipurposeRS485
//                                 .iskramt174Phase1ICurrent),
//                       ]),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: VerticalIndicatorCard(
//                               title: 'Frecuencia',
//                               digits: 1,
//                               value:
//                                   _.modelMultipurposeRS485.iskramt174Frequency,
//                               unit: 'Hz',
//                               icon: FontAwesomeIcons.waveSquare,
//                               iconSize: 20,
//                             ),
//                           ),
//                           IskraMT174PhaseCard(
//                               title: 'Fase 2',
//                               voltage: _.modelMultipurposeRS485
//                                   .iskramt174Phase2IVoltage,
//                               current: _.modelMultipurposeRS485
//                                   .iskramt174Phase2ICurrent),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: VerticalIndicatorCard(
//                               title: 'Factor',
//                               value: _.modelMultipurposeRS485
//                                   .iskramt174IPowerFactor,
//                               unit: '',
//                               icon: FontAwesomeIcons.arrowDown19,
//                               iconSize: 20,
//                             ),
//                           ),
//                           IskraMT174PhaseCard(
//                               title: 'Fase 3',
//                               voltage: _.modelMultipurposeRS485
//                                   .iskramt174Phase3IVoltage,
//                               current: _.modelMultipurposeRS485
//                                   .iskramt174Phase3ICurrent),
//                         ],
//                       ),
//                       InformationCard(
//                           iconMain: FontAwesomeIcons.bolt,
//                           title: 'Energía',
//                           content: [
//                             CustomLinearPercentIndicator(
//                               title: 'Activa',
//                               unit: 'Wh',
//                               maxValue: 1000000,
//                               value: _.modelMultipurposeRS485
//                                       .iskramt174TotalActiveEnergy *
//                                   1.0,
//                               progressColor: Colors.grey,
//                             ),
//                             CustomLinearPercentIndicator(
//                               title: 'Reactiva',
//                               unit: 'VArh',
//                               maxValue: 1000000,
//                               value: _.modelMultipurposeRS485
//                                       .iskramt174TotalPositiveReactiveEnergy *
//                                   1.0,
//                               progressColor: ColorsTheme.lightBlue,
//                             ),
//                             CustomLinearPercentIndicator(
//                               title: 'Aparente',
//                               unit: 'VAh',
//                               maxValue: 1000000,
//                               value: _.modelMultipurposeRS485
//                                       .iskramt174TotalApparentEnergy *
//                                   1.0,
//                               progressColor: ColorsTheme.opaqueBlue,
//                             ),
//                             SizedBox(height: 10)
//                           ]),
//                       SizedBox(height: 10)
//                     ],
//                   )
//                 : Container();
//           }),
//         ],
//       ),
//     );
//   }
// }
