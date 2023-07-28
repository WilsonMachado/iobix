import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/color_theme.dart';

class NormalButton extends StatelessWidget {
  const NormalButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.color,
  }) : super(key: key);

  final String text;
  final Function onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        backgroundColor:
            MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          return (states.contains(MaterialState.disabled))
              ? Colors.grey
              : color != null
                  ? color
                  : ColorsTheme.salmon;
        }),
      ),

      onPressed: onPressed != null
          ? () {
              HapticFeedback.heavyImpact();
              onPressed();
            }
          : null,
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}
