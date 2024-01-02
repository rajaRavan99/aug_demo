import 'package:shared_preferences/shared_preferences.dart';

import '../../Screen/HomeScreen/home_screen_controller.dart';
import '../GlobalVariable/global_varible.dart';
import '../const.dart';

Future getSharedPreferenceData() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  email.value = preferences.getString('email') ?? '';
  String key = preferences.getString('keyValue') ?? '';
  keyValue.value = key;
  // print('f=============call set data============${email.value} ${keyValue.value}');
}