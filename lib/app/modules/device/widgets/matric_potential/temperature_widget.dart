import 'package:flutter/material.dart';


import '../../../../theme/color_theme.dart';
import '../../../../theme/text_theme.dart';

class TemperatureWidget extends StatelessWidget {
  const TemperatureWidget({
    Key key,
    @required this.value,
    this.desc = 'Descripción',
  }) : super(key: key);

  final String value, desc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: (value.length < 8)
                ? variableIndicator
                : TextStyle(
                    color: ColorsTheme.darkBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Text(desc, style: variableIndicatorUnit)
        ],
      ),
    );
  }
}