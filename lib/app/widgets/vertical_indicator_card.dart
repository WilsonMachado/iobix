import 'package:flutter/material.dart';
import 'package:iobix/app/widgets/normal_button.dart';

import '../theme/text_theme.dart';
import '../theme/color_theme.dart';

class VerticalIndicatorCard extends StatelessWidget {
  const VerticalIndicatorCard(
      {Key key,
      @required this.title,
      @required this.unit,
      @required this.icon,
      @required this.value,
      this.showButton = false,
      this.onPressed,
      this.textButton = 'mm',
      this.iconSize = 30.0,
      this.digits = 0,
      this.titleStyle})
      : super(key: key);

  final String title, unit;
  final TextStyle titleStyle;
  final IconData icon;
  final double value, iconSize;
  final int digits;
  final bool showButton;
  final Function onPressed;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    String valueStr = value.toStringAsFixed(digits), valueInteger, valueDouble;
    valueInteger =
        digits != 0 ? valueStr.split('.')[0] : value.toStringAsFixed(0);
    valueDouble = digits != 0 ? valueStr.split('.')[1] : null;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 10.0,
      child: Padding(
          padding: EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(title,
                    style: titleStyle != null ? titleStyle : textInfoBold)),
            SizedBox(height: 10),
            Icon(icon, size: iconSize, color: ColorsTheme.opaqueBlue),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.center,
              textBaseline: TextBaseline.alphabetic,
              children: [
                SizedBox(
                    height: 40,
                    child: Text(valueInteger, style: variableIndicator)),
                Text(digits != 0 ? '.$valueDouble' : '',
                    style: variableIndicatorUnit)
              ],
            ),
            Text(unit, style: variableIndicatorUnit),
            if (showButton) NormalButton(text: textButton, onPressed: onPressed)
          ])),
    );
  }
}
