import 'package:get/get_rx/src/rx_types/rx_types.dart';

class MsgData {
  int? id;
  String title;
  String? subtitle;
  int? isSelected = 0;

  MsgData({
    this.id,
    required this.title,
    this.subtitle,
    this.isSelected
  });

  MsgData.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        subtitle = res['subtitle'],
  isSelected = res['isSelected'];


  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'isSelected': isSelected,
    };
  }
}