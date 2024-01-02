import 'package:direct_message/CommonWidget/flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Routes/routes.dart';
import '../../SqliteDatabase/msg_model.dart';
import '../../SqliteDatabase/sqlhelper_msg.dart';
import '../private_note_controller.dart';

class CreateNoteController extends GetxController {
  bool isStatus = Get.find(tag: "status");
  int id = Get.find(tag: "id");

  RxList<NoteModel> noteModel = RxList();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  RxString getMsg = "".obs;

  @override
  void onInit() {
     titleController.text = Get.find(tag: "title");
     subtitleController.text = Get.find(tag: "description");
     print('------------->${id}');
     getAll();
    super.onInit();
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }

  getAll() {
    SqlDatabaseHelper.instance.getAllRecords().then((value) {
      noteModel.value = value;
    });
  }

  refreshMsg() {
    getAll();
    Get.back();
  }

  Future addData() async {
    await SqlDatabaseHelper.instance.insertNote(NoteModel(
      title: titleController.text,
      subtitle: subtitleController.text,
    ));
    refreshMsg();
    navigationToPrivateNoteScreen();
  }

  Future updateData() async {
    await SqlDatabaseHelper.instance.updateNote(
      NoteModel(
        id: id,
        title: titleController.text,
        subtitle: subtitleController.text,
      ),
    );
    refreshMsg();
    titleController.text = '';
    subtitleController.text = '';
  }

  editMsg() {
    if (isStatus) {
      updateData().then((value) {
      });
      flutterToast(text: "Update SuccessFully");
    }
    else {
      if (formKey.currentState!.validate()) {
        addData().then((value) {
          titleController.clear();
          subtitleController.clear();
          PrivateNoteController().getAll();

        });
      }
    }

  }

  validatorTitle(String? value) {
    if (value!.isEmpty) {
      return 'Please Enter title';
    }
    return null;
  }

  validatorSubtitle(String? value) {
    if (value!.isEmpty) {
      return 'Please Type Message';
    }
    return null;
  }

  navigateToQrGenerateView() {
    Get.toNamed(AppRoute.qrGenerateView);
  }

  navigationToPrivateNoteScreen() {
    Get.toNamed(AppRoute.privateNote);
  }
}
