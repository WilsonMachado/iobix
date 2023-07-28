import 'package:flutter/material.dart';

import '../theme/text_theme.dart';

class HorizontalStepProgress extends StatelessWidget {
  final int lenSteps, currentStep;
  final String progressMsg;
  final Color successStepColor, unsuccessStepColor;

  const HorizontalStepProgress({
    Key key,
    @required this.lenSteps,
    @required this.currentStep,
    @required this.progressMsg,
    this.successStepColor,
    this.unsuccessStepColor = const Color(0xffd8d8d8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              lenSteps,
              (index) => Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 5),
                      height: 6,
                      //width: 20,
                      decoration: BoxDecoration(
                          color: currentStep >= index
                              ? successStepColor ?? Theme.of(context).primaryColor
                              : unsuccessStepColor,
                          borderRadius: BorderRadius.circular(3)),
                    ),
                  )),
        ),
        SizedBox(height: 5.0),
        Text(progressMsg,
            style: textInfoMiniItalic,
            textAlign: TextAlign.center)
      ],
    );
  }
}
