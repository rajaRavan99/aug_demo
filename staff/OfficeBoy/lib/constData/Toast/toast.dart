import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

flutterToast({required String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black.withOpacity(0.5),
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 15.0
  );
}