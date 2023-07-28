import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import './../theme/color_theme.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    Key key,
    @required this.onChanged, this.value = false,    
  }) : super(key: key);

  final Function onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: 35,
      child: Transform.scale(
        scale: 0.6,
        child: CupertinoSwitch(
          value: value,
          onChanged: (bool value) {
            HapticFeedback.heavyImpact();
            onChanged(value);
          },
          activeColor: ColorsTheme.salmon,
          trackColor: ColorsTheme.lightSalmon,
        ),
      ),
    );
  }
}
