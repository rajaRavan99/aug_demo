import 'package:direct_message/CommonWidget/flutter_toast.dart';
import 'package:direct_message/Screen/QrGeneratePages/qr_scan_result/qr_scan_result_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:direct_message/ConstData/colors.dart';
import '../../../CommonWidget/Utils.dart';


class QrResult extends StatelessWidget {
  QrResult({Key? key}) : super(key: key);

  QrResultController qrResultController = Get.put(QrResultController());

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
            'QR Result',
            style: TextStyle(
              color: blackColor,fontWeight: FontWeight.w600,
              fontFamily: "Inter-SemiBold",
              fontSize: 15.0,
            ),
          ),

          leading: Utils().arrowBackAppBar(),


        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: GetBuilder(
              init: qrResultController,
              builder: (QrResultController controller) {
                return  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      SizedBox(
                        height: Get.height / 25,
                      ),

                      Container(
                          decoration: BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.circular(11),
                              border: Border.all(color: Colors.grey,width: 0.5)
                          ),
                          child: TextFormField(
                            controller: qrResultController.resultController,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(fillColor: fieldBorder,
                              hintText: 'Example@gmail.com',
                              hintStyle: const TextStyle( color: Colors.grey,fontSize: 12),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: const BorderSide(
                                    width: 1, color: fieldBorder), //<-- SEE HERE
                              ),

                              errorBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(11),
                                borderSide: const BorderSide(
                                    width: 1, color: fieldBorder), //<-- SEE HERE
                              ),

                              focusedBorder:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: const BorderSide(
                                    width: 1, color: fieldBorder), //<-- SEE HERE
                              ),

                              focusedErrorBorder:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: const BorderSide(
                                    width: 1, color: fieldBorder), //<-- SEE HERE
                              ),

                            ),
                          )
                      ),

                      const SizedBox(
                        height: 20.0,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Expanded(
                            child: GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: qrResultController.qrResult.toString()));
                              flutterToast(text: "Copied To ClipBoard");
                            },
                             child: Utils().containerButton('COPY',)
                            ),
                          ),

                          const SizedBox(width: 20,),

                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Share.share(qrResultController.qrResult);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Utils().containerButton('SHARE'),
                              ),
                            ),
                          ),
                        ],
                      )


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
