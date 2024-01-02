class AdminModel {

  String? recordId;
  String? name;
  String? dateTime;
  String? email;
  String? password;
  String? deviceToken;

  AdminModel({
    this.name,
    this.dateTime,
    this.recordId,
    this.email,
    this.password,
    this.deviceToken,
  });


  AdminModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    dateTime = json['dateTime'] ?? '';
    recordId = json['uId'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
    deviceToken = json['deviceToken'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['dateTime'] = dateTime;
    data['uId'] = recordId;
    data['email'] = email;
    data['password'] = password;
    data['deviceToken'] = deviceToken;
    return data;
  }
}