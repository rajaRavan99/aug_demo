import 'package:direct_message/Extension/getx_extension.dart';
import 'package:direct_message/Routes/routes.dart';
import 'package:direct_message/Screen/SqliteDatabase/msg_model.dart';
import 'package:direct_message/Screen/SqliteDatabase/sqlhelper_msg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ConstData/static_data.dart';

class SelectCustomMessageController extends GetxController {

  RxList<MsgData> msgData = RxList();
  RxBool loading = true.obs;
  RxString getMsg = "".obs;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController addMsgController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    addMsgController.dispose();
    super.dispose();
  }



  @override
  void onInit() {
    if(addMsgController.text.isNotEmpty){
      addMsgController.clear();
    }

    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      getAll();
    });
    super.onInit();
  }

  getAll() {
    SqlDatabaseHelper.instance.queryAllRow().then((value) {
      msgData.value = value;
      loading.value = false;
      update();
    });
  }

  refreshMsg() {
    getAll();
    Get.back();
  }

   onPress(int index) {
    for(var element in msgData){
      element.isSelected = 0;
    } msgData[index].isSelected = 1;
    update();
   }


  Future deleteMsg(int id) async {
    await SqlDatabaseHelper.instance.delete(id);
    getAll();
  }

  backToHomeScreen() {
    Get.toNamed(AppRoute.homeScreen);
  }

  navigationToNewMsgScreen() {
    Get.deleteAndPut(false ,tag: "sStatus");
    Get.deleteAndPut(0 , tag: "sId");
    Get.deleteAndPut('' , tag: "sTitle");
    Get.deleteAndPut('' , tag: "sSubtitle");
    Get.toNamed(AppRoute.createNewMessageScreen)!.then((value){
      getAll();
    });
  }

  navigateToUpdateData({required int sId,required String sTitle,required String sSubtitle,
  }){
    Get.deleteAndPut(true ,tag: "sStatus");
    Get.deleteAndPut(sId ,tag: "sId");
    Get.deleteAndPut(sTitle ,tag: "sTitle");
    Get.deleteAndPut(sSubtitle ,tag: "sSubtitle");
    Get.toNamed(AppRoute.createNewMessageScreen)?.then((value) {
      getAll();
    });
  }


  navigationToSelectMessageScreen() {
    Get.toNamed(AppRoute.customMessageScreen);
  }

  navigationToEditMsgScreen(MsgData msgData) {
    titleController.text = msgData.title;
    subtitleController.text = msgData.subtitle;
    Get.toNamed(AppRoute.createNewMessageScreen, arguments: msgData.id);
  }
}