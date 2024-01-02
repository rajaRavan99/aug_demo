import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebasedemo/CommonWidget/app_colors.dart';
import 'package:get/get.dart';
import 'package:firebasedemo/CommonWidget/textfield.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../CommonWidget/Utils.dart';
import '../../../ConstData/GlobalFuncation/global_funcation.dart';
import '../../../ConstData/Global_Variable/global_variable.dart';
import 'sign_up_screen_controller.dart';


RxString deviceToken = ''.obs;

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);


  SignUpScreenController signUpScreenController = SignUpScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: Form(
        key: signUpScreenController.signUpFormKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children:  [

                SizedBox(height: Get.height * 0.30),

                // Image.asset(
                //   'assets/images/Login.png',
                //   width: Get.width * 0.90,),

                Text('Admin',
                  style: FontStyle.textBlack.copyWith(fontSize: 25,),),

                const SizedBox(height: 10,),

                TextFormField(
                  controller: signUpScreenController.emailController,
                  decoration: Utils.inputDecoration('Name'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name can not be empty";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10,),


                TextFormField(
                  controller: signUpScreenController.passwordController,
                  decoration: Utils.inputDecoration('Password'),
                  // obscureText: true,
                  textInputAction: TextInputAction.next,
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
                          if(signUpScreenController.signUpFormKey.currentState!.validate()){
                              signUpScreenController.signUpData().then((value) {
                                 customData();
                             });
                          }
                        },
                        child: Obx(() => Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: Get.height / 15,
                            decoration: Utils().containerDecoration(),
                            child:   Center(
                                child: isLoading.value == true ? const CircularProgressIndicator(color: Colors.white,) : const Text('Sign up',
                                  style: FontStyle.textHeaderWhite,)),),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already Have an Account ? ",style: FontStyle.buttonBoldBlack.copyWith(fontSize: 12),),

                    GestureDetector(
                        onTap: () {
                          signUpScreenController.emailController.text = '';
                          signUpScreenController.passwordController.text = '';
                          isLoading.value = false;
                          Get.back();
                        },
                        child: SizedBox(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Sign In",style: FontStyle.buttonBoldBlack.copyWith(fontSize: 13,color: AppColors.primaryColor),),
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
}