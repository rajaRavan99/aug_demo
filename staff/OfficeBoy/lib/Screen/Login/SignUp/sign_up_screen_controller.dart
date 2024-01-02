import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Routes/routes.dart';
import '../../../constData/GlobalVariable/global_varible.dart';
import '../../../constData/Toast/toast.dart';
import '../../../constData/const.dart';
import '../../../constData/sharedPreference/set_data.dart';
import '../../../models/user_data_model.dart';
import 'sign_up_screen.dart';


class SignUpScreenController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference database = FirebaseDatabase.instance.ref().child(type);

  @override
  void onInit() {
    emailController.text = '';
    passwordController.text = '';
    super.onInit();
  }

  // --------------------> Main SignUp Function With User Available or not  <----------------------- //
  Future<void> signUp() async {
    isLoading.value = true;
    DatabaseReference ref = FirebaseDatabase.instance.ref(type);
    DatabaseEvent event = await ref.once();
    if(event.snapshot.value == null){
      sendData(
          name: emailController.text.toString().split('@').first,
          isOnline: false,
          officeTime: false,
          recordId: '',
          email: emailController.text,
          password: passwordController.text,
          deviceToken: deviceToken.value.toString()
      );
      cloudTableFetch(email: emailController.text);
      isLoading.value = false;
      Get.offNamed(AppRoutes.homeScreen);
    }
    Map<dynamic, dynamic> data = event.snapshot.value as dynamic;
    list = data.values.toList();
    print('---list-----> $list');
    var valueData = list?.where((element) => element['email'] == emailController.text.toString() && element['password'] == passwordController.text.toString());
    log('---valueData-----> $valueData');
    if(valueData!.isEmpty)
    {
        sendData(
          name: emailController.text.toString().split('@').first,
          isOnline: false,
          officeTime: false,
          recordId: '',
          email: emailController.text,
          password: passwordController.text,
          deviceToken: deviceToken.value.toString()
      );
      cloudTableFetch(email: emailController.text);
      isLoading.value = false;
      Get.offNamed(AppRoutes.homeScreen);
    }
    else {
      flutterToast(msg: 'User already exist');
      isLoading.value = false;
    }
  }

  // --------------------> Send Data to Table <----------------------- //
  Future<void> sendData ({required String name, required bool isOnline, required bool officeTime, required String email, required  String password, required  String recordId, required String deviceToken})async {
    final UserModel userModel = UserModel(
        officeTime: officeTime,
        name: name,
        about: type,
        dateTime: DateTime.now().toString(),
        lastActive: '',
        isOnline: isOnline,
        recordId: recordId,
        email: email,
        password: password,
        deviceToken: deviceToken);
        String? newkey = database.push().key;
        keyValue.value = newkey ?? '';
        userModel.recordId = newkey;
        // loggedUserList.value.add(LoggedUserModel(recordID: newkey));
        await database.child(newkey ?? '').set(userModel.toJson());
        print('--------newkey-----> $newkey');
        setSharedPreferenceData(emailSet: email, keySet: newkey.toString());
    }

    // --------------------> Cloud Table Fetch <----------------------- //
    Future<void> cloudTableFetch({required String email}) async {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("deviceToken").where('deviceToken', isEqualTo: deviceToken.value).get();

      querySnapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });

      final NotificationToken notificationToken = NotificationToken(
          recordID: 'uId',
          email: email,
          deviceToken: deviceToken.value);
      await  FirebaseFirestore.instance.collection('deviceToken').add(notificationToken.toJson());
    }

}