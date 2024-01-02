import 'dart:io';
import 'package:country_pickers/utils/utils.dart';
import 'package:direct_message/CommonWidget/Utils.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:direct_message/ConstData/initializeRemoteConfig.dart';
import 'package:direct_message/ConstData/rating_dialog.dart';
import 'package:direct_message/ConstData/static_data.dart';
import 'package:direct_message/Dialog/updateAppDialog.dart';
import 'package:direct_message/Popupmenu/popupmenu_item.dart';
import 'package:direct_message/Popupmenu/popupmenu_model.dart';
import 'package:direct_message/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../CommonWidget/flutter_toast.dart';
import '../../Model/Ui_Model/home_page_model.dart';
import '../DirectMessageScreen/Direct_message_screen_controller.dart';
import '../RemiderScreen/create_reminder_controller.dart';

class NewHomeScreenController extends GetxController {

  RxBool addNumber = false.obs;
  RxBool quickMessage = false.obs;
  RxBool whatsappWeb = false.obs;
  RxInt counter = 0.obs;
  RxInt counterHowToUse = 0.obs;
  RxString selectValue = "".obs;
  BuildContext? buildContext;
  RxList<String> title = RxList();
  RxList<String> subTitle = RxList();
  RxList<String> icon = RxList();
  RxString getMsg = "".obs;
  RxList<bool>  isSelected = List.generate(8, (index) => false).obs;

  List<HomePageModel> homeList = [
    HomePageModel(title:"Direct\nMessage",
        icon: 'assets/HomePage/direct_message_icon.png',
        background: 'assets/HomePage/direct_message_bg.png'),

    HomePageModel(title:"Quick\nMessage",
        icon: 'assets/HomePage/quick_message_icon.png',
        background: 'assets/HomePage/quick_message_bg.png'),

    HomePageModel(title:"Reminder\nMessage",
        icon: 'assets/HomePage/reminder_message_icon.png'
        ,background: 'assets/HomePage/reminder_message_bg.png'),

    HomePageModel(title:"WhatsApp\nWeb",
        icon: 'assets/HomePage/whatsapp_message_icon.png',
        background: 'assets/HomePage/whatsapp_message_bg.png'),

    HomePageModel(title:"Private\nNote",
        icon: 'assets/HomePage/private_message_icon.png',
        background: 'assets/HomePage/private_note_message_bg.png'),

    HomePageModel(title:"Quotes",
        icon: 'assets/HomePage/quotes_message_icon.png',
        background: 'assets/HomePage/quotes_message_bg.png'),

    HomePageModel(title:"QR\nGenerator",
        icon: 'assets/HomePage/qr_generate_icon.png',
        background: 'assets/HomePage/generate_qr_bg.png'),

    HomePageModel(title:"QR\nScanner",
        icon: 'assets/HomePage/qr_scan_icon.png',
        background: 'assets/HomePage/scan_qr_bg.png'),
  ];


  @override
  void onInit() {
    getIosDirectory();
    if (isTemp.value == true) {
      getMsg.value = Get.find<String>(tag:'msgCustom');
      isTemp.value = false;
    } else {
      getBoolStoreOpen();
      incrementStartup();
    }
    super.onInit();
  }

  navigateToHowToUsePage() {
    Get.toNamed(AppRoute.howToUseScreen);
  }




  Future<void> getIosDirectory() async {
    await getApplicationDocumentsDirectory().then((value) {
       iosDirectory = Directory(value.path);
       print("iosDirectory -------> ${iosDirectory}");
     });
  }

  Future<int> _getIntFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final startupNumber = prefs.getInt('startupNumber');
    if (startupNumber == null) {
      return 0;
    }
    return startupNumber;
  }

  Future incrementStartup() async {
    final InAppReview inAppReview = InAppReview.instance;
    final prefs = await SharedPreferences.getInstance();
    var lastStartupNumber = await _getIntFromSharedPref();
    var currentStartupNumber = ++lastStartupNumber;
    await prefs.setInt('startupNumber', currentStartupNumber);
    counter.value = currentStartupNumber;
    if (counter.value >= 3) {
      playStoreOpen.value == true ? checkAppUpdate() : Platform.isAndroid ?
                          ratingDialog(buildContext!) : Future.delayed(const
                                              Duration(seconds: 3)).then((value) => inAppReview.requestReview());
    } else {
      checkAppUpdate();
    }
  }

  checkAppUpdate() async {

    final requiredBuildNumber;
    final prefs = await SharedPreferences.getInstance();

    if (Platform.isAndroid) {
      requiredBuildNumber = await prefs.getString('requiredBuildNumberAndroid') ?? '';
    } else {
      requiredBuildNumber = await prefs.getString('requiredBuildNumberIos') ?? '';
    }

    if (requiredBuildNumber.isNotEmpty && requiredBuildNumber != '') {
      openDialog(requiredBuildNumber);
    }
  }

  Future<void> openDialog(String buildNumber) async {
    if (buildNumber.isNotEmpty && buildNumber != '') {
      final packageInfo = await PackageInfo.fromPlatform();
      if (int.parse(packageInfo.buildNumber.toString()) < int.parse(buildNumber.toString())) {
          updateDialog();
      }
    }
  }

  Future<void> privacyPolicyOnClick() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        final privacyPolicy = await prefs.getString('privacy_policy') ?? '';
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
        final termsAndCondition = await prefs.getString('TermsAndCondition') ?? '';
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

  navigateToReminderUser() {
    Get.toNamed(AppRoute.remindUser)?.then((value){
      CreateReminderController().getAll();
    });
  }

  navigateToHowToUseScreen() {
    Get.toNamed(AppRoute.howToUseScreen);
  }

  navigateToHistoryScreen() {
    Get.toNamed(AppRoute.historyScreen);
  }

  navigationToHomeScreen() {
    addPhoneController.clear();
    addMsgController.clear();
    phoneNumber.value = CountryPickerUtils.getCountryByPhoneCode('91');
    addNumber.value = !addNumber.value;
    Get.toNamed(AppRoute.homeScreen);
  }

  navigationToCustomMessageScreen() {
    quickMessage.value = !quickMessage.value;
    Get.toNamed(AppRoute.customMessageScreen);
  }

  navigateToWhatsappWebScreen() {
    Get.toNamed(AppRoute.whatsappWebScreen);
  }

  navigateToQrGenerate() {
    Get.toNamed(AppRoute.qrGenerate);
  }

  navigateToPrivateNote() {
    Get.toNamed(AppRoute.privateNote);
  }

  navigateToQuotesScreen() {
    Get.toNamed(AppRoute.quotesScreen);
  }


  navigateToQrGenerateView() {
    Get.toNamed(AppRoute.qrGenerateView);
  }

  navigateToCustomMessageScreen() {
    Get.toNamed(AppRoute.customMessageScreen);
  }

  navigateToScanQr() {
    Get.toNamed(AppRoute.scanQr);
  }

  navigateToTypeQrList() {
    Get.toNamed(AppRoute.typeQrList);
  }



  onTapIndex(index) {
    if (index == 0) {
      return navigationToHomeScreen();
    } else if (index == 1) {
      return navigationToCustomMessageScreen();
    } else if (index == 2) {
      return navigateToReminderUser();
    } else if (index == 3) {
      return navigateToWhatsappWebScreen();
    } else if (index == 4) {
      return navigateToPrivateNote();
    } else if (index == 5) {
      return navigateToQuotesScreen();
    } else if (index == 6) {
      return navigateToTypeQrList();
    } else if (index == 7) {
      return navigateToScanQr();
    }
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

  showExitPopup(){
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
