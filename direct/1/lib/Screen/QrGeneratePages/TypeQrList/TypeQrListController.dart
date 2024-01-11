


import 'package:direct_message/Extension/getx_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Model/Ui_Model/qr_list_model.dart';
import '../../../Routes/routes.dart';


class TypeQrListController extends GetxController {

  RxString qrData = "No Data Available".obs;

  List<QrListModel> modelList = [
    QrListModel(title:"Text",icon: 'assets/qrlistimages/text.svg',hintText: 'Text:'),
    QrListModel(title:"URL",icon: 'assets/qrlistimages/urlimage.svg',hintText: 'https://'),
    QrListModel(title:"Contact",icon: 'assets/qrlistimages/person.svg',hintText: 'Phone:'),
    QrListModel(title:"Email",icon: 'assets/qrlistimages/mail.svg',hintText: '@gmail.com'),
    QrListModel(title:"SMS",icon: 'assets/qrlistimages/sms.svg',hintText: 'Message:'),
    QrListModel(title:"Geo",icon: 'assets/qrlistimages/location.svg',hintText: 'Latitude:'),
    QrListModel(title:"Phone",icon: 'assets/qrlistimages/phone.svg',hintText: 'Phone'),
    QrListModel(title:"wifi",icon: 'assets/qrlistimages/wifi.svg',hintText: 'UserName:'),
  ];

  final controller = TextEditingController();

  navigateToGenerateQrCodePage(title,icon,hintText) {
    Get.deleteAndPut<String>(title, tag: "titleName");
    Get.deleteAndPut<String>(icon, tag: "imageIcon");
    Get.deleteAndPut<String>(hintText, tag: "hintText");
    Get.toNamed(AppRoute.qrGenerate);
  }

}
