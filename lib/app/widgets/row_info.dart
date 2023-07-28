import 'package:flutter/material.dart';

import '../theme/text_theme.dart';

class RowInfo extends StatelessWidget {
  final String label, value;

  const RowInfo(
      {Key key,
      this.label = 'Write label here',
      this.value = 'Write value here'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(label, style: textInfo)),
        SizedBox(width: 10.0),
        Text(value, style: textInfoBold),
      ],
    );
  }
}
