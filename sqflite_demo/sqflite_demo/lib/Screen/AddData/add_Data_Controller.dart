import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../DbHelper/DBHelper.dart';
import '../../Model/user.dart';
import '../../Routes/routes.dart';
import '../GetListDB/get_list_controller.dart';

class AddDataController extends GetxController {
  bool isStatus = Get.find(tag: "status");
  int id = Get.find(tag: "id");
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController mobileController = TextEditingController(text: '');
  TextEditingController homeAddressController = TextEditingController(text: '');
  // TextEditingController ageController = TextEditingController(text: '');
  // TextEditingController genderController = TextEditingController(text: '');

  final formKey = GlobalKey<FormState>();
  User user = User();

  @override
  void onInit() {
    nameController.text = Get.find(tag: "name");
    emailController.text = Get.find(tag: "email");
    mobileController.text = Get.find(tag: "phone");
    homeAddressController.text = Get.find(tag: "address");
    // ageController.text = Get.find(tag: "age");
    // genderController.text = Get.find(tag: "gender");
    super.onInit();
  }

  sendData() {
    if (isStatus) {
      DBHelper.updateData(
              id,
              nameController.text,
              mobileController.text,
              emailController.text,
              homeAddressController.text,
              // ageController.text,
              // genderController.text,

      )
          .then((value) {
        navigateToGetListD();
        Get.back();
      });
    } else {
      DBHelper.insertData(User(
        name: nameController.text,
        mobile: mobileController.text,
        email: emailController.text,
        address: homeAddressController.text,
        // age: ageController.text,
        // gender: genderController.text,

      )).then((value) {
        GetListController().getData();
        Get.back();
      });
    }
  }

  navigateToGetList() {
    Get.toNamed(AppRoutes.getList);
  }

  navigateToGetListD() {
    Get.off(() => AppRoutes.getList);
  }
}
