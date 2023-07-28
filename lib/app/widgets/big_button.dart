import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/helpers/size_config.dart';
import '../theme/color_theme.dart';

class BigButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color colorText;
  final Color colorButton;

  final double width;
  final double height;

  const BigButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.width = double.infinity,
    this.height = 0.0,
    this.fontSize = 18.0,
    this.colorText = Colors.white,
    this.colorButton,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height == 0.0 ? getProportionateScreenWidth(0.15) : height,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) {
                return states.contains(MaterialState.disabled)
                    ? Colors.grey
                    : colorButton != null
                        ? colorButton
                        : ColorsTheme.darkBlue;
              },
            )),
        onPressed: onPressed != null
            ? () {
                HapticFeedback.heavyImpact();
                onPressed();
              }
            : null,
        child: Text(
          text,
          style: TextStyle(color: colorText, fontSize: fontSize),
        ),
      ),
    );
  }
}
