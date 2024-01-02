class UserModel {

  bool? officeTime;
  String? name;
  String? about;
  String? dateTime;
  String? lastActive;
  bool? isOnline;
  String? recordId;
  String? email;
  String? password;
  String? deviceToken;

  UserModel({
    this.officeTime,
    this.name,
    this.about,
    this.dateTime,
    this.lastActive,
    this.isOnline,
    this.recordId,
    this.email,
    this.password,
    this.deviceToken,
  });


  UserModel.fromJson(Map<String, dynamic> json) {
    officeTime = json['officeTime'] ?? false;
    name = json['name'] ?? '';
    about = json['about'] ?? '';
    dateTime = json['dateTime'] ?? '';
    lastActive = json['last_active'] ?? '';
    isOnline = json['is_online'] ?? false;
    recordId = json['recordID'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
    deviceToken = json['deviceToken'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['officeTime'] = officeTime;
    data['name'] = name;
    data['about'] = about;
    data['dateTime'] = dateTime;
    data['last_active'] = lastActive;
    data['is_online'] = isOnline;
    data['recordID'] = recordId;
    data['email'] = email;
    data['password'] = password;
    data['deviceToken'] = deviceToken;
    return data;
  }
}

class NotificationToken {
  String? recordID;
  String? deviceToken;
  String? email;

  NotificationToken({
    this.recordID,
    this.deviceToken,
    this.email,
  });

  NotificationToken.fromJson(Map<String, dynamic> json) {
    recordID = json['uId'] ?? '';
    deviceToken = json['deviceToken'] ?? '';
    email = json['email'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uId'] = recordID;
    data['deviceToken'] = deviceToken;
    data['email'] = email;
    return data;
  }
}
