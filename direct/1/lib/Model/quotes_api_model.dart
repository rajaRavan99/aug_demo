// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<Datum>? data;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.categoryId,
    this.thumbnailImage,
    this.image,
    this.priority,
  });

  int? id;
  int? categoryId;
  String? thumbnailImage;
  String? image;
  int? priority;


  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    categoryId: json["category_id"],
    thumbnailImage: json["thumbnail_image"],
    image: json["image"],
    priority: json["priority"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "thumbnail_image": thumbnailImage,
    "image": image,
    "priority": priority,
  };
}
