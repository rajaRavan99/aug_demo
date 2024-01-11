import 'package:shared_preferences/shared_preferences.dart';

import '../../ConstData/static_data.dart';

Future<void> saveBoolHowToUseOpen(howToUse) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('howtoUseOpen', howToUse);
  isHowToUseScreen = howToUse;
}
