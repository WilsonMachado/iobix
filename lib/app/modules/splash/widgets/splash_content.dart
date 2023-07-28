import 'package:flutter/material.dart';

import '../../../utils/helpers/size_config.dart';
import '../../../theme/text_theme.dart';

class SplashContent extends StatelessWidget {
  final String text, image;

  const SplashContent({
    Key key,
    @required this.text,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(
              text,
              style: textContent,
              textAlign: TextAlign.center),
          Image.asset(image,
              height: getProportionateScreenHeight(0.38),
              width: getProportionateScreenWidth(0.7))
        ],
      ),
    );
  }
}