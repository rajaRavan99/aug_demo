import 'package:shared_preferences/shared_preferences.dart';
import '../Global_Variable/global_variable.dart';

Future setSharedPreferenceData({required bool setValue,required String emailSet}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  email.value = emailSet;
  preferences.setBool('isLogin' ,setValue);
  preferences.setString('email' ,emailSet);
}