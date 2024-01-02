import 'package:shared_preferences/shared_preferences.dart';

import '../../ConstData/static_data.dart';

Future<bool> getBoolHowToUseOpen() async {
  final prefs = await SharedPreferences.getInstance();
  bool temp = await prefs.getBool('howtoUseOpen') ?? true;
  isHowToUseScreen = temp;
  return temp;
}
