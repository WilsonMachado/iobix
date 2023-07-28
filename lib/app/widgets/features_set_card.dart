import 'package:flutter/material.dart';

import '../theme/color_theme.dart';
import '../theme/text_theme.dart';

class FeaturesSetCard extends StatelessWidget {
  const FeaturesSetCard({
    Key key,
    @required this.widgetFeatures,
    this.leadingWidget,
    @required this.title, 
    @required this.iconMain,
  }) : super(key: key);

  final String title;
  final Widget widgetFeatures, leadingWidget;
  final IconData iconMain;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 10.0,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(iconMain,
                    color: ColorsTheme.opaqueBlue),
                leadingWidget != null ? leadingWidget : Container()
              ],
            ),
            SizedBox(height: 3.0),
            Text(title, style: textInfoBold),
            widgetFeatures
          ],
        ),
      ),
    );
  }
}
