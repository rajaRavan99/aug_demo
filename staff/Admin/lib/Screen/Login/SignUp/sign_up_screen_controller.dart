import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebasedemo/Routes/routes.dart';
import 'package:firebasedemo/Screen/Login/SignUp/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../ConstData/Global_Variable/global_variable.dart';
import '../../../ConstData/Toast/toast.dart';
import '../../../ConstData/const.dart';
import '../../../ConstData/sharedPreference/set_data.dart';
import '../../../models/admin_model.dart';

final auth = FirebaseAuth.instance;


class SignUpScreenController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final signUpFormKey = GlobalKey<FormState>();
  DatabaseReference database = FirebaseDatabase.instance.ref().child(type);

  @override
  void onInit() {
    emailController.text = '';
    passwordController.text = '';
    super.onInit();
  }


  Future<void> adminData ({required String recordId, required String email, required String password})async {
    final AdminModel adminModel = AdminModel(
        name: '',
        recordId: recordId,
        email: email,
        password: password,
        deviceToken: deviceToken.value,
        dateTime: DateTime.now().toString());
        String? newkey = database.push().key;
        adminModel.recordId = newkey;
        await database.child(newkey ?? '').set(adminModel.toJson());
        setSharedPreferenceData(setValue: true, emailSet: email);
      }

  Future<void> signUpData() async {
    isLoading.value = true;
    DatabaseReference ref = FirebaseDatabase.instance.ref(type);
    DatabaseEvent event = await ref.once();
    if(event.snapshot.value == null){
      adminData(
        recordId: '',
        email: emailController.text,
        password: passwordController.text,
        // deviceToken: deviceToken.value.toString()
      );
      isLoading.value = false;
      // customData();
      Get.offNamed(AppRoutes.homeScreen);
    }
    Map<dynamic, dynamic> data = event.snapshot.value as dynamic;
    list = data.values.toList();
    var dataasdad = list?.where((element) => element['email'] == emailController.text.toString()
                                                && element['password'] == passwordController.text.toString());

    if(dataasdad!.isEmpty)
    {
      adminData(
        recordId: '',
        email: emailController.text,
        password: passwordController.text,
      );
      Get.offNamed(AppRoutes.homeScreen);
      isLoading.value = false;
    }
    else {
      flutterToast(msg: 'user already exist');
      isLoading.value = false;
    }
    // Do something with the retrieved data
  }



}



