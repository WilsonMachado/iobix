import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iobix/app/widgets/features_set_card.dart';
import 'package:iobix/app/widgets/normal_button.dart';
import 'smart_fault_detector_tab_controller.dart';
import 'package:led_bulb_indicator/led_bulb_indicator.dart';

class SmartFaultDetectorTabView extends StatelessWidget {
  const SmartFaultDetectorTabView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartFaultDetectorTabController>(
        builder: (_) => Obx(() => RefreshIndicator(
              onRefresh: () => _.dataReport(),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: FeaturesSetCard(
                  title: 'Estado del sistema',
                  iconMain: FontAwesomeIcons.sellsy,
                  leadingWidget: NormalButton(
                      text: 'Reset de alarmas',
                      onPressed: (_.modelSmartFaultDetector.permanentFault ==
                                  0x01 ||
                              _.modelSmartFaultDetector.transitoryFault == 0x01)
                          ? _.clearAlarms
                          : null),
                  widgetFeatures: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      _.modelSmartFaultDetector.permanentFault == 0x00 &&
                              _.modelSmartFaultDetector.transitoryFault == 0x00
                          ? Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      LedBulbIndicator(
                                        initialState: LedBulbColors.green,
                                        glow: true,
                                        size: 35,
                                      ),
                                      Text('Sistema sin fallas'),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            )
                          : _.modelSmartFaultDetector.permanentFault == 0x01 &&
                                  _.modelSmartFaultDetector.transitoryFault ==
                                      0x00
                              ? Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          LedBulbIndicator(
                                            initialState: LedBulbColors.red,
                                            glow: true,
                                            size: 35,
                                          ),
                                          Text('Falla permanente'),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                    ],
                                  ),
                                )
                              : _.modelSmartFaultDetector.permanentFault ==
                                          0x00 &&
                                      _.modelSmartFaultDetector
                                              .transitoryFault ==
                                          0x01
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LedBulbIndicator(
                                          initialState: LedBulbColors.yellow,
                                          glow: false,
                                          size: 35,
                                        ),
                                        Text('Falla transitoria'),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LedBulbIndicator(
                                          initialState: LedBulbColors.off,
                                          glow: false,
                                          size: 35,
                                        ),
                                        Text('Error inesperado'),
                                      ],
                                    ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
