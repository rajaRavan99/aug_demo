import 'package:direct_message/CommonWidget/Utils.dart';
import 'package:direct_message/CommonWidget/app_colors.dart';
import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'privacyPolicyScreenController.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({Key? key}) : super(key: key);

  final PrivacyPolicyScreenController privacyPolicyScreenController = Get.put(PrivacyPolicyScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          centerTitle: true,
          leading: Utils().arrowBackAppBar(),
          title:Text(
            'Privacy Policy',
              style: FontStyle.textBlack.copyWith(fontSize: 18)
          ),
          backgroundColor: whiteColor,
          elevation: 0,
        ),

        body: Stack(
          children: [
            Obx(() => privacyPolicyScreenController.privacyPolicy.value == '' ? const Center(
                child: Text(
                'INTERNET_DISCONNECTED',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
              : WebView(
                  initialUrl: privacyPolicyScreenController.privacyPolicy.value,
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: (finish) {
                    privacyPolicyScreenController.isLoading.value = false;
                  },
                  onWebViewCreated: (WebViewController webViewController) {
                    privacyPolicyScreenController.controller.complete(webViewController);
                  },
                  javascriptChannels: <JavascriptChannel>{
                    privacyPolicyScreenController.toasterJavascriptChannel(context),
                  },
                ),),
            Obx(() => privacyPolicyScreenController.isLoading.value && privacyPolicyScreenController.privacyPolicy != '' ? const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.circularColor,
                          valueColor: AlwaysStoppedAnimation(AppColors.circularColor),
                      ),
              )
              : Container(),),
          ],
        ),
      ),
    );
  }
}
