
import 'package:direct_message/ConstData/getx_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Routes/routes.dart';
import '../SqliteDatabase/msg_model.dart';
import '../SqliteDatabase/sqlhelper_msg.dart';


class PrivateNoteController extends GetxController {

  // bool isStatus = Get.find(tag: "status");
  RxBool isSelected = false.obs;
  RxBool color = false.obs;

  DateTime now = DateTime.now();
  RxString formattedDate = DateFormat('dd MMM,yyyy').format(DateTime.now()).obs;
  RxString formattedtime = DateFormat('HH-mm a').format(DateTime.now()).obs;

  RxList<NoteModel> noteModel = RxList();
  RxBool loading = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController addMsgController = TextEditingController();
  RxString getMsg = "".obs;

  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      getAll();
    });
    super.onInit();
  }

  getAll() {
    SqlDatabaseHelper.instance.getAllRecords().then((value) {
      noteModel.value = value;
      print('loading.value-----sdsdsdsd-------');
      loading.value = true;
    });
    print('loading.value------------');
  }

  refreshMsg() {
    getAll();
    Get.back();
  }

  Future deleteMsg(int id) async {
    await SqlDatabaseHelper.instance.deleteNote(id);
    getAll();
    update();
  }

  navigateToCreateNote() {
    Get.deleteAndPut(false ,tag: "status");
    Get.deleteAndPut(0 ,tag: "id");
    Get.deleteAndPut('' ,tag: "title");
    Get.deleteAndPut('' ,tag: "description");
    Get.toNamed(AppRoute.createNote)!.then((value){
      getAll();
    });
  }

  navigateToUpdateData({required int id,required String title,required String description,
    }){
    Get.deleteAndPut(true ,tag: "status");
    Get.deleteAndPut(id ,tag: "id");
    Get.deleteAndPut(title ,tag: "title");
    Get.deleteAndPut(description ,tag: "description");
    Get.toNamed(AppRoute.createNote)?.then((value) {
      getAll();
    });
  }

}
