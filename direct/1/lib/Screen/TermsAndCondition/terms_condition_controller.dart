import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../ConstData/initializeRemoteConfig.dart';

class TermsAndConditionScreenController extends GetxController {
  RxString termsAndCondition = ''.obs;
  RxBool isLoading = true.obs;
  final Completer<WebViewController> controller =
      Completer<WebViewController>();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    termsAndCondition.value = await prefs.getString('TermsAndCondition') ?? '';
    if (termsAndCondition.isEmpty && termsAndCondition == '') {
      checkNetwork();
    } else {}
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
