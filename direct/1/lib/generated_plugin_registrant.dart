//
// Generated file. Do not edit.
//
// ignore_for_file: directives_ordering
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: depend_on_referenced_packages
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:firebase_remote_config_web/firebase_remote_config_web.dart';
// import 'package:flutter_native_splash/flutter_native_splash_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
// import 'package:fluttertoast/fluttertoast_web.dart';
import 'package:package_info_plus_web/package_info_plus_web.dart';
import 'package:share_plus_web/share_plus_web.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  FirebaseCoreWeb.registerWith(registrar);
  FirebaseRemoteConfigWeb.registerWith(registrar);
  // FlutterNativeSplashWeb.registerWith(registrar);
  // FluttertoastWebPlugin.registerWith(registrar);
  PackageInfoPlugin.registerWith(registrar);
  SharePlusPlugin.registerWith(registrar);
  SharedPreferencesPlugin.registerWith(registrar);
  UrlLauncherPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
