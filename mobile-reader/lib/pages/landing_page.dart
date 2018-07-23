import 'package:flutter/material.dart';

import '../ui/clock.dart';
import '../ui/disconnect_overlay.dart';

import '../utils/scan.dart';

class LandingPage extends StatefulWidget {
  @override
  State createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  String barcode = "";

  @override   
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.blueAccent,
      child: new InkWell(
        onTap: scanCode,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Clock(),
            new Text("Scan QR code:", style: new TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold)),
            new Text(barcode, style: new TextStyle(color: Colors.white, fontSize: 20.0)),
          ],
        ),
      ),
    );
  }

  scanCode() {
    this.setState(() => scan());
  }
}