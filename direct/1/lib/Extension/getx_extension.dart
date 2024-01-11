import 'package:get/get.dart';

extension $GetxExtension on GetInterface {
  T deleteAndPut<T>(T dependency, {String? tag}) {
    GetInstance().delete<T>(tag: tag, force: true);
    return Get.put<T>(dependency, tag: tag);
  }
}

String enumToString(Object o) => o.toString().split('.').last;
T enumFromString<T>(String key, List<T> values) =>
    values.firstWhere((v) => key == enumToString(v!));

/// eg. ---> argument pass:- Get.deleteAndPut(image, tag: "imageLink");
/// eg. ---> argument get:- Get.find(tag: "imageLink");