import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/get_utils.dart';

import './widgets/config_body.dart';
import '../../theme/text_theme.dart';

class ConfigPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(), child: ConfigBody()),
        appBar: AppBar(
          title: Text('config'.tr, style: miniTitleWhite),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, size: 18.0),
              onPressed: () {
                HapticFeedback.heavyImpact();
                Navigator.of(context).pop();
              }),
        ),
      ),
    );
  }
}
