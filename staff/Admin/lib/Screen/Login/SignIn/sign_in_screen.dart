import 'package:firebasedemo/Routes/routes.dart';
import 'package:firebasedemo/Screen/Login/SignUp/sign_up_screen_controller.dart';
import 'package:firebasedemo/CommonWidget/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebasedemo/CommonWidget/app_colors.dart';
import 'package:get/get.dart';
import 'package:firebasedemo/CommonWidget/textfield.dart';

import '../../../ConstData/GlobalFuncation/global_funcation.dart';
import '../../../ConstData/Global_Variable/global_variable.dart';
import 'sign_in_screen_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  SignInScreenController signInScreenController = Get.put(SignInScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: signInScreenController.form,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children:  [

                SizedBox(height: Get.height * 0.30),

                Text('Admin',
                  style: FontStyle.textBlack.copyWith(fontSize: 25,),),

                const SizedBox(height: 10,),

                TextFormField(
                  controller: signInScreenController.emailController,
                  decoration: Utils.inputDecoration('Name'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name can not be empty";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10,),

                TextFormField(
                  controller: signInScreenController.passwordController,
                  decoration: Utils.inputDecoration('Password'),
                  // obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password can not be empty";
                    } else if (value.length < 6 || value.contains(' ')) {
                      return "Password length sould be atleast 6 (space Not Avalible)";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10,),

                Row(
                  children: [

                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if(signInScreenController.form.currentState!.validate()){
                            // signInScreenController.signIn().then((value) {
                            //   if(msgData.isEmpty)
                            //   {
                            //     customData();
                            //   }
                            // });
                            signInScreenController.signInData().then((value) {
                                customData();
                            });
                          }
                        },
                        child: Obx(() => Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: Get.height / 15,
                            decoration: Utils().containerDecoration(),
                            child: Center(
                                child: signInLoader.value == true
                                    ? const CircularProgressIndicator(color: AppColors.white_00,)
                                    : const Text('Sign In',
                                  style: FontStyle.textHeaderWhite,
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't Have an Account ? ",style: FontStyle.buttonBoldBlack.copyWith(fontSize: 12),),

                    GestureDetector(
                        onTap: () {
                          signInScreenController.emailController.text = '';
                          signInScreenController.passwordController.text = '';
                          signInLoader.value = false;
                          Get.toNamed(AppRoutes.signUpScreen);
                        },
                        child: SizedBox(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Sign Up",style: FontStyle.buttonBoldBlack.copyWith(fontSize: 13,color: AppColors.primaryColor),),
                        ))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }



  // Future signup() async {
  //   const Center(child: SpinKitThreeBounce(color: AppColors.primaryColor,size: 25),);
  //   print('-------------------------------->');
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: loginPageController.emailController.text,
  //       password: loginPageController.passwordController.text,
  //     );
  //     Get.snackbar(
  //       "Register SuccessFul",
  //       "",
  //       backgroundColor: AppColors.white_00,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     Get.off(HomeScreen());
  //
  //   } on FirebaseAuthException catch (e) {
  //     print('------------SignUpError------> ${e}');
  //
  //   }
  //
  //   const Center(child: SpinKitThreeBounce(color: AppColors.primaryColor,size: 25),);
  // }
}