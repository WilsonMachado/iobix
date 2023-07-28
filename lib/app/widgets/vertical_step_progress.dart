import 'package:flutter/material.dart';

import '../theme/text_theme.dart';

class VerticalStepProgress extends StatelessWidget {
  const VerticalStepProgress({
    Key key,
    @required this.lenSteps,
    @required this.currentStep,
    @required this.msgStep,
    this.successStepColor,
    this.unsuccessStepColor = const Color(0xffd8d8d8),
    @required this.successIcon,
    this.successIconColor = Colors.white
  }) : super(key: key);

  final int lenSteps, currentStep;
  final Function msgStep;
  final Color successStepColor, unsuccessStepColor, successIconColor;
  final IconData successIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      alignment: Alignment.centerLeft,
      child: Column(
          children: List.generate(
        lenSteps,
        (index) => index <= (currentStep + 1)
            ? Column(
                children: [
                  Row(
                    children: [
                      Container(
                          height: 20,
                          width: 20,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: index <= currentStep
                                  ? successStepColor ??
                                      Theme.of(context).primaryColor
                                  : unsuccessStepColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: index <= currentStep ? Icon(successIcon, color: successIconColor, size: 10) : null),
                      Expanded(
                        child: Text(index <= currentStep ? msgStep(index) : msgStep(index),
                            style: textInfoMiniItalic,
                            textAlign: TextAlign.left),
                      )
                    ],
                  ),
                  SizedBox(height: 12.0)
                ],
              )
            : Container(),
      )),
    );
  }
}
