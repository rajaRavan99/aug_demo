import 'dart:io';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:direct_message/CommonWidget/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:direct_message/CommonWidget/flutter_toast.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:direct_message/ConstData/static_data.dart';
import 'package:direct_message/Routes/routes.dart';
import 'package:direct_message/Screen/SqliteDatabase/phonenumber_model.dart';
import 'package:direct_message/Screen/SqliteDatabase/sqlite_database_helper.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
Rx<Country> phoneNumber = CountryPickerUtils.getCountryByPhoneCode('91').obs ;
class DirectMessageScreenController extends GetxController with StateMixin{

  RxList<TaskData> taskData = RxList();
  RxInt counter = 0.obs;
  RxInt counterHowToUse = 0.obs;
  RxString selectValue = "".obs;
  BuildContext? buildContext;
  RxString cname = "IN".obs;
  RxString getMsg = "".obs;
  RxBool sendMsg = false.obs;
  RxString name = "".obs;
  final formGlobalKey = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();
    if (isTemp.value == true) {
      getData();
      sendMsg;
      isTemp.value = false;
    } else {
      getData();
      sendMsg;
    }
  }

  @override
  void onClose() {
    addPhoneController.clear();
    addMsgController.clear();
    super.onClose();
  }

  void openWhatsapp() async {
    RegExp regExp = RegExp(r'^\+(?:998|996|995|994|993|992|977|976|975|974|973|972|971|970|968|967|966|965|964|963|962|961|960|886|880|856|855|853|852|850|692|691|690|689|688|687|686|685|683|682|681|680|679|678|677|676|675|674|673|672|670|599|598|597|595|593|592|591|590|509|508|507|506|505|504|503|502|501|500|423|421|420|389|387|386|385|383|382|381|380|379|378|377|376|375|374|373|372|371|370|359|358|357|356|355|354|353|352|351|350|299|298|297|291|290|269|268|267|266|265|264|263|262|261|260|258|257|256|255|254|253|252|251|250|249|248|246|245|244|243|242|241|240|239|238|237|236|235|234|233|232|231|230|229|228|227|226|225|224|223|222|221|220|218|216|213|212|211|98|95|94|93|92|91|90|86|84|82|81|66|65|64|63|62|61|60|58|57|56|55|54|53|52|51|49|48|47|46|45|44\\D?1624|44\D?1534|44\D?1481|44|43|41|40|39|36|34|33|32|31|30|27|20|7|1\D?939|1\D?876|1\D?869|1\D?868|1\D?849|1\D?829|1\D?809|1\D?787|1\D?784|1\D?767|1\D?758|1\D?721|1\D?684|1\D?671|1\D?670|1\D?664|1\D?649|1\D?473|1\D?441|1\D?345|1\D?340|1\D?284|1\D?268|1\D?264|1\D?246|1\D?242|1)\D?');
    var whatsapp = addPhoneController.text;
    var temp = '+' + phoneNumber.value.phoneCode + whatsapp.removeAllWhitespace.replaceAll(regExp, "");
    print('_----tempopenWhatsapp-------------> $temp');
    var msg = addMsgController.text;
    var whatsappURlAndroid = Uri.parse("whatsapp://send?phone=$temp&text=$msg");
    var whatsappURLIos = "https://wa.me/$temp?text=$msg";
    var encoded = Uri.encodeFull(whatsappURLIos);

    if (Platform.isIOS) {
      if (await canLaunch(encoded)) {
        await launch(encoded, forceSafariVC: false);
      } else {
       flutterToast(text: "Whatsapp Not Installed");
      }
    } else {
      if (await canLaunchUrl(whatsappURlAndroid)) {
        await launchUrl(whatsappURlAndroid, mode: LaunchMode.externalApplication);
      } else {
        flutterToast(text: "WhatsApp Not Installed");
      }
    }
  }

  openContactAppSettings()async{
    if(Platform.isAndroid){
      final FlutterContactPicker contactPicker = FlutterContactPicker();
      if(await Permission.contacts.status.isDenied){
        var status =  await Permission.contacts.request();
        if(status.isGranted){
            Contact? contact = await contactPicker.selectContact();
          if(contact != null){
            RegExp regExp = RegExp(r'^\+(?:998|996|995|994|993|992|977|976|975|974|973|972|971|970|968|967|966|965|964|963|962|961|960|886|880|856|855|853|852|850|692|691|690|689|688|687|686|685|683|682|681|680|679|678|677|676|675|674|673|672|670|599|598|597|595|593|592|591|590|509|508|507|506|505|504|503|502|501|500|423|421|420|389|387|386|385|383|382|381|380|379|378|377|376|375|374|373|372|371|370|359|358|357|356|355|354|353|352|351|350|299|298|297|291|290|269|268|267|266|265|264|263|262|261|260|258|257|256|255|254|253|252|251|250|249|248|246|245|244|243|242|241|240|239|238|237|236|235|234|233|232|231|230|229|228|227|226|225|224|223|222|221|220|218|216|213|212|211|98|95|94|93|92|91|90|86|84|82|81|66|65|64|63|62|61|60|58|57|56|55|54|53|52|51|49|48|47|46|45|44\\D?1624|44\D?1534|44\D?1481|44|43|41|40|39|36|34|33|32|31|30|27|20|7|1\D?939|1\D?876|1\D?869|1\D?868|1\D?849|1\D?829|1\D?809|1\D?787|1\D?784|1\D?767|1\D?758|1\D?721|1\D?684|1\D?671|1\D?670|1\D?664|1\D?649|1\D?473|1\D?441|1\D?345|1\D?340|1\D?284|1\D?268|1\D?264|1\D?246|1\D?242|1)\D?');
            addPhoneController.text = contact.phoneNumbers.toString().replaceAll("[", "").replaceAll(regExp, "").replaceAll("]", "").replaceAll("-", "").removeAllWhitespace;
          }
        }else if(status.isPermanentlyDenied){
          openDialog();
        }
      }else if(await Permission.contacts.status.isGranted){
        Contact? contact = await contactPicker.selectContact();
        if(contact != null){
          RegExp regExp = RegExp(r'^\+(?:998|996|995|994|993|992|977|976|975|974|973|972|971|970|968|967|966|965|964|963|962|961|960|886|880|856|855|853|852|850|692|691|690|689|688|687|686|685|683|682|681|680|679|678|677|676|675|674|673|672|670|599|598|597|595|593|592|591|590|509|508|507|506|505|504|503|502|501|500|423|421|420|389|387|386|385|383|382|381|380|379|378|377|376|375|374|373|372|371|370|359|358|357|356|355|354|353|352|351|350|299|298|297|291|290|269|268|267|266|265|264|263|262|261|260|258|257|256|255|254|253|252|251|250|249|248|246|245|244|243|242|241|240|239|238|237|236|235|234|233|232|231|230|229|228|227|226|225|224|223|222|221|220|218|216|213|212|211|98|95|94|93|92|91|90|86|84|82|81|66|65|64|63|62|61|60|58|57|56|55|54|53|52|51|49|48|47|46|45|44\\D?1624|44\D?1534|44\D?1481|44|43|41|40|39|36|34|33|32|31|30|27|20|7|1\D?939|1\D?876|1\D?869|1\D?868|1\D?849|1\D?829|1\D?809|1\D?787|1\D?784|1\D?767|1\D?758|1\D?721|1\D?684|1\D?671|1\D?670|1\D?664|1\D?649|1\D?473|1\D?441|1\D?345|1\D?340|1\D?284|1\D?268|1\D?264|1\D?246|1\D?242|1)\D?');
          addPhoneController.text = contact.phoneNumbers.toString().replaceAll("[", "").replaceAll(regExp, "").replaceAll("]", "").replaceAll("-", "").removeAllWhitespace;
        }
      }
    }
    else if(Platform.isIOS){
      final FlutterContactPicker contactPicker = FlutterContactPicker();
      if(await Permission.contacts.status.isDenied){
        var status =  await Permission.contacts.request();
        if(status.isGranted){
          Contact? contact = await contactPicker.selectContact();
          if(contact != null){
            RegExp regExp = RegExp(r'^\+(?:998|996|995|994|993|992|977|976|975|974|973|972|971|970|968|967|966|965|964|963|962|961|960|886|880|856|855|853|852|850|692|691|690|689|688|687|686|685|683|682|681|680|679|678|677|676|675|674|673|672|670|599|598|597|595|593|592|591|590|509|508|507|506|505|504|503|502|501|500|423|421|420|389|387|386|385|383|382|381|380|379|378|377|376|375|374|373|372|371|370|359|358|357|356|355|354|353|352|351|350|299|298|297|291|290|269|268|267|266|265|264|263|262|261|260|258|257|256|255|254|253|252|251|250|249|248|246|245|244|243|242|241|240|239|238|237|236|235|234|233|232|231|230|229|228|227|226|225|224|223|222|221|220|218|216|213|212|211|98|95|94|93|92|91|90|86|84|82|81|66|65|64|63|62|61|60|58|57|56|55|54|53|52|51|49|48|47|46|45|44\\D?1624|44\D?1534|44\D?1481|44|43|41|40|39|36|34|33|32|31|30|27|20|7|1\D?939|1\D?876|1\D?869|1\D?868|1\D?849|1\D?829|1\D?809|1\D?787|1\D?784|1\D?767|1\D?758|1\D?721|1\D?684|1\D?671|1\D?670|1\D?664|1\D?649|1\D?473|1\D?441|1\D?345|1\D?340|1\D?284|1\D?268|1\D?264|1\D?246|1\D?242|1)\D?');
            addPhoneController.text = contact.phoneNumbers.toString().replaceAll("[", "").replaceAll(regExp, "").replaceAll("]", "").replaceAll("-", "").removeAllWhitespace;
          }
        }else if(status.isPermanentlyDenied){
          openDialog();
        }
      }else if(await Permission.contacts.status.isGranted){
        Contact? contact = await contactPicker.selectContact();
        if(contact != null){
          RegExp regExp = RegExp(r'^\+(?:998|996|995|994|993|992|977|976|975|974|973|972|971|970|968|967|966|965|964|963|962|961|960|886|880|856|855|853|852|850|692|691|690|689|688|687|686|685|683|682|681|680|679|678|677|676|675|674|673|672|670|599|598|597|595|593|592|591|590|509|508|507|506|505|504|503|502|501|500|423|421|420|389|387|386|385|383|382|381|380|379|378|377|376|375|374|373|372|371|370|359|358|357|356|355|354|353|352|351|350|299|298|297|291|290|269|268|267|266|265|264|263|262|261|260|258|257|256|255|254|253|252|251|250|249|248|246|245|244|243|242|241|240|239|238|237|236|235|234|233|232|231|230|229|228|227|226|225|224|223|222|221|220|218|216|213|212|211|98|95|94|93|92|91|90|86|84|82|81|66|65|64|63|62|61|60|58|57|56|55|54|53|52|51|49|48|47|46|45|44\\D?1624|44\D?1534|44\D?1481|44|43|41|40|39|36|34|33|32|31|30|27|20|7|1\D?939|1\D?876|1\D?869|1\D?868|1\D?849|1\D?829|1\D?809|1\D?787|1\D?784|1\D?767|1\D?758|1\D?721|1\D?684|1\D?671|1\D?670|1\D?664|1\D?649|1\D?473|1\D?441|1\D?345|1\D?340|1\D?284|1\D?268|1\D?264|1\D?246|1\D?242|1)\D?');
          addPhoneController.text = contact.phoneNumbers.toString().replaceAll("[", "").replaceAll(regExp, "").replaceAll("]", "").replaceAll("-", "").removeAllWhitespace;
        }
      }
    }
  }

  openDialog(){
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 10.0),
      title:
      "Permission",
      titleStyle: const TextStyle(
          fontFamily: "Inter-SemiBold",
          fontSize: 17.0
      ),
      radius:5.0,
      contentPadding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
      content:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10.0),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Require Contact Permission",
              style: TextStyle(
                  fontFamily: "Inter-Regular"
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Select Permission -> Enable Permission",
              style: TextStyle(
                  fontFamily: "Inter-Regular"
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Utils().containerButton("CANCEL")
                ),
              ),
              const SizedBox(width: 15.0,),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      openAppSettings();
                      Get.back();
                    },
                    child: Utils().containerButton( "SETTINGS")
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  openWhatsappAddNumber({whatsapp}) async {
    var msg = addMsgController.text;
    var whatsappURlAndroid = Uri.parse("whatsapp://send?phone=${whatsapp.replaceAll(" ", "")}&text=$msg");
    var whatsappURLIos = "https://wa.me/$whatsapp?text=$msg";
    var encoded = Uri.encodeFull(whatsappURLIos);
    if (Platform.isIOS) {
      if (await canLaunch(encoded)) {
    await launch(encoded, forceSafariVC: false);
      } else {
        flutterToast(text: "Whatsapp Not Installed");
      }
    } else {
       if (await canLaunchUrl(whatsappURlAndroid)) {
           await launchUrl(whatsappURlAndroid, mode: LaunchMode.externalApplication);
       } else {
            flutterToast(text: "Whatsapp Not Installed");
       }
    }
  }

  getData() {
    DatabaseHelper.instance.queryAllRow().then((value) {
      taskData.value = value;
      update();
    });
    update();
  }

  clearText() {
    addPhoneController.clear();
    addMsgController.clear();
  }

  addData() async {
    RegExp regExp = RegExp(r'^\+(?:998|996|995|994|993|992|977|976|975|974|973|972|971|970|968|967|966|965|964|963|962|961|960|886|880|856|855|853|852|850|692|691|690|689|688|687|686|685|683|682|681|680|679|678|677|676|675|674|673|672|670|599|598|597|595|593|592|591|590|509|508|507|506|505|504|503|502|501|500|423|421|420|389|387|386|385|383|382|381|380|379|378|377|376|375|374|373|372|371|370|359|358|357|356|355|354|353|352|351|350|299|298|297|291|290|269|268|267|266|265|264|263|262|261|260|258|257|256|255|254|253|252|251|250|249|248|246|245|244|243|242|241|240|239|238|237|236|235|234|233|232|231|230|229|228|227|226|225|224|223|222|221|220|218|216|213|212|211|98|95|94|93|92|91|90|86|84|82|81|66|65|64|63|62|61|60|58|57|56|55|54|53|52|51|49|48|47|46|45|44\\D?1624|44\D?1534|44\D?1481|44|43|41|40|39|36|34|33|32|31|30|27|20|7|1\D?939|1\D?876|1\D?869|1\D?868|1\D?849|1\D?829|1\D?809|1\D?787|1\D?784|1\D?767|1\D?758|1\D?721|1\D?684|1\D?671|1\D?670|1\D?664|1\D?649|1\D?473|1\D?441|1\D?345|1\D?340|1\D?284|1\D?268|1\D?264|1\D?246|1\D?242|1)\D?');
    var whatsapp = addPhoneController.text;
    var temp = '+' +phoneNumber.value.phoneCode + whatsapp.removeAllWhitespace.replaceAll(regExp, "");
    print('_-----------------> ${temp}');
    await DatabaseHelper.instance.insert(TaskData(
      title: temp,
      time: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString()));
    getData();
    addPhoneController.clear();
    addMsgController.clear();
    Get.back();
  }

  deleteTask(int id) async {
    await DatabaseHelper.instance.delete(id);
    taskData.removeWhere((element) => element.id == id);
    flutterToast(text: "Successfully Deleted");
    getData();
  }

  navigateToSettingsScreen() {
    Get.toNamed(AppRoute.settingsScreen);
  }

  navigateToCustomMessageScreen() {
    Get.toNamed(AppRoute.customMessageScreen);
  }

  PopupMenuItem buildPopupMenuItem(String title, Function ontap) {
    return PopupMenuItem(
      child: Text(title),
    );
  }

  Widget buildDialogItem(Country country) =>
      Row(
    children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
      const SizedBox(width: 8.0),
      Text("+${country.phoneCode}"),
      const SizedBox(width: 8.0),
      Flexible(child: Text('(${country.isoCode})'),)
    ],
  );

  openCountryPickerDialog(BuildContext context)  {
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.pink),
        child: CountryPickerDialog(
          titlePadding: const EdgeInsets.all(8.0),
          searchCursorColor: Colors.pinkAccent,
          searchInputDecoration: const InputDecoration(hintText: 'Search...'),
          isSearchable: true,
          title: const Text('Select your phone code'),
          onValuePicked: (Country country) {
            phoneNumber.value = country;
          },

          itemBuilder: buildDialogItem,
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('IN'),
          ],
        ),
      ),
    );
  }
}
