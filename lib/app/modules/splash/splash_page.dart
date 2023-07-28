import 'package:flutter/material.dart';

import 'widgets/splash_body.dart';
import '../../utils/helpers/size_config.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
          child: Scaffold(
        body: SplashBody(),
      )),
    );
  }
}
