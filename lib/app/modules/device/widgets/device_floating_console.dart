import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/helpers/size_config.dart';
import '../../../theme/text_theme.dart';
import '../../../theme/color_theme.dart';
import '../../../widgets/circular_button.dart';

class DeviceFloatingConsole extends StatelessWidget {
  final bool control;
  final String title, content;
  final Function trashFnc, closeFnc;

  const DeviceFloatingConsole(
      {Key key,
      this.control = false,
      this.title = '',
      this.content = '',
      @required this.trashFnc,
      @required this.closeFnc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return control
        ? Container(
            clipBehavior: Clip.antiAlias,
            //width: double.infinity,
            height: getProportionateScreenHeight(0.2),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                border: Border.all(color: ColorsTheme.darkBlue, width: 2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: 5.0),
                    Text(title, style: textInfoBold),
                    Spacer(),
                    CircularButton(
                        icon: FontAwesomeIcons.trash,
                        iconColor: ColorsTheme.darkBlue,
                        onPressed: () => trashFnc()),
                    SizedBox(width: 5.0),
                    CircularButton(
                        icon: FontAwesomeIcons.circleXmark,
                        iconColor: ColorsTheme.darkBlue,
                        iconSize: 16,
                        onPressed: () =>
                          closeFnc()
                        )
                  ],
                ),
                SizedBox(height: 5.0),
                Expanded(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  reverse: false,
                  child: Container(
                    child: Text(content),
                  ),
                ))
              ],
            ),
          )
        : Container();
  }
}
