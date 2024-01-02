import 'package:direct_message/CommonWidget/app_colors.dart';
import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CommonWidget/Utils.dart';
import 'create_note_controller.dart';


class CreateNote extends StatelessWidget {
  CreateNote({Key? key}) : super(key: key);

  CreateNoteController createNoteController = Get.put(CreateNoteController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          elevation: 5.0,
          shadowColor: Colors.grey.withOpacity(0.2),
          backgroundColor: likeWhiteColor,
          centerTitle: true,
          title:  Text(
            createNoteController.isStatus ? 'Update Notes' : 'Create Notes' ,
            style: FontStyle.textBlack.copyWith(fontWeight: FontWeight.w600,)
          ),

          leading: Utils().arrowBackAppBar(),
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: createNoteController.formKey,
            child: SingleChildScrollView(
              child: GetBuilder(
                init: createNoteController,
                builder: (CreateNoteController controller) {
                  return  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        SizedBox(
                          height: Get.height / 25,
                        ),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(11.0),
                          child:

                          TextFormField(
                            controller: createNoteController.titleController,
                            textAlign: TextAlign.start,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              fillColor: fieldBorder,
                              filled: true,
                              hintText: 'Title',
                              hintStyle: const TextStyle( color: Colors.grey,fontSize: 12),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),

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
                              if(value!.isEmpty){
                                return 'Please Enter title';
                              }
                              return null;

                            },
                          ),
                        ),

                        SizedBox(
                          height: Get.height / 50,
                        ),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(11.0),
                          child: TextFormField(
                            controller: createNoteController.subtitleController,
                            textAlign: TextAlign.start,maxLines: 6,
                            cursorColor: blackColor,
                            textInputAction: TextInputAction.done,
                            decoration:  InputDecoration(
                              contentPadding:const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              hintText: 'Description',
                              hintStyle: const TextStyle( color: Colors.grey,fontSize: 12),
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
                              if(value!.isEmpty){
                                return 'Please Enter Description';
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 20.0,
                        ),

                      ],
                    ),
                  );
                },

              ),
            ),
          ),
        ),

        bottomNavigationBar: GestureDetector(
          onTap: () {
            createNoteController.editMsg();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5.0),
                Utils().containerButton(createNoteController.isStatus ? 'UPDATE' : 'CREATE',),
                const SizedBox(height: 5.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
