class ModelGetUserById {
  bool? success;
  UsersData? data;

  ModelGetUserById({this.success, this.data});

  ModelGetUserById.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new UsersData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UsersData {
  int? id;
  String? name;
  String? phoneNumber;
  String? email;
  bool? isLocked;
  String? lastLogin;
  Null? lastActivity;
  String? gender;
  String? birthdate;
  String? pin;
  String? createdAt;
  Role? role;

  UsersData(
      {this.id,
        this.name,
        this.phoneNumber,
        this.email,
        this.isLocked,
        this.lastLogin,
        this.lastActivity,
        this.gender,
        this.birthdate,
        this.pin,
        this.createdAt,
        this.role});

  UsersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    isLocked = json['isLocked'];
    lastLogin = json['lastLogin'];
    lastActivity = json['lastActivity'];
    gender = json['gender'];
    birthdate = json['birthdate'];
    pin = json['pin'];
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
    data['pin'] = this.pin;
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