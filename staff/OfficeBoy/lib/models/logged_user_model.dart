class LoggedUserModel {
  String? uId;
  String? image;
  String? name;
  String? about;
  String? dateTime;
  String? lastActive;
  bool? isOnline;
  String? recordID;
  String? email;
  String? password;
  String? deviceToken;

  LoggedUserModel({
    this.image,
    this.name,
    this.about,
    this.dateTime,
    this.uId,
    this.lastActive,
    this.isOnline,
    this.recordID,
    this.email,
    this.password,
    this.deviceToken,
  });


  LoggedUserModel.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    about = json['about'] ?? '';
    dateTime = json['dateTime'] ?? '';
    uId = json['uId'] ?? '';
    lastActive = json['last_active'] ?? '';
    isOnline = json['is_online'] ?? false;
    recordID = json['recordID'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
    deviceToken = json['deviceToken'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['about'] = about;
    data['dateTime'] = dateTime;
    data['uId'] = uId;
    data['last_active'] = lastActive;
    data['is_online'] = isOnline;
    data['recordID'] = recordID;
    data['email'] = email;
    data['password'] = password;
    data['deviceToken'] = deviceToken;
    return data;
  }
}