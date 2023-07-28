import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/size_config.dart';
import '../../../theme/color_theme.dart';
import '../../../theme/text_theme.dart';
import '../../../widgets/big_button.dart';
import '../login_controller.dart';

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        id: 'login',
        builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(0.05)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${'welcome'.tr},', style: title),
                      Text('sign_continue'.tr, style: textInfo),
                      SizedBox(height: getProportionateScreenHeight(0.05)),
                      TextField(
                        controller: TextEditingController()..text = _.user,
                        onChanged: _.onChangedUser,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: 'user'.tr,
                            icon: Icon(Icons.account_circle_rounded,
                                color: ColorsTheme.darkBlue)),
                      ),
                      Obx(
                        () => Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextField(
                              controller: TextEditingController()
                                ..text = _.password,
                              style: TextStyle(decoration: TextDecoration.none),
                              onChanged: _.onChangedPassword,
                              //keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              enableSuggestions: false,
                              obscureText: _.hidePassword,
                              decoration: InputDecoration(
                                  hintText: 'password'.tr,
                                  icon: Icon(Icons.lock_open_rounded,
                                      color: ColorsTheme.darkBlue)),
                            ),
                            IconButton(
                              icon: Icon(
                                  _.hidePassword
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                  color: ColorsTheme.salmon),
                              onPressed: _.onChangedPasswordVisibility,
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Obx(() => Column(
                              children: [
                                Text(_.notify.tr, style: textInfoError),
                              ],
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 24.0,
                            width: 24.0,
                            margin: EdgeInsets.only(right: 18),
                            child: Obx(
                              () => Checkbox(
                                activeColor: ColorsTheme.salmon,
                                onChanged: (v) => _.onChangedRememberMe(v),
                                value: _.rememberMe,
                              ),
                            ),
                          ),
                          Text('Recuérdame', style: textInfoBold),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(0.04)),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(0.05)),
                  child: BigButton(
                      colorButton: ColorsTheme.salmon,
                      text: 'login'.tr,
                      onPressed: _.login,
                      width: getProportionateScreenWidth(0.4)),
                ),
              ],
            ));
  }
}
