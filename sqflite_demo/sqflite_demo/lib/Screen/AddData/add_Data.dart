import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sqflite_demo/CommonWidget/textfield.dart';
import '../../Utils.dart';
import 'add_Data_Controller.dart';

class AddData extends StatelessWidget {
  AddData({Key? key}) : super(key: key);

  AddDataController addDataController = Get.put(AddDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple,
        title:  Text(addDataController.isStatus ? "Update Data" :'Add Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: addDataController.formKey,
            child: Column(
              children: [

                const SizedBox(
                  height: 50,
                ),

                TextFormField(
                  style: FontStyle.textInput,
                  textInputAction: TextInputAction.next,
                  controller: addDataController.nameController,
                  decoration: Utils().inputDecoration('Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter name   ';
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 15,
                ),

                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: addDataController.emailController,
                  decoration: Utils().inputDecoration('Email'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return 'Please Enter email';
                    }
                    if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                      return 'Please a valid Email';
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 15,
                ),

                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: addDataController.mobileController,
                  decoration: Utils().inputDecoration('Mobile Number'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Number';}
                     else if(value!.length < 10){
                        return 'Please Enter valid Number';
                      }
                     return null;
                  },
                ),

                const SizedBox(
                  height: 15,
                ),

                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: addDataController.homeAddressController,
                  decoration: Utils().inputDecoration('Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Address';
                    }
                    return null;
                  },
                ),

                //  const SizedBox(
                //   height: 15,
                // ),
                //
                // TextFormField(
                //   textInputAction: TextInputAction.next,
                //   controller: addDataController.ageController,
                //   decoration: Utils().inputDecoration('Age'),
                //   inputFormatters: [
                //     FilteringTextInputFormatter.digitsOnly,
                //     LengthLimitingTextInputFormatter(10),
                //   ],
                //   keyboardType: TextInputType.number,
                //
                // ),
                //
                //  const SizedBox(
                //   height: 15,
                // ),
                //
                // TextFormField(
                //   textInputAction: TextInputAction.next,
                //   controller: addDataController.genderController,
                //   decoration: Utils().inputDecoration('Gender'),
                //
                // ),

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: ()  {
                        if(addDataController.formKey.currentState!.validate())
                          {
                            addDataController.sendData();
                            ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content: Text(addDataController.isStatus ? "Data Updated" :'Data Added')),
                            );
                            Get.back();
                            // addDataController.navigateToGetListD();
                          }

                      },
                      child: Container(
                        height: context.height / 18,
                        width: context.height * 0.30,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                            child: Text(
                          addDataController.isStatus ? "Update" :'Save',
                          style: const TextStyle(fontSize: 15, color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
