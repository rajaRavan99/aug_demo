import 'package:direct_message/Screen/QrGeneratePages/Qr_Scan/qr_scan_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CommonWidget/Utils.dart';
import '../../../CommonWidget/textfield.dart';
import '../../../ConstData/colors.dart';

class QrScan extends StatelessWidget {
  QrScan({Key? key}) : super(key: key);

  ScanQrController scanQrController = ScanQrController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          shadowColor: Colors.grey.withOpacity(0.2),
          backgroundColor: likeWhiteColor,
          centerTitle: true,
          title: const Text(
            'QR Scanner',
            style: TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w600,
              fontFamily: "Inter-SemiBold",
              fontSize: 15.0,
            ),
          ),
          leading: Utils().arrowBackAppBar(),
        ),

        body: Center(
          child: GetBuilder(
            init: ScanQrController(),
            builder: (ScanQrController controller) {
              return Column(

                children: <Widget>[
                  SizedBox(
                    height: Get.height / 6,
                  ),

                  Image.asset(
                    'assets/scanqr.png',
                    height: Get.height / 2.8,
                    width: Get.width * 0.90,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    'No saved QR Code',
                    style: FontStyle.textLabelWhite
                        .copyWith(color: greyText2, fontSize: 14),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: GestureDetector(
                        onTap: () {
                          scanQrController.qrCodeScanner();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Utils().containerButton('OPEN QR SCANNER'),
                        )),
                  ),
                ],
              );
            },
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
