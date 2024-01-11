import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../Routes/routes.dart';

class QrGenerateViewController extends GetxController {

  final key = GlobalKey<FormState>();

  String qrData = Get.find(tag: "qrText");
  String name = Get.find(tag: "titleName");
  String imageIcon = Get.find(tag: "imageIcon");

  ScreenshotController screenshotController = ScreenshotController();
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  void onInit() {
    print('-----------> ${qrData}');
    super.onInit();
  }

  navigateTo() {
    Get.toNamed(AppRoute.howToUseScreen);
  }

  qrView() {
    log('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-> ${ qrData}');
    switch( name){

      case'Text' : return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Text: ${ qrData.split(' ')[0]}',style: FontStyle.textBlack,),
        ],);

      case'URL' : return Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('URL: ${ qrData.split(' ')[0]}',style: FontStyle.textBlack,),

        ],);

      case'Contact' : return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FullName: ${ qrData.split(' ')[0]}',style: FontStyle.textBlack,),
          Text('Address: ${ qrData.split(' ')[1]}',style: FontStyle.textBlack,),
          Text('Phone: ${ qrData.split(' ')[2]}',style: FontStyle.textBlack,),
          Text('Email: ${ qrData.split(' ')[3]}',style: FontStyle.textBlack,),
          Text('Note: ${ qrData.split(' ')[4]}',style: FontStyle.textBlack,),
        ],);

      case'Email' : return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email: ${ qrData.split(' ')[0]}',style: FontStyle.textBlack,),
          Text('Subject: ${ qrData.split(' ')[1]}',style: FontStyle.textBlack,),
          Text('Body: ${qrData.split(' ')[2]}',style: FontStyle.textBlack,),
        ],);

      case'SMS' : return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Phone: ${qrData.split(' ')[0]}',style: FontStyle.textBlack,),
          Text('Message: ${qrData.split(' ')[1]}',style: FontStyle.textBlack,),
        ],);

      case'Geo' : return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Latitude: ${qrData.split(' ')[0]}',style: FontStyle.textBlack,),
          Text('Longitude: ${qrData.split(' ')[1]}',style: FontStyle.textBlack,),
        ],);

      case'Phone' : return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Phone: ${qrData.split(' ')[0]}',style: FontStyle.textBlack,),
        ],);

      case'wifi' : return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SSID/Network Name: ${qrData.split(' ')[0]}',style: FontStyle.textBlack,),
          Text('Password: ${qrData.split(' ')[1]}',style: FontStyle.textBlack,),
        ],);


    }
  }

  Future<void> shareQrCode() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        try {
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          final imagePath = await File('$directory/$fileName.jpg').create();
          if (imagePath != null) {
            await imagePath.writeAsBytes(image);
            Share.shareXFiles([XFile(imagePath.path)]);
          }
        } catch (error) {}
      }
    }).catchError((onError) {
      print('Error --->> $onError');
    });
  }

}
