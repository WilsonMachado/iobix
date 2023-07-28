import 'package:flutter/material.dart';

import 'color_theme.dart';
import 'text_theme.dart';

final ThemeData appThemeData = ThemeData(
  // ignore: deprecated_member_use
  accentColor: ColorsTheme.salmon,
  primaryColor: ColorsTheme.darkBlue,
  splashColor: ColorsTheme.darkBlue,
  scaffoldBackgroundColor: Colors.white,
  textSelectionTheme: TextSelectionThemeData(cursorColor: ColorsTheme.darkBlue),
  fontFamily: 'Muli',
  textTheme: TextTheme(
      headline1: title,
      headline2: subTitle,
      bodyText1: textContent,
      bodyText2: textInfo),
);
