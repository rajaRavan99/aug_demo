import 'dart:io';
import 'package:dio/dio.dart';
import 'package:direct_message/CommonWidget/Utils.dart';
import 'package:direct_message/CommonWidget/flutter_toast.dart';
import 'package:direct_message/ConstData/static_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class QuotesViewScreenController extends GetxController{

  RxBool isSaved = false.obs;
  RxDouble downloadCount = 0.0.obs;
  String imageLink = Get.find(tag: "imageLink");
  RxBool isBackButton = false.obs;

  permissionHandler() async {
    if(await Permission.storage.status.isDenied){
      var status =  await Permission.storage.request();
      if(status.isGranted){
        downloadImage(imageLink);
      } else if(status.isPermanentlyDenied){
        openDialog();
      }
    } else if(await Permission.storage.status.isGranted){
      downloadImage(imageLink);
    }
  }

  downloadImage(image) async {
    EasyLoading.show(status: "Image\nDownloading", maskType: EasyLoadingMaskType.black);
    final dir;
    if(Platform.isAndroid){
      dir = Directory('/storage/emulated/0/Download');
    } else{
      dir = iosDirectory;
    }
    String fileLink = image;
    String downloadImageTime = DateFormat("msssmmhhddMMyyyy").format(DateTime.now());
    String savePath = dir.path + "/$downloadImageTime.jpg";
    var dio = Dio();
    await dio.download(
      fileLink,
      savePath,
      onReceiveProgress: (count, total) {
        isBackButton.value = true;
        downloadCount.value = double.parse((count / total * 100).toStringAsFixed(0));
        if(downloadCount.value == 100.0){
          EasyLoading.dismiss();
          isBackButton.value = false;
        }
      },
    ).catchError((onError) {
      debugPrint('Error downloading: $onError');
    }).then((imagePath) {
      flutterToast(text: "Image Saved");
      debugPrint('Download successful, path: $imagePath');
    });
  }

  openDialog(){
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
              "Require Photos Permission",
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

  shareImage(context) async {
    final RenderBox box = context.findRenderObject();
    isBackButton.value = true;
    EasyLoading.show(status: "Please Wait...", maskType: EasyLoadingMaskType.black,);
    var url = imageLink;
    var response = await get(Uri.parse(url));
    final documentDirectory = Platform.isAndroid ? (await getExternalStorageDirectory())!.path : (await getApplicationDocumentsDirectory()).path;
    File imgFile = File('$documentDirectory/quotes.jpg');
    imgFile.writeAsBytesSync(response.bodyBytes);
    Share.shareFiles(
        ['$documentDirectory/quotes.jpg'],
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
    );
    EasyLoading.dismiss();
    isBackButton.value = false;
  }

}
