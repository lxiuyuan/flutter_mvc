import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class T{
  static void show(BuildContext context,String message) {
    FToast(context).showToast(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
              color: Color(0xcc000000),
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            message,
            style: TextStyle(inherit: false, color: Colors.white, fontSize: 15),
          ),
        ),
        toastDuration: Duration(milliseconds: 1500),
        gravity: ToastGravity.CENTER);
  }
}