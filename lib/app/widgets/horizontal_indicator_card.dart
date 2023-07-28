import 'package:flutter/material.dart';

import '../theme/text_theme.dart';
import '../theme/color_theme.dart';

class HorizontalIndicatorCard extends StatelessWidget {
  const HorizontalIndicatorCard(
      {Key key,
      @required this.title,
      @required this.value,
      @required this.unit,
      @required this.icon,
      this.iconSize = 30.0,
      this.digits = 0})
      : super(key: key);

  final String title, unit;
  final IconData icon;
  final double value, iconSize;
  final int digits;

  @override
  Widget build(BuildContext context) {
    String valueStr = value.toStringAsFixed(digits), valueInteger, valueDouble;
    valueInteger =
        digits != 0 ? valueStr.split('.')[0] : value.toStringAsFixed(0);
    valueDouble = digits != 0 ? valueStr.split('.')[1] : null;
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 10.0,
        child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textInfoBold),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    mainAxisAlignment: MainAxisAlignment.start,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1.0),
                        child: Icon(icon,
                            size: iconSize, color: ColorsTheme.opaqueBlue),
                      ),
                      SizedBox(width: 2),
                      Text(valueInteger,
                          style: variableIndicator),
                      Text(digits != 0 ? '.$valueDouble$unit' : unit,
                          style: variableIndicatorUnit),
                    ],
                  )
                ])));
  }
}
