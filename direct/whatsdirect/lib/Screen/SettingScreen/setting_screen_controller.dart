import 'dart:io';
import 'package:direct_message/CommonWidget/Utils.dart';
import 'package:direct_message/CommonWidget/flutter_toast.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:direct_message/ConstData/rating_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ConstData/initializeRemoteConfig.dart';
import '../../Model/Ui_Model/drawer_model.dart';
import '../../Routes/routes.dart';

class SettingScreenController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxList<Widget> pageList = RxList();
  BuildContext? buildContext;



  navigateToHowToUsePage() {
    Get.toNamed(AppRoute.howToUseScreen);
  }


  RxList<DrawerModel> drawerList = [
    DrawerModel(title:"How to use",icon: 'assets/Drawer/howtouse.png', isSelected: false.obs),
    DrawerModel(title:"Share App",icon: 'assets/Drawer/share.png',isSelected: false.obs),
    DrawerModel(title:"Rate",icon: 'assets/Drawer/star.png',isSelected: false.obs),
    DrawerModel(title:"Terms & Condition",icon: 'assets/Drawer/terms.png',isSelected: false.obs),
    DrawerModel(title:"Privacy Policy",icon: 'assets/Drawer/privacy.png',isSelected: false.obs),
  ].obs;

  onTapIndex(index) {
    if (index == 0) {
      return navigateToHowToUsePage();
    } else if (index == 1) {
      share();
    } else if (index == 2) {
      return ratingDialog(buildContext!);
    } else if (index == 3) {
      return termsAndConditionOnClick();
    } else if (index == 4) {
      return privacyPolicyOnClick();
    }
  }

  share() {
    if (Platform.isAndroid) {
      FlutterShare.share(
          title: "Share App",
          linkUrl: "Download this App https://play.google.com/store/apps/details?id=com.directmessage.directchat");
    } else if (Platform.isIOS) {
      FlutterShare.share(
        title: 'Share App',
        linkUrl: "Download this App https://apps.apple.com/in/app/id1642282041",
      );
    }
  }

  Future<void> privacyPolicyOnClick() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        final privacyPolicy = prefs.getString('privacy_policy') ?? '';
        if (privacyPolicy.isEmpty && privacyPolicy == '') {
          initializeRemoteConfig();
        } else {
          Get.toNamed(AppRoute.privacyPolicy);
        }
      }
    } on SocketException catch (_) {
      flutterToast(text: "Please check your internet connection");
    }
  }

  Future<void> termsAndConditionOnClick() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        final termsAndCondition = prefs.getString('TermsAndCondition') ?? '';
        if (termsAndCondition.isEmpty && termsAndCondition == '') {
          initializeRemoteConfig();
        } else {
          Get.toNamed(AppRoute.termsAndCondition);
        }
      }
    } on SocketException catch (_) {
      flutterToast(text: "Please check your internet connection");
    }
  }

  onPress(int index) {
   for(var element in drawerList){
     element.isSelected = false.obs;

   } drawerList[index].isSelected = true.obs;
   update();
  }

  showExitPopup()  {
    return  showDialog(
        context: buildContext!,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: textfieldfillColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            content: SizedBox(
              height: 160.0,
              width: MediaQuery.of(context).size.width - 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Exit App',
                      style: TextStyle(
                          fontFamily: 'Inter-Regular',
                          fontSize: 20.0
                      ),
                    ),
                  ),
                  const Text(
                    'Are you sure you want to exit?',
                    style: TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 17.0
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              exit(0);
                            },
                            child: Utils().containerButton('Yes',)
                        ),
                      ),
                      const SizedBox(width: 15.0,),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Utils().containerButton('No',)
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }


}
