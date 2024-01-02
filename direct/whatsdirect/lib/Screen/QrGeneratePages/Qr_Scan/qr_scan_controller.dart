import 'dart:io';
import 'package:direct_message/Extension/getx_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../CommonWidget/Utils.dart';
import '../../../CommonWidget/app_colors.dart';
import '../../../Routes/routes.dart';

class ScanQrController extends GetxController {

  RxString scanBarcode = 'Unknown'.obs;
  String? barcodeScanRes;

  @override
  void onInit() {
    Permission.camera.request();
    super.onInit();
  }

  String result = 'Scanned Data';

  messagePop(BuildContext context, msg, msg2) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width - 200,
            child: AlertDialog(
              insetPadding: const EdgeInsets.all(60.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              content: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      msg.toString(),
                      textAlign: TextAlign.center,
                      // style: tStyle.textBlack,
                    ),
                    Text(
                      msg2.toString(),
                      textAlign: TextAlign.center,
                      // style: tStyle.textBlack,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 42,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.primaryColor,
                              ),
                            ),
                            onPressed: () {

                            },
                            child: const Text("Okay",),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future qrCodeScanner() async{
    var status =  await Permission.camera.request();
    if(Platform.isAndroid || Platform.isIOS){
      if(status.isGranted)
      {
        print('----------> permission Granted');
          barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666',
              'Cancel',
              true,
              ScanMode.QR,);
      print('----------> ${barcodeScanRes}');
        update();
        result = barcodeScanRes.toString();
        if(barcodeScanRes != '-1'){
          navigateToQrResult();
        } else {
          Get.back();
        }
      }
      else if(status.isDenied)
      {
        Permission.camera.request();
      }
      else if(status.isPermanentlyDenied)
      {
        openSettingDialog();
      }
      else {
        print('========> asdad');
      }
      return status;
    }
  }

  openSettingDialog(){
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 10.0),
      title:
      "Permission",
      titleStyle: const TextStyle(
          fontFamily: "Inter-SemiBold",
          fontSize: 17.0
      ),
      radius:5.0,
      contentPadding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
      content:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10.0),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Require Camera Permission",
              style: TextStyle(
                  fontFamily: "Inter-Regular"
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Select Permission -> Enable Permission",
              style: TextStyle(
                  fontFamily: "Inter-Regular"
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Utils().containerButton("CANCEL")
                ),
              ),
              const SizedBox(width: 15.0,),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      openAppSettings();
                      Get.back();
                    },
                    child: Utils().containerButton( "SETTINGS")
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  navigateToQrResult() {
    print("controller.text ----> ${result}");
    Get.deleteAndPut(result, tag: "qrResult");
    Get.toNamed(AppRoute.qrResult);
  }

  navigateTo() {
    Get.toNamed(AppRoute.howToUseScreen);
  }

}
