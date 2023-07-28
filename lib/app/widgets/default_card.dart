import 'package:flutter/material.dart';

class DefaultCard extends StatelessWidget {
  const DefaultCard({Key key, this.child, this.color = Colors.white}) : super(key: key);

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 10.0,
        child: Padding(padding: EdgeInsets.all(15.0), child: child));
  }
}
