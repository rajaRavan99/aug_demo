import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'setting_screen_controller.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  SettingScreenController settingScreenController = Get.put(SettingScreenController());

  @override
  Widget build(BuildContext context) {
    settingScreenController.buildContext = context;

    return WillPopScope(
      onWillPop: () {
        settingScreenController.showExitPopup();
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 5.0,
              shadowColor: Colors.grey.withOpacity(0.2),
              backgroundColor: likeWhiteColor,
              centerTitle: true,
              title: Text(
                   'Setting',
                  style: FontStyle.textBlack.copyWith(fontSize: 18)),

            ),
           body : SafeArea(
             child: SizedBox(
               child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 10),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [

                       const SizedBox(height: 10),

                       GetBuilder(
                         init: settingScreenController,
                         builder: (controller) =>
                           ListView.builder(
                             shrinkWrap: true,
                             physics: const ClampingScrollPhysics(),
                             itemCount: settingScreenController.drawerList.value.length,
                             itemBuilder: (context, index) {
                               var data = settingScreenController.drawerList.value[index];
                               return GestureDetector(
                                 onTap: () {
                                   settingScreenController.onPress(index);
                                   settingScreenController.onTapIndex(index);
                                 },
                                 child: Padding(
                                   padding: const EdgeInsets.symmetric(vertical: 5.0 ),
                                   child: Container(
                                     color: Colors.transparent,
                                     child: Column(
                                       children: [
                                         Row(
                                           children: [

                                             Container(alignment: Alignment.center,
                                               padding: const EdgeInsets.symmetric( ),

                                               decoration:BoxDecoration(
                                                 color: data.isSelected?.value == false ? settingPageGrey : blueColor,
                                                 shape: BoxShape.circle,
                                               ),
                                               child:  Padding(
                                                 padding: const EdgeInsets.all(12.0),
                                                 child: Image.asset(alignment: Alignment.center,
                                                   data.icon.toString(),
                                                   width: 20,
                                                   color: Colors.white,),
                                               ),
                                             ),

                                             const Padding(
                                               padding:  EdgeInsets.symmetric(horizontal: 5.0),
                                               child:  SizedBox(),
                                             ),

                                             Text(
                                                 data.title.toString(),
                                                 style: FontStyle.textBlack.copyWith(
                                                     fontWeight: FontWeight.w500,fontSize: 14,
                                                     color: data.isSelected?.value == false ? settingPageGrey : blueColor )
                                             ),
                                           ],
                                         ),

                                         const SizedBox(height: 10),

                                         const Divider(
                                           thickness: 1,height: 1,
                                           color: lightGreyWhite,
                                         )
                                       ],
                                     ),
                                   ),
                                 ),
                               );
                             },),
                       ),
                     ],
                   ),
               ),

             ),
           )
        ),
      ),
    );
  }
}