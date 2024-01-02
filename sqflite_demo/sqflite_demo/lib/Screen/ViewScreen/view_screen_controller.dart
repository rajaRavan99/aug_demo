import 'package:get/get.dart';

import '../../Model/checkBoxModel.dart';

class ViewScreenController extends GetxController{

  List<CheckBoxModel> getList = Get.find(tag: "tempList");

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

}