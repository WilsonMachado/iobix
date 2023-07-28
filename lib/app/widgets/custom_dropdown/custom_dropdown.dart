import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../theme/color_theme.dart';
import '../../theme/text_theme.dart';
import '../../utils/helpers/size_config.dart';
import '../circular_button.dart';
import 'custom_dropdown_item.dart';

class CustomDropdown<T> extends StatelessWidget {
  final Map<T, String> itemsMap;
  final Function onChanged;
  final String floatingLabel;
  final String hintText;
  final String value;
  final double valueFontSize;
  final String errorText;
  final String dropdownTitle, dropdownSubtitle;
  final bool withBorder;

  final bool showSetButton;
  final Function onPressedSet;

  const CustomDropdown({
    Key key,
    @required this.itemsMap,
    @required this.onChanged,
    this.floatingLabel = 'label',
    this.hintText = 'select',
    @required this.value,
    this.valueFontSize = 14.0,
    this.errorText = 'error',
    @required this.dropdownTitle,
    @required this.dropdownSubtitle,
    this.showSetButton = true,
    this.onPressedSet,
    this.withBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> items = itemsMap.entries.map((e) => e.value).toList();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.zero,
            child: InputDecorator(
                decoration: InputDecoration(
                  errorText: errorText,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  labelText: floatingLabel,
                  errorStyle: textInfoError,
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsTheme.salmon)),
                  border: (withBorder)
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))
                      : InputBorder.none,
                ),
                child: GestureDetector(
                  onTap: onChanged != null
                      ? () {
                          HapticFeedback.heavyImpact();
                          showCupertinoModalBottomSheet(
                              barrierColor: Colors.black38,
                              expand: false,
                              context: context,
                              builder: (context) => Material(
                                    elevation: 10.0,
                                    child: SafeArea(
                                      top: false,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 10.0),
                                          Text(dropdownTitle,
                                              style: textInfoBold),
                                          SizedBox(height: 10.0),
                                          Text(dropdownSubtitle,
                                              style: textInfo,
                                              textAlign: TextAlign.center),
                                          SizedBox(height: 10.0),
                                          Container(
                                            width: double.infinity,
                                            height:
                                                getProportionateScreenHeight(
                                                    0.2),
                                            child: ListView.builder(
                                              itemCount: items.length,
                                              itemBuilder: (__, idx) =>
                                                  CustomDropdownItem(
                                                      idx: idx,
                                                      onChanged: onChanged,
                                                      itemsMap: itemsMap,
                                                      items: items),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(value != null ? value : hintText,
                              style: value != null
                                  ? TextStyle(
                                      color: ColorsTheme.darkBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: valueFontSize)
                                  : textInfo)),
                      SizedBox(
                          width: 20,
                          height: 20,
                          child: Icon(FontAwesomeIcons.angleDown, size: 20))
                    ],
                  ),
                )),
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
