class CloudModel {
  String? id;
  String? uId;
  String? email;
  String? deviceToken;

  CloudModel({
    this.id,
    this.uId = '',
    this.email = '',
    this.deviceToken = ''
  });

  factory CloudModel.fromJson(Map<String, dynamic> json) {
    return CloudModel(
      id: json.keys.first,
      uId: json.values.first['uId'] ?? '',
      email: json.values.first['email'] ?? '',
      deviceToken: json.values.first['deviceToken'] ?? '',
    );
  }
}