
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../CommonWidget/Utils.dart';
import '../../../ConstData/colors.dart';

import 'package:direct_message/CommonWidget/Utils.dart';
import 'package:direct_message/CommonWidget/app_colors.dart';
import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'TypeQrListController.dart';

class TypeQrList extends StatelessWidget {
   TypeQrList({Key? key}) : super(key: key);

   TypeQrListController typeQrListController = TypeQrListController();

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
              'Generate QR Code',
              style: FontStyle.textBlack
          ),
          leading: Utils().arrowBackAppBar(),
        ),
        
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [

                const SizedBox(height: 20.0),

                Text('Select QR Code',style: FontStyle.textBlack.copyWith(fontSize: 15),),

                const SizedBox(height: 10.0),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: typeQrListController.modelList.length,
                  itemBuilder: (context, index) {
                    var data = typeQrListController.modelList[index];
                    print(data);
                    return GestureDetector(
                      onTap: () {

                        typeQrListController.navigateToGenerateQrCodePage(
                            typeQrListController.modelList[index].title.toString(),
                            typeQrListController.modelList[index].icon.toString(),
                            typeQrListController.modelList[index].hintText.toString(),
                        );

                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 15),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey,width: 0.5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [

                                Container(
                                  height: 45.0,
                                  width: 45.0,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.blue,
                                    gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        blueColor,
                                        linerSecondColor
                                      ],
                                    ),
                                  ),
                                  child: SvgPicture.asset(data.icon.toString(),color: Colors.white),
                                ),

                                const SizedBox(width: 15.0),

                                Text(data.title.toString(),style: FontStyle.textBlack,),
                              ],
                            ),

                            SvgPicture.asset("assets/qrlistimages/arrowback.svg", height: 18.0),

                          ],
                        ),
                      ),
                    );
                },)
            ],),
          ),
        ),
      ),
    );
  }
}
