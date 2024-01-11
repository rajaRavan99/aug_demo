import 'package:direct_message/Extension/getx_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Routes/routes.dart';


class QrGenerateController extends GetxController {
  String contact = '';
  RxString qrData = "No Data Available".obs;
  String name = Get.find(tag: "titleName");
  String hintText = Get.find(tag: "hintText");
  final formKey = GlobalKey<FormState>();



  TextEditingController textController = TextEditingController();

  TextEditingController urlController = TextEditingController();

  // contact Controller
  TextEditingController cFullNameController = TextEditingController();
  TextEditingController cAddressController = TextEditingController();
  TextEditingController cPhoneController = TextEditingController();
  TextEditingController cEmailController = TextEditingController();
  TextEditingController cNoteController = TextEditingController();

  //Email Controller
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  //sms Controller
  TextEditingController sPhoneController = TextEditingController();
  TextEditingController sMessageController = TextEditingController();

  //Geo Controller
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  // phone Controller
  TextEditingController phoneController = TextEditingController();

  // wifi Controller
  TextEditingController networkNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    urlController.dispose();
    cFullNameController.dispose();
    cAddressController.dispose();
    cPhoneController.dispose();
    cEmailController.dispose();
    cNoteController.dispose();
    emailController.dispose();
    subjectController.dispose();
    bodyController.dispose();
    sPhoneController.dispose();
    sMessageController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    phoneController.dispose();
    networkNameController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  navigateToQrGenerateView() {
    print("controller.text ----> ${textController.text}");
    Get.deleteAndPut(contact, tag: "qrText");
    textController.clear();
    Get.toNamed(AppRoute.qrGenerateView);
  }

  generateQr() {
    switch(name){
      case 'Text' :
        contact = textController.text.replaceAll(' ','');
        qrData.value = contact;
        break;

      case 'URL' :
        contact = urlController.text.replaceAll(' ','');
        qrData.value = contact;
        break;

      case 'Contact' :
        contact = '${cFullNameController.text.replaceAll(' ','')} '
            '${cAddressController.text.replaceAll(' ','')} '
            '${cPhoneController.text.replaceAll(' ','')} ${cEmailController.text.replaceAll(' ','')} '
            '${cNoteController.text.replaceAll(' ','')}';
        qrData.value = contact;
        break;

      case 'Email' :
        contact = '${emailController.text.replaceAll(' ','')} ${subjectController.text.replaceAll(' ','')} ${bodyController.text.replaceAll(' ','')}';
        qrData.value = contact;
        break;

      case 'SMS' :
        contact = '${sPhoneController.text.replaceAll(' ','')} ${sMessageController.text.replaceAll(' ','')}';
        qrData.value = contact;
        break;

      case 'Geo' :
        contact = '${latitudeController.text.replaceAll(' ','')} ${longitudeController.text.replaceAll(' ','')}';
        qrData.value = contact;
        break;

      case 'Phone' :
        contact  = phoneController.text.replaceAll(' ','');
        qrData.value = contact;
        break;

      case 'wifi' :
        contact  = '${networkNameController.text.replaceAll(' ','')} ${passwordController.text.replaceAll(' ','')}';
        qrData.value = contact;
        break;
    }
    update();
    navigateToQrGenerateView();
  }
}
