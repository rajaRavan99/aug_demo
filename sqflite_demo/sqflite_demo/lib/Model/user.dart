import '../DbHelper/DBHelper.dart';

class User {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? address;
  // String? age;
  // String? gender;


  User({this.id,this.name, this.mobile, this.email, this.address,
    // this.age, this.gender,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    // age = json['age'];
    // gender = json['gender'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['address'] = this.address;
    // data['age'] = this.age;
    // data['gender'] = this.gender;

    return data;
  }
}