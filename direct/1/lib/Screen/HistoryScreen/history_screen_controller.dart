import 'dart:io';
import '../../CommonWidget/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../CommonWidget/flutter_toast.dart';
import '../../ConstData/colors.dart';
import '../../ConstData/static_data.dart';
import '../../Routes/routes.dart';

class HistoryScreenController extends GetxController {

  BuildContext? buildContext;

  openWhatsappAddNumber({whatsapp}) async {
    var msg = addMsgController.text;
    var whatsappURlAndroid = Uri.parse("whatsapp://send?phone=${whatsapp.replaceAll(" ", "")}&text=$msg");
    var whatsappURLIos = "https://wa.me/$whatsapp?text=$msg";
    var encoded = Uri.encodeFull(whatsappURLIos);
    if (Platform.isIOS) {
      if (await canLaunch(encoded)) {
        await launch(encoded, forceSafariVC: false);
      } else {
        flutterToast(text: "Whatsapp Not Installed");
      }
    } else {
      if (await canLaunchUrl(whatsappURlAndroid)) {
        await launchUrl(whatsappURlAndroid, mode: LaunchMode.externalApplication);
      } else {
        flutterToast(text: "Whatsapp Not Installed");
      }
    }
  }

  navigateToSettingsScreen() {
    Get.toNamed(AppRoute.settingsScreen);
  }

  navigateToCustomMessageScreen() {
    Get.toNamed(AppRoute.customMessageScreen);
  }

  PopupMenuItem buildPopupMenuItem(String title, Function ontap) {
    return PopupMenuItem(
      child: Text(title),
    );
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
