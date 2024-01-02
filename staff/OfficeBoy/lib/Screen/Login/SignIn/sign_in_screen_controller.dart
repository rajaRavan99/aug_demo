import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../Routes/routes.dart';
import '../../../constData/GlobalVariable/global_varible.dart';
import '../../../constData/Toast/toast.dart';
import '../../../constData/const.dart';
import '../../../constData/sharedPreference/set_data.dart';
import '../../../models/model_for_fetch_cloud_data.dart';
import '../../../models/user_data_model.dart';
import '../SignUp/sign_up_screen.dart';
import '../SignUp/sign_up_screen_controller.dart';

class SignInScreenController extends GetxController{
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List? list = [];
  RxList <CloudModel> tokenList = RxList();
  CloudModel cloudModel = CloudModel();

  @override
  void onInit() {
    emailController.text = '';
    passwordController.text = '';
    super.onInit();
  }

  // --------------------> SignIn Data with check user to Table <----------------------- //
  Future<void> signInFetch() async {
    signInLoader.value = true;
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref(type);
    starCountRef.onValue.listen((DatabaseEvent event) async {
      if(event.snapshot.value == null){
        flutterToast(msg: 'No user found');
      }
      Map<dynamic, dynamic> data = event.snapshot.value as dynamic;
      list = data.values.toList();
      List emailCheck = list!.where((element) => element['email'] == emailController.text.toString()
                                        && element['password'] == passwordController.text.toString()).toList();

      // print('----------emailCheck----->$emailCheck');
      if(emailCheck.isEmpty) {
        flutterToast(msg: 'No user found');
        signInLoader.value = false;
      } else {
        setSharedPreferenceData(emailSet: emailController.text.toString(), keySet: emailCheck[0]['recordID']);
        signInLoader.value = false;
        Get.offNamed(AppRoutes.homeScreen);
      }
    });

  }

}

// -------------------->Check Device tokem are available or not in cloud database <----------------------- //
Future<void> cloudTableFetch({required String email}) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("deviceToken")
      .where('deviceToken', isEqualTo: deviceToken.value).get();

  querySnapshot.docs.forEach((doc) {
    FirebaseFirestore.instance.collection("deviceToken").doc(doc.reference.id).delete();
  });

  final NotificationToken notificationToken = NotificationToken(
      recordID: 'uId',
      email: email,
      deviceToken: deviceToken.value);
  await  FirebaseFirestore.instance.collection('deviceToken').add(notificationToken.toJson());
}

