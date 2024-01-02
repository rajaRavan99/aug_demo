import 'package:direct_message/Screen/RemiderScreen/create_reminder_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:direct_message/CommonWidget/app_colors.dart';
import '../ConstData/colors.dart';

class Utils {

  containerButton(String msg, {bool isIcon = false, padding} ) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 12.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [blueColor, linerSecondColor],
          ),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isIcon == true
              ? const Icon(
                  Icons.add,
                  color: AppColors.white_00,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            width: 5,
          ),
          Text(
            msg,
            style: FontStyle.textLabelWhite,
          ),
        ],
      ),
    );
  }

  static InputDecoration inputDecoration(String msg) {
    return InputDecoration(
      hintText: msg,
      hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            const BorderSide(width: 1, color: Colors.grey), //<-- SEE HERE
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            const BorderSide(width: 1, color: Colors.red), //<-- SEE HERE
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            const BorderSide(width: 1, color: Colors.grey), //<-- SEE HERE
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            const BorderSide(width: 1, color: Colors.red), //<-- SEE HERE
      ),
    );
  }

  static TextFormField textFormField(String msg,TextEditingController controller,TextInputAction action) {
    return

      TextFormField(
        controller: controller,
        textAlign: TextAlign.start,
        textInputAction: action ?? TextInputAction.next,
        maxLines: 6,
        style: const TextStyle(fontSize: 12.0,overflow: TextOverflow.ellipsis),
        decoration: InputDecoration(
          fillColor: fieldBorder,
          filled: true,
          hintText: msg,
          hintStyle: const TextStyle( color: Colors.grey,fontSize: 12),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide:  const BorderSide(
                width: 1, color: AppColors.greyText), //<-- SEE HERE
          ),

          errorBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(11),
            borderSide:  const BorderSide(
                width: 1, color: AppColors.greyText), //<-- SEE HERE
          ),

          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide:  const BorderSide(
                width: 1, color: AppColors.greyText), //<-- SEE HERE
          ),

          focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
                width: 1, color: AppColors.greyText), //<-- SEE HERE
          ),

        ),
        validator: (value) {
          if(value!.isEmpty){
            return 'Please Enter Valid Input';
          }
          return null;

        },
      );
  }

  arrowBackAppBar(){
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        padding: const EdgeInsets.all(18.0),
        color: Colors.transparent,
        child: Image.asset('assets/arrow_back.png'),
      ),
    );
  }

  InputDecoration inputSmallDecoration(String msg) {
    return InputDecoration(
      hintStyle: FontStyle.textHint,
      errorStyle: FontStyle.textError,
      hintText: msg,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      filled: true,
      fillColor: AppColors.white_00,
    );
  }

}


