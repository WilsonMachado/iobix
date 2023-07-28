import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../theme/color_theme.dart';
import '../theme/text_theme.dart';

class InformationCard extends StatelessWidget {
  const InformationCard(
      {Key key,
      @required this.iconMain,
      @required this.title,
      @required this.content,
      this.reloadFnc,
      this.iconSize = 20.0, this.contentAlignment = CrossAxisAlignment.start})
      : super(key: key);

  final IconData iconMain;
  final String title;
  final List<Widget> content;
  final Function reloadFnc;
  final double iconSize;
  final CrossAxisAlignment contentAlignment;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 10.0,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: contentAlignment,
          
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(iconMain, color: ColorsTheme.opaqueBlue, size: iconSize),
                reloadFnc != null
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.rotateRight,
                              color: Theme.of(context).primaryColor, size: 10),
                          onPressed: () {
                            HapticFeedback.heavyImpact();
                            reloadFnc();
                          },
                        ),
                      )
                    : Container()
              ],
            ),
            SizedBox(height: 3.0),
            Text(title, style: textInfoBold),
            ...content,
          ],
        ),
      ),
    );
  }
}
