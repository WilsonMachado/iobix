import 'package:flutter/material.dart';

import '../theme/color_theme.dart';
import '../theme/text_theme.dart';

class FeatureTriggerCard extends StatelessWidget {
  const FeatureTriggerCard({
    Key key,
    this.title = 'Title',
    this.iconMainSize = 20.0,
    @required this.actionWidget,
    @required this.iconMain,
  }) : super(key: key);

  final String title;
  final IconData iconMain;
  final Widget actionWidget;
  final double iconMainSize;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 10.0,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.center,
                child: Icon(iconMain,
                    color: ColorsTheme.opaqueBlue, size: iconMainSize)),
            SizedBox(height: 3.0),
            Text(title,
                style: textInfoBold, textAlign: TextAlign.center),
            SizedBox(height: 12.0),
            actionWidget
          ],
        ),
      ),
    );
  }
}
