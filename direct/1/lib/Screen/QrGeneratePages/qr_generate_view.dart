import 'dart:developer';
import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:screenshot/screenshot.dart';
import '../../CommonWidget/app_colors.dart';
import 'package:direct_message/Screen/QrGeneratePages/qr_generate_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../CommonWidget/Utils.dart';

class QrGenerateView extends StatelessWidget {
  QrGenerateView({Key? key}) : super(key: key);

  QrGenerateViewController qrGenerateViewController = Get.put(QrGenerateViewController());

  @override
  Widget build(BuildContext context) {
    log('-----sadsad------> ${qrGenerateViewController.qrData}');
    var splitString = qrGenerateViewController.qrData.split(' ');
    log('-----splitString------> $splitString');


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          shadowColor: Colors.grey.withOpacity(0.2),
          backgroundColor: likeWhiteColor,
          centerTitle: true,
          title: const Text('Create Code Details', style: FontStyle.textBlack),
          leading: Utils().arrowBackAppBar(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: GetBuilder(
              init: qrGenerateViewController,
              builder: (QrGenerateViewController controller) {
                return SizedBox(
                  width: Get.width,
                  child: Column(
                    children: <Widget>[

                      SizedBox(
                        height: Get.height / 25,
                      ),

                      Container(
                        width: Get.width * 0.45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey, width: 0.5)),
                        child: Row(
                          children: [
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 12.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [blueColor, linerSecondColor],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey, width: 0.5)),
                                child: SvgPicture.asset(
                                    qrGenerateViewController.imageIcon)),
                            const Expanded(child: SizedBox()),

                            Text(
                              qrGenerateViewController.name,
                              textAlign: TextAlign.center,
                              style: FontStyle.textBlack,
                            ),

                            const Expanded(flex: 2, child: SizedBox()),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: Get.height / 25,
                      ),

                      Screenshot(
                        controller: qrGenerateViewController.screenshotController,
                        child: QrImage(
                          size: Get.height / 4,
                          backgroundColor: Colors.white,
                          data: qrGenerateViewController.qrData,
                        ),
                      ),

                      SizedBox(height: Get.height / 20),

                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: greyBorderLight,
                            borderRadius: BorderRadius.circular(11),
                            border: Border.all(
                                color: AppColors.lightWhite, width: 1.0)),
                        child: qrGenerateViewController.qrView(),
                      ),

                      SizedBox(height: Get.height / 8),

                      Builder(builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              // Share.share(qrGenerateViewController.qrData);
                              qrGenerateViewController.shareQrCode();

                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Utils().containerButton('SHARE'),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }


}
