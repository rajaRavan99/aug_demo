import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Global_Variable/global_variable.dart';

RxString keyValue = ''.obs;
Future getSharedPreferenceData() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  email.value = preferences.getString('email') ?? '';
  String key = preferences.getString('keyValue') ?? '';
  keyValue.value = key;
}