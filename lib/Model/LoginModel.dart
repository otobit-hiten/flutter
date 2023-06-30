class LoginModel {
  bool? success;
  String? message;
  String? name;
  String? stack;
  Data? data;

  LoginModel({this.success, this.data, this.name, this.message, this.stack});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    name = json['name'];
    stack = json['stack'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['name'] = this.name;
    data['stack'] = this.stack;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? accessToken;
  String? refreshToken;
  User? user;

  Data({this.accessToken, this.refreshToken, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? phoneNumber;
  String? email;
  bool? isLocked;
  String? lastLogin;
  Null? lastActivity;
  String? gender;
  String? birthdate;
  String? createdAt;
  Role? role;

  User(
      {this.id,
        this.name,
        this.phoneNumber,
        this.email,
        this.isLocked,
        this.lastLogin,
        this.lastActivity,
        this.gender,
        this.birthdate,
        this.createdAt,
        this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    isLocked = json['isLocked'];
    lastLogin = json['lastLogin'];
    lastActivity = json['lastActivity'];
    gender = json['gender'];
    birthdate = json['birthdate'];
    createdAt = json['createdAt'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['isLocked'] = this.isLocked;
    data['lastLogin'] = this.lastLogin;
    data['lastActivity'] = this.lastActivity;
    data['gender'] = this.gender;
    data['birthdate'] = this.birthdate;
    data['createdAt'] = this.createdAt;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    return data;
  }
}

class Role {
  int? id;
  String? name;
  String? createdAt;

  Role({this.id, this.name, this.createdAt});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    return data;
  }
}