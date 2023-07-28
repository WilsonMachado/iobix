import 'package:flutter/material.dart';

import '../../../utils/helpers/size_config.dart';
import '../../../theme/color_theme.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;

  const LoginBackground({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getProportionateScreenHeight(1.0),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("assets/images/login/top1.png",
                width: getProportionateScreenWidth(1.0),
                color: ColorsTheme.darkBlue),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login/top2.png",
              width: getProportionateScreenWidth(1.0),
              color: ColorsTheme.darkBlue,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/images/login/bottom1.png",
                width: getProportionateScreenWidth(1.0),
                color: ColorsTheme.darkBlue),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/images/login/bottom2.png",
                width: getProportionateScreenWidth(1.0),
                color: ColorsTheme.darkBlue),
          ),
          child
        ],
      ),
    );
  }
}
