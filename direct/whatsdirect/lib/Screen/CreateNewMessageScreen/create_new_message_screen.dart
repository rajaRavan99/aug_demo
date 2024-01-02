import 'package:direct_message/CommonWidget/app_colors.dart';
import 'package:direct_message/Screen/CreateNewMessageScreen/create_new_message_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CommonWidget/Utils.dart';
import '../../ConstData/colors.dart';
import 'package:direct_message/CommonWidget/textfield.dart';

class CreateNewMsgScreen extends StatelessWidget {
  CreateNewMsgScreen({Key? key}) : super(key: key);

  final CreateNewMessageScreenController createNewMessageScreenController = Get.put(CreateNewMessageScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          shadowColor: Colors.grey.withOpacity(0.2),
          backgroundColor: likeWhiteColor,
          centerTitle: true,

          leading: Utils().arrowBackAppBar(),
          title: Text(
              createNewMessageScreenController.isStatus ? 'Update Custom Message' : 'Create Custom Message',
              style: FontStyle.textBlack.copyWith(fontSize: 15)
          ),
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5.0),
              GestureDetector(
                  onTap: () {
                    createNewMessageScreenController.editMsg();
                  },
                  child: Utils().containerButton(createNewMessageScreenController.isStatus  ? 'Edit Message' : 'Add Custom Message',)
              ),
              const SizedBox(height: 5.0),
            ],
          ),
        ),

        body: SingleChildScrollView(
          child: Form(
            key: createNewMessageScreenController.formKey,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  SizedBox(height: Get.height / 50.0,),

                  const Text(
                    'Title of Message',
                    style: TextStyle(
                      fontFamily: 'Inter-SemiBold',
                      fontSize: 12.0,
                    ),
                  ),

                  const SizedBox(height: 12.0,),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(11.0),
                    child: TextFormField(
                        controller: createNewMessageScreenController.titleController,
                        cursorColor: blackColor,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                        contentPadding:const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                        hintText: 'Enter Title',

                        hintStyle: const TextStyle(
                          fontFamily: 'Inter-Regular',
                          fontSize: 12.1,
                          color: lightText,
                        ),
                        fillColor: fieldBorder,
                        filled: true,
                        border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: const BorderSide(
                                width: 1, color: AppColors.greyText), //<-- SEE HERE
                          ),

                          errorBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(11),
                            borderSide: const BorderSide(
                                width: 1, color: AppColors.greyText), //<-- SEE HERE
                          ),

                          focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: const BorderSide(
                                width: 1, color: AppColors.greyText), //<-- SEE HERE
                          ),

                          focusedErrorBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: const BorderSide(
                                width: 1, color: AppColors.greyText), //<-- SEE HERE
                          ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter title';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 20.0,),

                  const Text(
                    'Type Message',
                    style: TextStyle(
                      fontFamily: 'Inter-SemiBold',
                      fontSize: 12.0,
                    ),
                  ),

                  const SizedBox(height: 12.0,),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(11.0),
                    child: TextFormField(
                      controller: createNewMessageScreenController.subtitleController,
                      cursorColor: const Color(0xFF000000),
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter message';
                        }
                        return null;
                      },

                      cursorHeight: 20,
                      maxLines: 7,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(left: 11.0, top: 17.0, bottom: 3.0,right: 11),
                        hintText: 'Type Message',
                        hintStyle: const TextStyle(
                          fontFamily: 'Inter-Regular',
                          fontSize: 12.1,
                          color: lightText,
                        ),
                        fillColor: fieldBorder,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(
                              width: 1, color: AppColors.greyText), //<-- SEE HERE
                        ),

                        errorBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(
                              width: 1, color: AppColors.greyText), //<-- SEE HERE
                        ),

                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(
                              width: 1, color: AppColors.greyText), //<-- SEE HERE
                        ),

                        focusedErrorBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(
                              width: 1, color: AppColors.greyText), //<-- SEE HERE
                        ),
                      ),
                    ),
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
