class UserModel{

  String? uId;
  String? image;
  String? name;
  String? about;
  String? dateTime;
  String? lastActive;
  bool? isOnline;
  String? pushToken;
  String? email;
  String? password;
  String? deviceToken;
  String? recordId;

  UserModel({
    this.image,
    this.name,
    this.about,
    this.dateTime,
    this.uId,
    this.lastActive,
    this.isOnline,
    this.pushToken,
    this.email,
    this.password,
    this.deviceToken,
    this.recordId,
  });


  UserModel.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    about = json['about'] ?? '';
    dateTime = json['dateTime'] ?? '';
    uId = json['uId'] ?? '';
    lastActive = json['last_active'] ?? '';
    isOnline = json['is_online'] ?? false;
    pushToken = json['push_token'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
    deviceToken = json['deviceToken'] ?? '';
    recordId = json['recordId'] ?? '';
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
    data['push_token'] = pushToken;
    data['email'] = email;
    data['password'] = password;
    data['deviceToken'] = deviceToken;
    data['recordId'] = recordId;
    return data;
  }
}