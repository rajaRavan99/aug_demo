class MsgGetModel {
  String? message;
  String? name;
  String? dateTime;
  String? recordKey;
  bool? isCheck;

  MsgGetModel({
    this.message,
    this.name,
    this.dateTime,
    this.recordKey,
    this.isCheck,
  });


  MsgGetModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';
    name = json['name'] ?? '';
    dateTime = json['dateTime'] ?? '';
    recordKey = json['recordKey'] ?? '';
    isCheck = json['isCheck'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['name'] = name;
    data['dateTime'] = dateTime;
    data['recordKey'] = recordKey;
    data['isCheck'] = isCheck;
    return data;
  }
}

// class MsgGetModel2 {
//   String? message;
//   String? name;
//
//   MsgGetModel2({this.message , this.name});
//
//   factory MsgGetModel2.fromJson(Map<String, dynamic> json) {
//     return MsgGetModel2(
//       message: json.values.first['message'] ?? '',
//       name: json.values.first['name'] ?? '',
//     );
//   }
// }