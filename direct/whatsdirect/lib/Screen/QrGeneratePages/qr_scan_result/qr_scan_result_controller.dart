import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Routes/routes.dart';

class QrResultController extends GetxController {

  TextEditingController resultController = TextEditingController();

  String qrResult = Get.find(tag: "qrResult");

  @override
  void onInit() {
    print('-----------> ');
    print('-----------> ${qrResult}');
    resultController.text = qrResult.toString();
    super.onInit();
  }


  @override
  void dispose() {
    resultController.dispose();
    super.dispose();
  }

  navigateToQrResult() {
    Get.toNamed(AppRoute.qrResult);
  }

}