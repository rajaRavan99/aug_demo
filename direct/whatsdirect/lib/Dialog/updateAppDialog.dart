import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ConstData/colors.dart';

Future<void> updateDialog() {
  return Get.defaultDialog(
    barrierDismissible: false,
    backgroundColor: Get.isDarkMode ? const Color(0xff1b272b) : Colors.white,
    title: '',
    titleStyle: const TextStyle(fontSize: 0),
    contentPadding: EdgeInsets.zero,
    radius: 15.0,
    content: Container(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'There is newer version of this application available, click Update to upgrade now?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter-Regular',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      padding: const EdgeInsets.only(bottom: 7, top: 7),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'No thanks',
                      style: TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 16,
                        color: blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      openApp();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: greenColor1,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        elevation: 0,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 7, top: 7)),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Future<void> openApp() async {
  final packageInfo = await PackageInfo.fromPlatform();
  final package = packageInfo.packageName;
  final _url;
  if (Platform.isAndroid) {
    _url = 'https://play.google.com/store/apps/details?id=$package';
  } else {
    _url = 'https://apps.apple.com/in/app/id1609410868';
  }
  await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}
