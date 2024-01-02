import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:officeboy/CommonWidget/textfield.dart';
import '../../../CommonWidget/app_colors.dart';
import '../../../CommonWidget/Utils.dart';
import '../../../constData/GlobalVariable/global_varible.dart';
import 'sign_up_screen_controller.dart';

RxString deviceToken = ''.obs;

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  SignUpScreenController signUpScreenController = SignUpScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: signUpScreenController.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children:  [

                    Image.asset(
                      'assets/images/Login.png',
                      width: Get.width * 0.90,),

                    const SizedBox(height: 10,),

                    TextFormField(
                      controller: signUpScreenController.emailController,
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
                      controller: signUpScreenController.passwordController,
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
                            onTap: () async {
                                if(signUpScreenController.formKey.currentState!.validate()){
                                    signUpScreenController.signUp();
                                  }
                               },
                            child: Obx(() => Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  height: Get.height / 15,
                                  decoration: Utils().containerDecoration(),
                                  child: Center(
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
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 6.0),
                              child: Text("Sign In",style: FontStyle.buttonBoldBlack.copyWith(fontSize: 13,color: AppColors.primaryColor),),
                            ))),
                      ],
                    ),


                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}