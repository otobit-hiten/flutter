// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool success;
  Data data;

  LoginModel({
    required this.success,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  String accessToken;
  String refreshToken;
  User user;

  Data({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "user": user.toJson(),
  };
}

class User {
  int id;
  String name;
  String phoneNumber;
  String email;
  bool isLocked;
  DateTime lastLogin;
  dynamic lastActivity;
  String gender;
  DateTime birthdate;
  DateTime createdAt;
  Role role;

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.isLocked,
    required this.lastLogin,
    this.lastActivity,
    required this.gender,
    required this.birthdate,
    required this.createdAt,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    isLocked: json["isLocked"],
    lastLogin: DateTime.parse(json["lastLogin"]),
    lastActivity: json["lastActivity"],
    gender: json["gender"],
    birthdate: DateTime.parse(json["birthdate"]),
    createdAt: DateTime.parse(json["createdAt"]),
    role: Role.fromJson(json["role"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phoneNumber": phoneNumber,
    "email": email,
    "isLocked": isLocked,
    "lastLogin": lastLogin.toIso8601String(),
    "lastActivity": lastActivity,
    "gender": gender,
    "birthdate": "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
    "createdAt": createdAt.toIso8601String(),
    "role": role.toJson(),
  };
}

class Role {
  int id;
  String name;
  DateTime createdAt;

  Role({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "createdAt": createdAt.toIso8601String(),
  };
}
