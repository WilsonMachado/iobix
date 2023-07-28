import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../theme/text_theme.dart';

class CustomDropdownItem<T> extends StatelessWidget {
  const CustomDropdownItem(
      {Key key,
      @required this.onChanged,
      @required this.itemsMap,
      @required this.items,
      @required this.idx})
      : super(key: key);

  final Function onChanged;
  final Map<T, String> itemsMap;
  final List<String> items;
  final int idx;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: TextButton(
          onPressed: () {
            HapticFeedback.heavyImpact();
            onChanged(
                itemsMap.keys.firstWhere((k) => itemsMap[k] == items[idx]));
            Navigator.of(context).pop();
          },
          child:
              Align(alignment: Alignment.centerLeft, child: Text(items[idx].tr, style: textInfoBold,)),
        ));
  }
}