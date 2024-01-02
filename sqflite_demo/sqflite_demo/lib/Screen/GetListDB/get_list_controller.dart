import 'package:get/get.dart';
import 'package:sqflite_demo/DbHelper/DBHelper.dart';
import 'package:sqflite_demo/Extension/extension.dart';
import '../../Model/user.dart';
import '../../Routes/routes.dart';

class   GetListController extends GetxController{

  var isLoading = true.obs;
  RxList<User> getValue = RxList();

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  navigateToAddData({required String name, required String email, required String phone, required String address,
    // required String age,required String gender,
    required int id}) {
    Get.deleteAndPut(true ,tag: "status");
    Get.deleteAndPut(name ,tag: "name");
    Get.deleteAndPut(email ,tag: "email");
    Get.deleteAndPut(phone ,tag: "phone");
    Get.deleteAndPut(address ,tag: "address");
    // Get.deleteAndPut(age ,tag: "age");
    // Get.deleteAndPut(gender ,tag: "gender");
    Get.deleteAndPut(id ,tag: "id");
    Get.toNamed(AppRoutes.addData)?.then((value) {
      getData();
    });
  }

  getData(){
    isLoading.value = true;
    try{
      DBHelper().getAllRecords().then((value) {
        getValue.value = value;
      });
    }finally{
      isLoading.value = false;
    }
  }

  deleteData(int id){
    DBHelper.deleteData(id).then((value) {
      getData();
    });
  }

  addDataScreen(){
    Get.deleteAndPut(false ,tag: "status");
    Get.deleteAndPut("" ,tag: "name");
    Get.deleteAndPut("" ,tag: "email");
    Get.deleteAndPut("" ,tag: "phone");
    Get.deleteAndPut("" ,tag: "address");
    // Get.deleteAndPut("" ,tag: "age");
    // Get.deleteAndPut("" ,tag: "gender");

    Get.deleteAndPut(0 , tag: "id");
    Get.toNamed(AppRoutes.addData)?.then((value){
      getData();
    });
  }
}