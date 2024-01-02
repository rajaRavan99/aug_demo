import 'package:get/get.dart';
import 'package:sqflite_demo/Extension/extension.dart';

import '../../Model/checkBoxModel.dart';
import '../../Routes/routes.dart';

class HomeScreenController extends GetxController{

  RxList<CheckBoxModel> tempList = RxList();
  RxString demoString = "".obs;
  RxInt demoInt = 0.obs;
  RxDouble demoDouble = 0.0.obs;
  RxBool isBoolDemo = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    tempList.value = [
      CheckBoxModel(name: "Urmil", isCheck: false.obs),
      CheckBoxModel(name: "Tushar", isCheck: false.obs),
      CheckBoxModel(name: "Gautam", isCheck: false.obs),
      CheckBoxModel(name: "Darshil", isCheck: false.obs),
      CheckBoxModel(name: "Milan", isCheck: false.obs),
      CheckBoxModel(name: "Prashant", isCheck: false.obs),
      CheckBoxModel(name: "Jay", isCheck: false.obs),
      CheckBoxModel(name: "Meet", isCheck: false.obs),
      CheckBoxModel(name: "Yash", isCheck: false.obs),
      CheckBoxModel(name: "Raj", isCheck: false.obs),
    ];

    demoString.value = "ABC";
    demoInt.value = 11;
    demoDouble.value = 1.5;
    isBoolDemo.value = true;

    super.onInit();
  }

  navigateToViewScreen(){
    Get.deleteAndPut(tempList.value, tag: "tempList");
    Get.toNamed(AppRoutes.viewScreen);
  }


}