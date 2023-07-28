import 'package:flutter/material.dart';

class DividerOr extends StatelessWidget {
  const DividerOr({
    Key key,
    this.title = 'Title',
    @required this.titleStyle
  }) : super(key: key);
  final String title;
  final TextStyle titleStyle;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: EdgeInsets.only(left: 10.0, right: 15.0),
            child: Divider(
              color: Theme.of(context).primaryColor,
              height: 30,
            )),
      ),
      Text(title, style: titleStyle),
      Expanded(
        child: new Container(
            margin: EdgeInsets.only(left: 15.0, right: 10.0),
            child: Divider(
              color: Theme.of(context).primaryColor,
              height: 30,
            )),
      ),
    ]);
  }
}
