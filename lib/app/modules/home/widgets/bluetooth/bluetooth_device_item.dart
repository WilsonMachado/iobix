import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../theme/text_theme.dart';
import '../../../../theme/color_theme.dart';
import '../../../../widgets/big_button.dart';

class BluetoothDeviceItem extends StatelessWidget {
  const BluetoothDeviceItem({
    Key key,
    @required this.deviceName,
    @required this.deviceType,
    @required this.buttonText,
    @required this.onPressed,
  }) : super(key: key);

  final String deviceName, deviceType, buttonText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), color: Colors.white),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: Icon(FontAwesomeIcons.bluetooth,
                color: Theme.of(context).primaryColor),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(deviceName, style: textInfo),
                Text(deviceType, style: textInfoMiniItalic)
              ],
            ),
          ),
          BigButton(
            text: buttonText,
            fontSize: 12.0,
            colorButton: ColorsTheme.salmon,
            width: null,
            height: null,
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
