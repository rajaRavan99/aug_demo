import 'dart:async';
import 'dart:io';
import 'package:direct_message/ConstData/initializeRemoteConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreenController extends GetxController {

  RxString privacyPolicy = ''.obs;
  RxBool isLoading = true.obs;
  final Completer<WebViewController> controller = Completer<WebViewController>();

  @override
  Future<void> onInit() async {
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    privacyPolicy.value = await prefs.getString('privacy_policy') ?? '';
    if (privacyPolicy.isEmpty && privacyPolicy == '') {
      checkNetwork();
    }
  }

  JavascriptChannel toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {},
    );
  }

  Future<void> checkNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        initializeRemoteConfig();
      }
    } on SocketException catch (_) {}
  }
}
