import 'dart:async';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';

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
    time = "${date.hour}:${date.}";
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

  scanCode() {
    
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      verifyCode(barcode);
      // setState(() => this.barcode = barcode);
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

  verifyCode(String code) async {
    var url = 'http://10.0.2.2:1337/user/verifyqr';
    http.post(
      url, 
      headers: {
        'authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImVuY3JpcHRlZFBhc3N3b3JkIjoiIiwiY3JlYXRlZEF0IjoxNTMxOTQ0NzU3ODQ5LCJ1cGRhdGVkQXQiOjE1MzE5NDQ3NTc4NDksImlkIjoxLCJmaXJzdG5hbWUiOiJEYW5pZWwiLCJsYXN0bmFtZSI6IlJkeiIsImVtYWlsIjoiZGFueW1hcjI0QGdtYWlsLmNvbSJ9LCJpYXQiOjE1MzIwMTM5MDUsImV4cCI6MTUzMjYxODcwNX0.i_tjsyFg69auteKvSernC6UmiBeqCWcbfurBs7eTxCA'
      },
      body: code )
        .then((response) {

          print(response);
          return response;
        });
  }
}