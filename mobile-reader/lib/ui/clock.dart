import 'package:flutter/material.dart';
import 'dart:async';

class Clock extends StatefulWidget {
  @override
  State createState() => new _ClockState();
}

class _ClockState extends State<Clock> {
  
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
    return new Text(time, style: new TextStyle(color: Colors.white, fontSize: 100.0, fontWeight: FontWeight.bold));
  }
}