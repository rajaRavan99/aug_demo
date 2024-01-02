import 'package:firebase_database/firebase_database.dart';
import 'package:firebasedemo/Routes/routes.dart';
import 'package:firebasedemo/Screen/Login/SignUp/sign_up_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../ConstData/Global_Variable/global_variable.dart';
import '../../../ConstData/Toast/toast.dart';
import '../../../ConstData/const.dart';
import '../../../ConstData/sharedPreference/set_data.dart';

class SignInScreenController extends GetxController{

  final form = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    emailController.text = '';
    passwordController.text = '';
    super.onInit();
  }

  // --------------------> SignIn Data with check user to Table <----------------------- //
  Future<void> signInData() async {
    signInLoader.value = true;
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref(type);
    starCountRef.onValue.listen((DatabaseEvent event) async {
      if(event.snapshot.value == null){
        flutterToast(msg: 'No user found');
      }
      Map<dynamic, dynamic> data = event.snapshot.value as dynamic;
      list = data.values.toList();
      var dataasdad = list?.where((element) => element['email'] == emailController.text.toString()
                                      && element['password'] == passwordController.text.toString());
      print('----snapshot.value---->$dataasdad ');
      if(dataasdad!.isEmpty)
      {
        flutterToast(msg: 'No user found');
        signInLoader.value = false;
      }else {
        Get.offNamed(AppRoutes.homeScreen);
        signInLoader.value = false;
        setSharedPreferenceData(setValue: true, emailSet: emailController.text.toString());

      }
    });
  }
}