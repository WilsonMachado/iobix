import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../splash_controller.dart';
import 'splash_content.dart';
import '../../../theme/color_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../../widgets/big_button.dart';
import '../../../utils/helpers/size_config.dart';
import '../../../theme/text_theme.dart';

class SplashBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        builder: (_) => Container(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Text('IoBix', style: title),
                  Spacer(),
                  Expanded(
                      flex: 4,
                      child: PageView.builder(
                        onPageChanged: _.onPageChanged,
                        itemCount: _.splashData.length,
                        itemBuilder: (context, index) => SplashContent(
                            text: _.splashData[index]['text'].toString().tr,
                            image: _.splashData[index]['image']),
                      )),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(0.1)),
                      child: Obx(
                        () => Column(
                          children: [
                            Spacer(),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    _.splashData.length,
                                    (index) => buildDot(
                                        index: index,
                                        currentPage: _.currentPage))),
                            Spacer(flex: 3),
                            BigButton(
                              text: 'continue'.tr,
                              onPressed: _.isContinue ? _.continueButton : null,
                              colorButton: ColorsTheme.salmon,
                            ),
                            Spacer()
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }

  AnimatedContainer buildDot({int index, currentPage}) {
    return AnimatedContainer(
      duration: CONSTANTS.ANIMATION_DURATION,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color:
              currentPage == index ? ColorsTheme.darkBlue : Color(0xffd8d8d8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
