import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './../theme/color_theme.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
    this.iconSize = 15.0,
    this.iconColor,
  }) : super(key: key);

  final IconData icon;
  final double iconSize;
  final Function onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: iconSize * 2,
      width: iconSize * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: onPressed != null
            ? iconColor != null
                ? iconColor
                : ColorsTheme.salmon
            : Colors.grey,
      ),
      child: IconButton(
          icon: Icon(
            icon,
            color: Colors.white,
            size: iconSize,
          ),
          onPressed: onPressed != null
              ? () {
                  HapticFeedback.heavyImpact();
                  onPressed();
                }
              : null),
    );
  }
}
