import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iobix/app/modules/device/widgets/iris_logger/iris_logger_tab_controller.dart';
import 'package:iobix/app/theme/text_theme.dart';
import 'package:iobix/app/widgets/features_set_card.dart';

class IrisLoggerTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IrisLoggerTabController>(
        builder: (_) => RefreshIndicator(
              onRefresh: _.bleApiDataReport,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Obx(
                  () => Column(
                    children: [
                      //! Status de la comunicación

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Comunicación con la estación: ',
                              style: textInfo),
                          Text(_.modelIrisLogger.communicationStatus,
                              style: textInfoBold),
                        ],
                      ),

                      if (_.modelIrisLogger.communicationStatus == 'Ok')
                        SizedBox(height: 8.0),

                      //! Variables Current
                      if (_.modelIrisLogger.communicationStatus == 'Ok')
                        FeaturesSetCard(
                          title: 'Medición de variables actuales',
                          iconMain: FontAwesomeIcons.cloudMeatball,
                          widgetFeatures: Column(
                            children: [
                              SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Temperatura'),
                                  Spacer(),
                                  Text(_.modelIrisLogger.tempCurrent.toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('°C', style: variableIndicatorUnit)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Velocidad de viento'),
                                  Spacer(),
                                  Text(_.modelIrisLogger.wsCurrent.toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('m/s', style: variableIndicatorUnit)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Dirección de viento'),
                                  Spacer(),
                                  Text(_.modelIrisLogger.wdCurrent.toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('°', style: variableIndicatorUnit)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Humedad'),
                                  Spacer(),
                                  Text(_.modelIrisLogger.humCurrent.toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('%', style: variableIndicatorUnit)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Presión'),
                                  Spacer(),
                                  Text(
                                      _.modelIrisLogger.pressCurrent.toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('kPa', style: variableIndicatorUnit)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Lluvia (MP600)'),
                                  Spacer(),
                                  Text(
                                      _.modelIrisLogger.rainMP600Current
                                          .toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('mm', style: variableIndicatorUnit)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Evaporación'),
                                  Spacer(),
                                  Text(
                                      _.modelIrisLogger.evaporationCurrent
                                          .toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('mm', style: variableIndicatorUnit)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Lluvia'),
                                  Spacer(),
                                  Text(_.modelIrisLogger.rainCurrent.toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('mm', style: variableIndicatorUnit)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Batería de la estación'),
                                  Spacer(),
                                  Text(
                                      _.modelIrisLogger.batteryCurrent
                                          .toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('V', style: variableIndicatorUnit)
                                ],
                              ),
                            ],
                          ),
                        ),

                      if (_.modelIrisLogger.communicationStatus == 'Ok')
                        //! Variables logged

                        FeaturesSetCard(
                          title: 'Último dato almacenado para las variables',
                          iconMain: FontAwesomeIcons.cloudMeatball,
                          widgetFeatures: Column(
                            children: [
                              SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Temperatura'),
                                  Spacer(),
                                  Text(_.modelIrisLogger.tempLogged.toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('°C', style: variableIndicatorUnit)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Velocidad de viento'),
                                  Spacer(),
                                  Text(_.modelIrisLogger.wsLogged.toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('m/s', style: variableIndicatorUnit)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Dirección de viento'),
                                  Spacer(),
                                  Text(_.modelIrisLogger.wdLogged.toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('°', style: variableIndicatorUnit)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Humedad'),
                                  Spacer(),
                                  Text(_.modelIrisLogger.humCurrent.toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('%', style: variableIndicatorUnit)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Presión'),
                                  Spacer(),
                                  Text(_.modelIrisLogger.pressLogged.toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('kPa', style: variableIndicatorUnit)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Lluvia (MP600)'),
                                  Spacer(),
                                  Text(
                                      _.modelIrisLogger.rainMP600Logged
                                          .toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('mm', style: variableIndicatorUnit)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Evaporación'),
                                  Spacer(),
                                  Text(
                                      _.modelIrisLogger.evaporationLogged
                                          .toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('mm', style: variableIndicatorUnit)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Lluvia'),
                                  Spacer(),
                                  Text(_.modelIrisLogger.rainLogged.toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('mm', style: variableIndicatorUnit)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Batería de la estación'),
                                  Spacer(),
                                  Text(
                                      _.modelIrisLogger.batteryLogged
                                          .toString(),
                                      style: variableIndicatorMini),
                                  SizedBox(width: 5.0),
                                  Text('V', style: variableIndicatorUnit)
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
