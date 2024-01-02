import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:officeboy/CommonWidget/textfield.dart';
import '../../../CommonWidget/app_colors.dart';
import '../../../Routes/routes.dart';
import '../../../CommonWidget/Utils.dart';
import '../../../constData/GlobalVariable/global_varible.dart';
import '../SignUp/sign_up_screen_controller.dart';
import 'sign_in_screen_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  SignInScreenController signInScreenController = Get.put(SignInScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: Form(
        key: signInScreenController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder(
              init: SignInScreenController(),
              builder: (signInScreenController) =>  SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [

                      // SizedBox(height: Get.height * 0.25),

                      Image.asset(
                        'assets/images/Login.png',
                        width: Get.width * 0.90,),

                      const SizedBox(height: 10,),

                      TextFormField(
                        controller: signInScreenController.emailController,
                        decoration: Utils.inputDecoration('Name'),
                        keyboardType: TextInputType.name,
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
                                if(signInScreenController.formKey.currentState!.validate())
                                  {
                                    signInScreenController.signInFetch().then((value) {
                                      cloudTableFetch(email: signInScreenController.emailController.text.toString());
                                    });
                                  }
                              },
                              child: Obx(() =>  Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  height: Get.height / 15,
                                  decoration: Utils().containerDecoration(),
                                  child: Center(
                                      child: signInLoader.value == true ? const CircularProgressIndicator(color: Colors.white,) : const Text('Sign In',
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
                            Text("Don't Have an Account ?",style: FontStyle.buttonBoldBlack.copyWith(fontSize: 12),),

                            GestureDetector(
                              onTap: () {
                                signInScreenController.emailController.text = '';
                                signInScreenController.passwordController.text = '';
                                signInLoader.value = false;
                                Get.toNamed(AppRoutes.signUpScreen);
                              },
                              child: SizedBox(
                                child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 6.0),
                                child: Text("Sign Up",style: FontStyle.buttonBoldBlack.copyWith(fontSize: 13,color: AppColors.primaryColor),),
                                ),
                              ),
                            ),
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
      ),
    );
  }
}