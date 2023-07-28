import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/helpers/size_config.dart';
import '../../../theme/color_theme.dart';
import '../../../theme/text_theme.dart';

class HomeTopBar extends StatelessWidget {
  final bool isDrawerOpenFgControl;
  final Function showDrawerFunction;
  final String title, subtitle;

  const HomeTopBar(
      {Key key,
      @required this.isDrawerOpenFgControl,
      @required this.showDrawerFunction,
      @required this.title,
      this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getProportionateScreenHeight(0.1),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          color: ColorsTheme.darkBlue,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.0))),
      child: Stack(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: miniTitleWhite),
              if(subtitle != null) Text(subtitle, style: textInfo),
            ],
          ),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              padding: EdgeInsets.only(left: 10.0),
              icon: isDrawerOpenFgControl
                  ? Icon(Icons.arrow_back_ios_rounded, color: Colors.white)
                  : Icon(FontAwesomeIcons.gripLines,
                      color: Colors.white, size: 18.0),
              onPressed: () {
                showDrawerFunction();
                HapticFeedback.heavyImpact();
              },
            ))
      ]),
    );
  }
}
