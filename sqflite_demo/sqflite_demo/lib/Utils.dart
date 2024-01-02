import 'package:flutter/material.dart';

class Utils {

  inputDecoration(String msg){
    return InputDecoration(
      hintText: msg,
      hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
            width: 1, color: Colors.grey), //<-- SEE HERE
      ),

      errorBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
            width: 1, color: Colors.red), //<-- SEE HERE
      ),

      focusedBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
            width: 1, color: Colors.grey), //<-- SEE HERE
      ),

      focusedErrorBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
            width: 1, color: Colors.red), //<-- SEE HERE
      ),

    );
  }
}