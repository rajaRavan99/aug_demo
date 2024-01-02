import 'package:flutter/material.dart';
import '../../CommonWidget/app_colors.dart';

class Utils {
  static InputDecoration inputDecoration(String msg){
    return InputDecoration(
      hintText: msg,
      hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),

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

  containerDecoration() {
    return BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(15));
  }
}