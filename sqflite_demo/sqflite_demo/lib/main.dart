import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Routes/routes.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Database',
      color: Colors.grey,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.loginPageFirebase,
      getPages: AppRoutes.routeList,
    );
  }
}
