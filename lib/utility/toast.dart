import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void commonToast(String msg, {Color? color}) {
  Fluttertoast.showToast(
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    msg: msg,
    backgroundColor: color ?? const Color(0xffff5b62),
    textColor: Colors.white,
    timeInSecForIosWeb: 2,
  );
}
