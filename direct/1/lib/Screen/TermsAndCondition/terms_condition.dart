import 'package:direct_message/CommonWidget/Utils.dart';
import 'package:direct_message/CommonWidget/app_colors.dart';
import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:direct_message/Screen/TermsAndCondition/terms_condition_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditionScreen extends StatelessWidget {
  TermsAndConditionScreen({Key? key}) : super(key: key);

  final TermsAndConditionScreenController termsAndConditionScreenController = Get.put(TermsAndConditionScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar
          (
          // automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          title: Text(
            'Terms and Condition',
              style: FontStyle.textBlack.copyWith(fontSize: 18)
          ),
          centerTitle: true,
          leading: Utils().arrowBackAppBar(),
          backgroundColor: whiteColor,
        ),
        body: Stack(
          children: [
            Obx(() => termsAndConditionScreenController.termsAndCondition.value == '' ? const Center(
                child: Text(
                'INTERNET_DISCONNECTED',
                style: TextStyle(
                  fontFamily: 'Inter-Regular',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ))
                : WebView(
                initialUrl: termsAndConditionScreenController
                    .termsAndCondition.value,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  termsAndConditionScreenController.isLoading.value = false;
                },
                onWebViewCreated: (WebViewController webViewController) {
                  termsAndConditionScreenController.controller
                      .complete(webViewController);
                },
                javascriptChannels: <JavascriptChannel>{
                  termsAndConditionScreenController
                      .toasterJavascriptChannel(context),
                },
              )),
            Obx(() => termsAndConditionScreenController.isLoading.value &&
                termsAndConditionScreenController.termsAndCondition != '' ? const Center(
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
