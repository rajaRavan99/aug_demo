import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

initializeRemoteConfig() async {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: Duration.zero,
  ));
  await remoteConfig.fetchAndActivate();

  String privacyPolicy = remoteConfig.getString('privacy_policy');
  String TermsAndCondition = remoteConfig.getString('TermsAndCondition');

  String requiredBuildNumberAndroid = remoteConfig.getString('requiredBuildNumberAndroid');
  String requiredBuildNumberIos = remoteConfig.getString('requiredBuildNumberIos');

  print('privacyPolicy====>${privacyPolicy}');
  print('TermsAndCondition====>${TermsAndCondition}');
  print('requiredBuildNumberAndroid====>${requiredBuildNumberAndroid}');
  print('requiredBuildNumberIos====>${requiredBuildNumberIos}');

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('privacy_policy', privacyPolicy);
  await prefs.setString('TermsAndCondition', TermsAndCondition);
  await prefs.setString(
      'requiredBuildNumberAndroid', requiredBuildNumberAndroid);
  await prefs.setString('requiredBuildNumberIos', requiredBuildNumberIos);
}
