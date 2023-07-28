import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../theme/text_theme.dart';
import '../widgets/normal_button.dart';
import '../theme/color_theme.dart';

class CustomAlertModalBottomSheet extends StatelessWidget {
  final String title, message;
  final Function actionYes, actionNo;

  const CustomAlertModalBottomSheet({
    Key key,
    @required this.title,
    @required this.message,
    @required this.actionYes,
    this.actionNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.0),
              Text(title, style: textInfoBold),
              SizedBox(height: 10.0),
              Text(message, style: textInfo, textAlign: TextAlign.center),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NormalButton(
                      text: 'yes'.tr,
                      color: ColorsTheme.salmon,
                      onPressed: () {
                        Navigator.of(context).pop();
                        actionYes();
                      }),
                  NormalButton(
                    text: 'no'.tr,
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (actionNo != null) actionNo();
                    },
                    color: ColorsTheme.darkBlue,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
