
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../CommonWidget/Utils.dart';
import '../../ConstData/colors.dart';

class WhatsappWebScreen extends StatelessWidget {
  const WhatsappWebScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0.0,
          elevation: 0.0,
          backgroundColor: likeWhiteColor,
          leading: Utils().arrowBackAppBar(),
          title: const Text(
            'WhatsApp Web',
            style: TextStyle(
              fontSize: 15.0,
              fontFamily: 'Inter-SemiBold',
              color: blackColor,
            ),
          ),
        ),
        body: const WebView(
          initialUrl: 'https://web.whatsapp.com',
          userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_2_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Safari/605.1.15",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
