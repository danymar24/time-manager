import 'package:http/http.dart' as http;
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';

Future scan() async {
  try {
    String barcode = await BarcodeScanner.scan();
    var result = verifyCode(barcode);
    return result;
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.CameraAccessDenied) {
      return 'The user did not grant the camera permission!';
    } else {
      return 'Unknown error: $e';
    }
  } on FormatException{
    return 'null (User returned using the "back"-button before scanning anything. Result)';
  } catch (e) {
    return 'Unknown error: $e';
  }
}

verifyCode(String code) async {
  var url = 'http://10.0.2.2:1337/user/verifyqr';
  return http.post(
    url, 
    headers: {
      'authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImVuY3JpcHRlZFBhc3N3b3JkIjoiIiwiY3JlYXRlZEF0IjoxNTMxOTQ0NzU3ODQ5LCJ1cGRhdGVkQXQiOjE1MzE5NDQ3NTc4NDksImlkIjoxLCJmaXJzdG5hbWUiOiJEYW5pZWwiLCJsYXN0bmFtZSI6IlJkeiIsImVtYWlsIjoiZGFueW1hcjI0QGdtYWlsLmNvbSJ9LCJpYXQiOjE1MzIwMTM5MDUsImV4cCI6MTUzMjYxODcwNX0.i_tjsyFg69auteKvSernC6UmiBeqCWcbfurBs7eTxCA'
    },
    body: code 
  ).then((http.Response response) {
    return response;
  });
}