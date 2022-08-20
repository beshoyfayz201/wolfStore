import 'dart:convert';

import 'package:shoptemp/models/consts.dart';

class LoginModel {
  bool? status;
  String? message;
  User? data;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (status != null) {
      result.addAll({'status': status});
    }
    if (message != null) {
      result.addAll({'message': message});
    }
    if (data != null) {
      result.addAll({'data': data!.toMap()});
    }

    return result;
  }

  LoginModel.fromMap(Map<String, dynamic> map) {
    status = map['status'];
    message = map['message'];
    data = User.fromMap(map['data']);
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source));
}

class User {
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String tokken;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.tokken,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phone': phone});
    result.addAll({'image': image});
    result.addAll({'points': points});
    result.addAll({'credit': credit});
    result.addAll({'tokken': tokken});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      image: map['image'] ?? '',
      points: map['points']?.toInt() ?? 0,
      credit: map['credit']?.toInt() ?? 0,
      tokken: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
