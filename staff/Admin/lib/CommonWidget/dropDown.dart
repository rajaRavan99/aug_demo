import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebasedemo/CommonWidget/app_colors.dart';
import 'package:firebasedemo/CommonWidget/textfield.dart';
import 'package:firebasedemo/Screen/HomeScreen/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

myDropDown({required List<String> dropDowns, required RxString selectedValue, required onChanged,hint}) {
  // selectedValue.value = dropDowns.first;
  dropDowns.sort((a, b) => a.compareTo(b),);
  return Obx(() => Container(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10.0, bottom: 10.0),
        // color: Colors.transparent,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: DropdownButton2(
          iconStyleData: const IconStyleData(iconEnabledColor: AppColors.primaryColor),
          hint: Text("$hint", style: FontStyle.textBlack.copyWith(fontSize: 14)),
          isDense: true,
          isExpanded: true,
          value: selectedValue.value == "" ? null : selectedValue.value,
          underline: Container(color: Colors.transparent),
          alignment: Alignment.centerLeft,
          style: const TextStyle(color: Colors.black),
          items: dropDowns
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(
                    e ?? '',
                    style: FontStyle.textBlack
                        .copyWith(fontSize: 14),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ));
}