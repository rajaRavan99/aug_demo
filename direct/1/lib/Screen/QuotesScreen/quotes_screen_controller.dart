import 'dart:async';
import 'dart:io';
import 'package:direct_message/CommonWidget/flutter_toast.dart';
import 'package:direct_message/ConstData/initializeRemoteConfig.dart';
import 'package:direct_message/Extension/getx_extension.dart';
import 'package:direct_message/Model/quotes_api_model.dart';
import 'package:direct_message/NetworkService/network_service.dart';
import 'package:direct_message/Popupmenu/popupmenu_item.dart';
import 'package:direct_message/Popupmenu/popupmenu_model.dart';
import 'package:direct_message/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuotesScreenController extends GetxController{

  RxList quotesList = [].obs;
  BuildContext? buildContext;
  RxBool isLoad = false.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void onSelected(BuildContext context, MenuItems items) {
    switch (items) {
      case MenuItemData.itemUse:
        navigateToHowToUseScreen();
        break;

      case MenuItemData.itemShare:
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
        break;

      case MenuItemData.itemTerms:
        termsAndConditionOnClick();
        break;

      case MenuItemData.itemPrivacy:
        privacyPolicyOnClick();
        break;
    }
  }

  PopupMenuItem<MenuItems> buildItem(MenuItems items) => PopupMenuItem(value: items, child: Text(items.text));

  navigateToHowToUseScreen() {
    Get.toNamed(AppRoute.howToUseScreen);
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


  var productList = <Datum>[];
  static var listofdata = <Datum>[];

  void fetchData() async {

    var quotesLists = await NetWorkService.fetchData();
    print('=============> ${quotesLists}');
    if (quotesLists != null) {
      quotesList.value = quotesLists;
    }
  }

  navigatorToQuotesViewScreen({image}){
    Get.deleteAndPut<String>(image, tag: "imageLink");
    Get.toNamed(AppRoute.quotesViewScreen);
  }

}
