import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'circular_button.dart';
import '../theme/text_theme.dart';
import '../theme/color_theme.dart';

class FeatureSetTextField extends StatelessWidget {
  const FeatureSetTextField({
    Key key,
    this.maxLength = 10,
    this.keyboardType = TextInputType.text,
    this.hintText = 'hint',
    this.labelText = 'label',
    this.initialValue,
    @required this.onChangedText,
    this.onPressedSet,
    this.showSetButton = true,
    this.errorText,
    this.textAlign = TextAlign.start,
    this.enableSuggestions = true,
    this.obscureText = false,
  }) : super(key: key);

  final int maxLength;
  final TextInputType keyboardType;
  final String hintText, labelText, errorText, initialValue;
  final Function onChangedText, onPressedSet;
  final bool showSetButton;
  final TextAlign textAlign;
  final bool enableSuggestions, obscureText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: errorText != null
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextFormField(
            initialValue: initialValue,
            maxLength: maxLength,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            onChanged: (text) => onChangedText(text),
            keyboardType: keyboardType,
            textAlign: textAlign,
            enableSuggestions: enableSuggestions,
            obscureText: obscureText,
            decoration: InputDecoration(
                counterText: '',
                hintText: hintText,
                hintStyle: textInfo,
                labelText: labelText,
                labelStyle: textInfo,
                errorText: errorText,
                errorStyle: textInfoError,
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorsTheme.salmon))),
          ),
        ),
        showSetButton ? SizedBox(width: 15.0) : Container(),
        showSetButton
            ? CircularButton(
                icon: FontAwesomeIcons.angleRight, onPressed: onPressedSet)
            : Container()
      ],
    );
  }
}
