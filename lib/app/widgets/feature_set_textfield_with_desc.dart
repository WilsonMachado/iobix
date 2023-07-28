import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/text_theme.dart';

class FeatureSetTextFieldWithDesc extends StatelessWidget {
  const FeatureSetTextFieldWithDesc({
    Key key,
    this.maxLength = 2,
    this.hintext = 'hint',
    this.initialValue,
    this.errorText = '',
    @required this.onChangedText,
    this.keyboardType = TextInputType.number,
    @required this.description,
  }) : super(key: key);

  final int maxLength;
  final Widget description;
  final String hintext, initialValue, errorText;
  final Function onChangedText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(flex: 6, child: description),
            SizedBox(
              width: 12,
            ),
            Flexible(
              flex: 1,
              child: TextFormField(
                initialValue: initialValue,
                maxLength: maxLength,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                onChanged: (text) => onChangedText(text),
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: hintext,
                  hintStyle: textInfo,
                ),
              ),
            ),
          ],
        ),
        if (errorText.length > 0)
          Column(
            children: [
              SizedBox(height: 5),
              Text(
                errorText,
                style: textInfoError,
              )
            ],
          ),
      ],
    );
  }
}
