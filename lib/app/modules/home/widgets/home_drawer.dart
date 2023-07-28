import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../home_controller.dart';
import '../../../theme/color_theme.dart';
import '../../../theme/text_theme.dart';
import '../../../utils/helpers/size_config.dart';
import '../../../data/models/local/model_login.dart';
import '../../../utils/constants/constants.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Container(
        padding: EdgeInsets.only(top: 20.0, left: 10.0, bottom: 10.0),
        color: ColorsTheme.darkBlue,
        child: Column(
          children: [
            Container(
              height: getProportionateScreenHeight(0.2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(backgroundColor: ColorsTheme.opaqueBlue),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('IoBix', style: miniTitleWhite),
                      Text(ModelLogin.nickname.tr, style: textInfo)
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: getProportionateScreenWidth(0.55),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _.drawerItems
                        .map((element) => GestureDetector(
                              onTap: () {
                                HapticFeedback.heavyImpact();
                                //_.drawerOption(element['route']);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(element['icon'], color: Colors.white),
                                    SizedBox(width: 10.0),
                                    Expanded(
                                        child: Text(
                                      element['title'].toString().tr,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ))
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        _.config();
                      },
                      child: Container(
                        width: getProportionateScreenWidth(0.47),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.settings, color: Colors.white),
                            SizedBox(width: 10.0),
                            Text('config'.tr, style: textInfo),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Container(width: 2, height: 20, color: Colors.white60),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                HapticFeedback.heavyImpact();
                                _.logout();
                              },
                              child: Text('logout'.tr, style: textInfo),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(width: 8.0),
                GestureDetector(
                  onTap: _.unlockAdmin,
                  child: Text('IoBix', style: textInfoMini)
                ),
                Text(CONSTANTS.APP_VERSION, style: textInfoSuperMini)
              ],
            )
          ],
        ),
      ),
    );
  }
}
