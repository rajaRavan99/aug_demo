import 'dart:io';

import 'package:direct_message/Screen/HistoryScreen/history_screen.dart';
import 'package:direct_message/Screen/NewHomeScreen/new_home_screen.dart';
import 'package:direct_message/Screen/ReadCallLogScreen/read_call_log_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Routes/routes.dart';
import '../SettingScreen/setting_screen.dart';

class BottomBarScreenController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxList<Widget> pageList = RxList();

  @override
  void onInit() {
    pageList.value = Platform.isAndroid  ? [
      NewHomeScreen(), ReadCallLogScreen(), HistoryScreen(), SettingScreen()] :
    [NewHomeScreen(),HistoryScreen(),SettingScreen()];
    super.onInit();
  }



  navigateToHowToUsePage() {
    Get.toNamed(AppRoute.howToUseScreen);
  }
}
