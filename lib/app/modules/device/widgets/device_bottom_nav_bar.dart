import 'package:badges/badges.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../device_controller.dart';
import '../../../theme/color_theme.dart';
import '../../../data/models/local/model_login.dart';

class DeviceBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceController>(
      builder: (_) => Obx(
          () => BubbleBottomBar(
          backgroundColor: ColorsTheme.darkBlue,
          //fabLocation: BubbleBottomBarFabLocation.center,
          opacity: 0.2,
          currentIndex: _.bottomNavBarIdx.index,
          onTap: (index) => _.onChangedBottomNavBarIndex(index),
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                  16.0)), //border radius doesn't work when the notch is enabled.
          elevation: 8,
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
                backgroundColor: ColorsTheme.lightSalmon,
                icon: Icon(
                  Icons.dashboard,
                  color: Colors.grey,
                  size: 18.0,
                ),
                activeIcon: Icon(
                  Icons.dashboard,
                  color: ColorsTheme.salmon,
                ),
                title: Text('Home')),
            BubbleBottomBarItem(
                backgroundColor: ColorsTheme.lightSalmon,
                icon: Icon(
                  FontAwesomeIcons.gear,
                  color: Colors.grey,
                  size: 18.0,
                ),
                activeIcon: Icon(
                  FontAwesomeIcons.gear,
                  color: ColorsTheme.salmon,
                ),
                title: Text('config'.tr)),
            if(ModelLogin.isAdmin()) BubbleBottomBarItem(
                backgroundColor: ColorsTheme.lightSalmon,
                icon: Badge(
                  position: BadgePosition.topEnd(top: -20.0, end: -20.0),
                  badgeColor: ColorsTheme.salmon,
                  badgeContent: Text(_.counterNotifyConsole.toString(), style: TextStyle(color: Colors.white, fontSize: _.counterNotifyConsole > 99 ? 9.0 : 12.0)),
                  showBadge: _.showCounterNotifyConsole,
                  animationDuration: Duration(milliseconds: 200),
                  child: Icon(
                    FontAwesomeIcons.terminal,
                    color: Colors.grey,
                    size: 15.0
                  ),
                ),
                activeIcon: Icon(
                  FontAwesomeIcons.terminal,
                  color: ColorsTheme.salmon,
                  size: 20.0,
                ),
                title: Text('console'.tr))
          ],
        ),
      ),
    );
  }
}
