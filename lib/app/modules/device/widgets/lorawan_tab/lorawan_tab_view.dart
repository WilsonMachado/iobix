import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/ble_api/lorawan_constants.dart';
import './lorawan_tab_controller.dart';
import '../../../../widgets/features_set_card.dart';
import '../../../../widgets/divider_or.dart';
import '../../../../widgets/normal_button.dart';
import '../../../../widgets/vertical_step_progress.dart';
import '../../../../widgets/loading/loading.dart';
import '../../../../widgets/information_card.dart';
import '../../../../theme/text_theme.dart';
import '../../../../theme/color_theme.dart';
import '../../../../data/models/local/model_login.dart';
import '../../../../utils/constants/enums.dart';

class LorawanTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LorawanTabController>(
      builder: (_) => Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => InformationCard(
                      iconMain: Icons.info_outline_rounded,
                      title: 'radio_info'.tr,
                      reloadFnc: _.isImstModule()
                          ? _.bleApiGetRadioStack
                          : _.bleApiGetRakInformation,
                      content: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('oper_band'.tr, style: textInfo),
                            SizedBox(width: 10.0),
                            Text(_.modelDeviceLorawan.getBand.tr,
                                style: textInfoBold),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('sub_band'.trArgs(['1']), style: textInfo),
                            SizedBox(width: 10.0),
                            Text(_.modelDeviceLorawan.getSubBand1.tr,
                                style: textInfoBold),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('sub_band'.trArgs(['2']), style: textInfo),
                            SizedBox(width: 10.0),
                            Text(_.modelDeviceLorawan.getSubBand2.tr,
                                style: textInfoBold),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('spread_factor'.tr, style: textInfo),
                            SizedBox(width: 10.0),
                            Text(_.modelDeviceLorawan.getSpreadingFactor.tr,
                                style: textInfoMiniBold),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${'tx_power'.tr} (dbm)', style: textInfo),
                            SizedBox(width: 10.0),
                            Text(_.modelDeviceLorawan.getPotency.tr,
                                style: textInfoBold),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('class'.tr, style: textInfo),
                            SizedBox(width: 10.0),
                            Text(_.modelDeviceLorawan.getClass.tr,
                                style: textInfoBold),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('lora_adr'.tr, style: textInfo),
                            SizedBox(width: 10.0),
                            Text(_.modelDeviceLorawan.getAdr.tr,
                                style: textInfoBold),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('duty_cycle'.tr, style: textInfo),
                            SizedBox(width: 10.0),
                            Text(_.modelDeviceLorawan.getDutyCycle.tr,
                                style: textInfoBold),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('forwardings'.tr, style: textInfo),
                            SizedBox(width: 10.0),
                            Text(_.modelDeviceLorawan.getRetransmissions.tr,
                                style: textInfoBold),
                          ],
                        ),
                        if (!_.isImstModule())
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('connect_net?'.tr, style: textInfo),
                              SizedBox(width: 10.0),
                              Text(_.modelDeviceLorawan.joinedNetwork.tr,
                                  style: textInfoBold),
                            ],
                          ),
                      ]),
                ),
              )
            ],
          ),
          if (ModelLogin.isAdmin())
            Obx(
              () => InformationCard(
                  iconMain: Icons.info_outline_rounded,
                  title: 'module_info'.tr,
                  reloadFnc:
                      _.isImstModule() ? _.bleApiGetLoraInformation : null,
                  content: [
                    if (ModelLogin.isRole(Roles.superAdmin))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Hardware', style: textInfo),
                          SizedBox(width: 10.0),
                          Text(
                              LORAWAN_CONSTANTS.MODULE_MAP
                                      .containsKey(_.modelDeviceLorawan.module)
                                  ? LORAWAN_CONSTANTS
                                      .MODULE_MAP[_.modelDeviceLorawan.module]
                                  : 'Error',
                              style: textInfoBold),
                        ],
                      ),
                    if (_.isImstModule())
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('oper_mode'.tr, style: textInfo),
                          SizedBox(width: 10.0),
                          Text(_.modelDeviceLorawan.getOperationMode.tr,
                              style: textInfoMiniBold),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('connect_mode'.tr, style: textInfo),
                        SizedBox(width: 10.0),
                        Text(_.modelDeviceLorawan.connectionMode.tr,
                            style: textInfoBold),
                      ],
                    )
                  ]),
            ),
          if (ModelLogin.isAdmin())
            Obx(
              () => InformationCard(
                  iconMain: FontAwesomeIcons.paperPlane,
                  title: 'x_param'.trArgs(['OTAA']),
                  reloadFnc: _.isImstModule() ? _.bleApiGetOtaaParams : null,
                  content: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Dev EUI', style: textInfo),
                        SizedBox(width: 10.0),
                        SelectableText(_.modelDeviceLorawan.getDevEui,
                            style: textInfoMiniBold,
                            textAlign: TextAlign.right),
                      ],
                    ),
                    Text('(Big endian)', style: textInfoMini),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('App EUI', style: textInfo),
                        SizedBox(width: 10.0),
                        SelectableText(_.modelDeviceLorawan.getAppEui,
                            style: textInfoMiniBold),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('App Key', style: textInfo),
                        SizedBox(width: 10.0),
                        SelectableText(_.modelDeviceLorawan.getAppKey,
                            style: textInfoMiniBold),
                      ],
                    ),
                  ]),
            ),
          if (ModelLogin.isAdmin())
            Obx(
              () => InformationCard(
                  iconMain: FontAwesomeIcons.solidPaperPlane,
                  title: 'x_param'.trArgs(['ABP']),
                  reloadFnc: _.isImstModule() ? _.bleApiGetAbpParams : null,
                  content: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Device Addres', style: textInfo),
                        SizedBox(width: 10.0),
                        SelectableText(_.modelDeviceLorawan.getDeviceAddress,
                            style: textInfoMiniBold),
                      ],
                    ),
                    Text('(Big endian)', style: textInfoMini),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Network Session Key', style: textInfoMini),
                        SizedBox(width: 10.0),
                        SelectableText(_.modelDeviceLorawan.getNwsKey,
                            style: textInfoSuperMiniBold),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('App Session Key', style: textInfoMini),
                        SizedBox(width: 10.0),
                        SelectableText(_.modelDeviceLorawan.getAppsKey,
                            style: textInfoSuperMiniBold),
                      ],
                    ),
                  ]),
            ),
          if (ModelLogin.isRole(Roles.device) ||
              ModelLogin.isRole(Roles.superAdmin))
            Obx(() => FeaturesSetCard(
                  iconMain: Icons.network_check_rounded,
                  title: 'coverage'.tr,
                  leadingWidget: NormalButton(
                      text: 'Iniciar',
                      onPressed: _.modelDeviceLorawan.tryGetNetworkCoverage
                          ? null
                          : _.bleApiTestTxLora),
                  widgetFeatures: Obx(() {
                    if (_.modelDeviceLorawan.tryGetNetworkCoverage) {
                      return Column(
                        children: [
                          SizedBox(height: 8.0),
                          Text(
                              '¡A trabajar!, estamos obteniendo la información de cobertura de este dispositivo. Este proceso puede tardar más de 1 minuto, por favor espere',
                              style: textInfoMiniItalic,
                              textAlign: TextAlign.center),
                          SizedBox(height: 5.0),
                          Loading(),
                          VerticalStepProgress(
                              lenSteps: _.modelDeviceLorawan
                                  .msgsGetNetworkCoverage.length,
                              currentStep: _.modelDeviceLorawan
                                  .currentStepGetNetworkCoverage,
                              msgStep: _.modelDeviceLorawan
                                  .currentMsgGetNetworkCoverage,
                              successIcon: FontAwesomeIcons.check),
                          NormalButton(
                              text: 'Cancelar', onPressed: _.cancelTestTxLora),
                        ],
                      );
                    } else
                      return Column(
                        children: [
                          if (ModelLogin.isRole(Roles.superAdmin))
                            SizedBox(
                              height: 30,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Guardar dato para mapa de cobertura'),
                                  Checkbox(
                                    value: _.setSaveCoverageMap,
                                    onChanged: (v) =>
                                        _.onChangeSetSaveCoverageMap(v),
                                  ),
                                ],
                              ),
                            ),
                          if (ModelLogin.isRole(Roles.superAdmin))
                            SizedBox(
                              height: 30,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Pruebas automaticas'),
                                  Checkbox(
                                    value: _.setAutoCoverage,
                                    onChanged: (v) =>
                                        _.onChangeSetAutoCoverage(v),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(height: 8.0),
                          Text(_.modelDeviceLorawan.finishMsgGetNetworkCoverage,
                              style: textInfoMiniItalic,
                              textAlign: TextAlign.center),
                          if (_.modelDeviceLorawan.successGetNetworkCoverage)
                            Column(
                              children: [
                                SizedBox(height: 8.0),
                                DividerOr(
                                  title: 'Información de transmisión',
                                  titleStyle: textInfoBold,
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Frecuencia', style: textInfo),
                                    SizedBox(width: 10.0),
                                    Text(
                                        _.networkResponse.data.rxData.freq
                                            .toString(),
                                        style: textInfoBold),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('RSSI', style: textInfo),
                                    SizedBox(width: 10.0),
                                    Text(
                                        _.networkResponse.data.rxData.rssi
                                            .toString(),
                                        style: textInfoBold),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Relación señal a ruido',
                                        style: textInfo),
                                    SizedBox(width: 10.0),
                                    Text(
                                        _.networkResponse.data.rxData.snr
                                            .toString(),
                                        style: textInfoBold),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Factor de difusión', style: textInfo),
                                    SizedBox(width: 10.0),
                                    Text(_.networkResponse.data.rxData.dr,
                                        style: textInfoBold),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Gateway uplink', style: textInfo),
                                    SizedBox(width: 10.0),
                                    Text(_.getGatewayNetworkCoverage(),
                                        style: textInfoBold),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                DividerOr(
                                  title: 'Gateways en zona',
                                  titleStyle: miniTitle,
                                ),
                                SizedBox(height: 5.0),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      _.networkResponse.data.gwData.gws.length,
                                  itemBuilder: (__, idx) {
                                    var gw =
                                        _.networkResponse.data.gwData.gws[idx];
                                    return Column(
                                      children: [
                                        Text(gw.name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: ColorsTheme.opaqueBlue),
                                            textAlign: TextAlign.left),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('RSSI', style: textInfo),
                                            SizedBox(width: 10.0),
                                            Text(gw.rssi.toString(),
                                                style: textInfoBold),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Relación señal a ruido',
                                                style: textInfo),
                                            SizedBox(width: 10.0),
                                            Text(gw.snr.toString(),
                                                style: textInfoBold),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Fecha', style: textInfo),
                                            SizedBox(width: 10.0),
                                            Text(gw.time.toLocal().toString(),
                                                style: textInfoBold),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('EUI', style: textInfo),
                                            SizedBox(width: 10.0),
                                            Text(gw.gweui, style: textInfoBold),
                                          ],
                                        ),
                                        if (_.networkResponse.data.gwData.gws
                                                .length !=
                                            (idx + 1))
                                          SizedBox(height: 30.0),
                                      ],
                                    );
                                  },
                                )
                              ],
                            )
                        ],
                      );
                  }),
                )),
          SizedBox(height: 8.0)
        ],
      ),
    );
  }
}
