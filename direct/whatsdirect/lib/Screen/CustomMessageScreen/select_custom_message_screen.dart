import 'package:direct_message/CommonWidget/app_colors.dart';
import 'package:direct_message/CommonWidget/flutter_toast.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:direct_message/ConstData/getx_extension.dart';
import 'package:direct_message/ConstData/static_data.dart';
import 'package:direct_message/Screen/CustomMessageScreen/select_custom_message_controller.dart';
import 'package:direct_message/Screen/SqliteDatabase/msg_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:direct_message/CommonWidget/textfield.dart';

import '../../CommonWidget/Utils.dart';

class CustomMessageScreen extends StatelessWidget {
  CustomMessageScreen({Key? key}) : super(key: key);

  // final DirectMessageScreenController homeScreenController = Get.put(DirectMessageScreenController());

  final SelectCustomMessageController selectCustomMessageController = Get.put(SelectCustomMessageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          shadowColor: Colors.grey.withOpacity(0.2),
          backgroundColor: likeWhiteColor,
          centerTitle: true,
          titleSpacing: 0.0,
          leading: Utils().arrowBackAppBar(),
          title: Text('Custom Message',
              style: FontStyle.textBlack.copyWith(fontSize: 15)),
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5.0),
              GestureDetector(
                  onTap: () {
                    selectCustomMessageController.navigationToNewMsgScreen();
                  },
                  child: Utils().containerButton('Create New', isIcon: true)),
              const SizedBox(height: 5.0),
            ],
          ),
        ),
        body: SafeArea(
          child: GetBuilder(
              init: selectCustomMessageController,
              builder: (controller) => !selectCustomMessageController
                      .loading.value
                  ? selectCustomMessageController.msgData.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: selectCustomMessageController.msgData.length,
                          itemBuilder: (context, index) {
                            var data = selectCustomMessageController.msgData[index];
                            print('---tap------${data.isSelected}');
                            print('---tap------${data.title}');
                            print('---tap------${data.subtitle}');
                            print('---tap------${data.id}');
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  top: 20.0,
                                  bottom: 0.0),
                              child: Card(
                                elevation: 0.0,
                                color: textfieldfillColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: GestureDetector(
                                    onTap: () {

                                      if (!isTemp.value) {
                                        addMsgController.text = selectCustomMessageController.msgData[index].subtitle.toString();
                                        selectCustomMessageController.update();
                                        Get.back();
                                      }
                                      Get.deleteAndPut(selectCustomMessageController.msgData[index].subtitle.toString(), tag: 'msgCustom');
                                      selectCustomMessageController.backToHomeScreen();
                                      selectCustomMessageController.onPress(index);
                                      print('-----------------> ${data.isSelected}');

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(
                                              width: 1,
                                              color: data.isSelected == 0 ? greyBorderLight : blueColor
                                              ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 10),
                                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                                            child: Image.asset(
                                              data.isSelected == 0 ? 'assets/CustomMessage/blank.png' : 'assets/CustomMessage/true_combo.png',
                                              width: 20,
                                            ),
                                          ),

                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      selectCustomMessageController.msgData[index].title,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: FontStyle.blackLightText),

                                                  const SizedBox(
                                                    height: 10,
                                                  ),

                                                  Text(
                                                    selectCustomMessageController.msgData[index].subtitle,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: FontStyle.textLabelGrey.copyWith(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 20),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    print('--------update---------> ${data.isSelected}');
                                                    selectCustomMessageController.navigateToUpdateData(
                                                            sId: data.id ?? 0,
                                                            sTitle: data.title,
                                                            sSubtitle:
                                                                data.subtitle);
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 5),
                                                    child: SvgPicture.asset(
                                                      'assets/reminderScreen/remindersvg.svg',
                                                      width: 20,
                                                    ),
                                                  ),
                                                ),

                                                // const SizedBox(width: 10,),

                                                GestureDetector(
                                                  onTap: () {
                                                    selectCustomMessageController
                                                        .deleteMsg(data.id!);
                                                    flutterToast(
                                                        text:
                                                            "Successfully Deleted");
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.only(top: 20,bottom: 20,left: 15,right: 20),
                                                    child: SvgPicture.asset(
                                                        'assets/delete.svg',
                                                        width: 22),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 70.0,vertical: 20
                                ),
                                child: Image.asset(
                                  "assets/CustomMessage/noMessage.png",
                                ),
                              ),

                              const Text(
                                'Message Not Found',
                                style: TextStyle(
                                  color: emptyColor,
                                  fontSize: 18,
                                  fontFamily: "Inter-Regular",
                                ),
                              ),
                            ],
                          ),
                        )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.circularColor,
                      ),
                    )),
        ),
      ),
    );
  }
}
