import 'dart:async';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class LandingPage extends StatefulWidget {
  @override
  State createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  String barcode = "";
  DateTime date = new DateTime.now();
  String time;
  Timer timer;

  @override   
  void initState() {
    const fiveSec = const Duration(seconds: 5);
    super.initState();
    time = "${date.hour}:${date.minute}";
    timer = new Timer.periodic(fiveSec, (Timer t) {
      setState(() {
        date = new DateTime.now();
        time = "${date.hour}:${date.minute}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.blueAccent,
      child: new InkWell(
        onTap: scan,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(time, style: new TextStyle(color: Colors.white, fontSize: 100.0, fontWeight: FontWeight.bold)),
            new Text("Scan QR code:", style: new TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold)),
            new Text(barcode),
          ],
        ),
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      print(barcode);
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}