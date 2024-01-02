import 'package:firebasedemo/CommonWidget/app_colors.dart';
import 'package:firebasedemo/CommonWidget/textfield.dart';
import 'package:flutter/material.dart';

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

  popupmenuButton() {
    return PopupMenuButton(
      itemBuilder: (_) => <PopupMenuItem<String>>[
        const PopupMenuItem<String>(
            value: 'Setting',
            child:  Text('Setting')),
        const PopupMenuItem<String>(
            value: 'LogOut',
            child: Text('LogOut')),
      ],
      onSelected: (value) {},
    );
  }

  successSnack(context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white_00,
                  ),
                  child: const Center(
                      child: Icon(
                        Icons.done,
                        color: AppColors.green_45,
                      ))),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Text(
                  msg,
                  style: FontStyle.textBlack,
                )),
          ],
        ),
        duration: const Duration(milliseconds: 3500),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: AppColors.green_45,
        width: MediaQuery.of(context).size.width * .9,
      ),
    );
  }



  containerDecoration() {

    return BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(15));
  }

  popUp(context){
    print('Error to open');
    return PopupMenuButton(
      // initialValue: selectedMenu,
      // Callback that sets the selected popup menu item.
      onSelected: (item) {},
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        const PopupMenuItem(
          // value: SampleItem.itemOne,
          child: Text('Item 1'),
        ),
        const PopupMenuItem(
          // value: SampleItem.itemTwo,
          child: Text('Item 2'),
        ),
        const PopupMenuItem(
          // value: SampleItem.itemThree,
          child: Text('Item 3'),
        ),
      ],
    );

  }

  
}