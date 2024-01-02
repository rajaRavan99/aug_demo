import 'package:shared_preferences/shared_preferences.dart';

getLoginUser() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var data  = preferences.getBool('isLogin');
  print('---getLoginUser---$data');
  return data;
}