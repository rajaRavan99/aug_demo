import 'package:shared_preferences/shared_preferences.dart';
import '../../Screen/HomeScreen/home_screen_controller.dart';
import '../GlobalVariable/global_varible.dart';
import '../const.dart';

Future setSharedPreferenceData({required String emailSet,required String keySet,}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  email.value = emailSet;
  keyValue.value = keySet;
  print('=============call set data============${email.value} ${keyValue.value}');
  await preferences.setBool('isLogin' ,true);
  await preferences.setString('email' ,emailSet);
  await preferences.setString('keyValue' ,keySet);

}