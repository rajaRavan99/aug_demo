
import 'package:direct_message/CommonWidget/flutter_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../Routes/routes.dart';
import '../CustomMessageScreen/select_custom_message_controller.dart';
import '../SqliteDatabase/msg_model.dart';
import '../SqliteDatabase/sqlhelper_msg.dart';


class CreateNewMessageScreenController extends GetxController {
  bool isStatus = Get.find(tag: "sStatus");
  int id = Get.find(tag: "sId");

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController addMsgController = TextEditingController();
  RxList<MsgData> msgData = RxList();

  @override
  void onInit() {
    titleController.text = Get.find(tag: "sTitle");
    subtitleController.text = Get.find(tag: "sSubtitle");
    print('------------->${id}');
    getAll();
    super.onInit();
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    addMsgController.dispose();

    super.dispose();
  }



  getAll() {
    try{
      SqlDatabaseHelper.instance.queryAllRow().then((value) {
        msgData.value = value;
        update();
      });
      update();
    }finally{
    }
  }

  refreshMsg() {
    getAll();
    Get.back();

  }

  Future addData() async {
    await SqlDatabaseHelper.instance.insert(MsgData(
      isSelected: 0,
      title: titleController.text, subtitle: subtitleController.text,

    ));
    refreshMsg();
    update();
    navigationToSelectMessageScreen();

  }

  Future updateData() async {
    print('---------------> ${msgData.value[0]}');
    await SqlDatabaseHelper.instance.update(
      MsgData(
        id: id,
        title: titleController.text,
        subtitle: subtitleController.text,
          isSelected: 0
      ),
    );
    refreshMsg();
    titleController.text = '';
    subtitleController.text = '';
  }

  editMsg() {
    if (isStatus) {
      updateData().then((value) {
        titleController.clear();
        subtitleController.clear();
      });
      flutterToast(text: "Update SuccessFully");
    }
    else {
      if (formKey.currentState!.validate()) {
        addData().then((value) {
          titleController.clear();
          subtitleController.clear();
          SelectCustomMessageController().getAll();

        });
      }
    }

  }


  navigationToSelectMessageScreen() {
    Get.toNamed(AppRoute.customMessageScreen);
  }




}
