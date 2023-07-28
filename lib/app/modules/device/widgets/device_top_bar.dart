import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../utils/helpers/size_config.dart';
import '../../../theme/text_theme.dart';

import '../../../theme/color_theme.dart';
import '../../../widgets/custom_alert_modal_bottom_sheet.dart';

class DeviceTopBar extends StatelessWidget {
  const DeviceTopBar(
      {Key key,
      @required this.title,
      @required this.subtitle,
      @required this.disconnectFnc,
      @required this.disconnectTitle,
      @required this.disconnectMsg})
      : super(key: key);

  final String title, subtitle, disconnectTitle, disconnectMsg;
  final Function disconnectFnc;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: getProportionateScreenHeight(0.1),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Stack(children: [
          Center(
            child: Column(
              children: [
                Text(title, style: miniTitle),
                Text(subtitle, style: textInfo)
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: ColorsTheme.salmon),
              child: IconButton(
                icon:
                    Icon(Icons.bluetooth_disabled_rounded, color: Colors.white),
                onPressed: () {
                  HapticFeedback.heavyImpact();
                  showCupertinoModalBottomSheet(
                      barrierColor: Colors.black38,
                      expand: false,
                      context: context,
                      builder: (context) => CustomAlertModalBottomSheet(
                          title: disconnectTitle,
                          message: disconnectMsg,
                          actionYes: () => disconnectFnc()));
                },
              ),
            ),
          )
        ]));
  }
}
