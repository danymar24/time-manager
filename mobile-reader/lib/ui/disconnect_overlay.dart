import 'package:flutter/material.dart';

class DisconnectOverlay extends StatefulWidget {
  @override
  State createState() => new _DisconnectOverlayState();
}

class _DisconnectOverlayState extends State<DisconnectOverlay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.redAccent,
      child: new InkWell(
        onTap: () => print('hello overlay'),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              child: new Text('Not connected')
            )
          ],
        )
      )
    );
  }
}