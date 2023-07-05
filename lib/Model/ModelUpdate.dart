class ModelUpdate {
  int? id;
  String? email;
  Null? lastLogin;
  Null? lastActivity;
  int? role;
  String? gender;
  String? phoneNumber;
  Null? birthdate;
  Null? pin;
  String? message;
  String? stack;

  ModelUpdate(
      {this.id,
        this.email,
        this.lastLogin,
        this.lastActivity,
        this.gender,
        this.birthdate,
        this.phoneNumber,
        this.pin,
        this.message,
        this.stack,
        this.role
      });

  ModelUpdate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    lastLogin = json['lastLogin'];
    lastActivity = json['lastActivity'];
    gender = json['gender'];
    birthdate = json['birthdate'];
    pin = json['pin'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
    message = json['message'];
    stack = json['stack'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['lastLogin'] = this.lastLogin;
    data['lastActivity'] = this.lastActivity;
    data['gender'] = this.gender;
    data['birthdate'] = this.birthdate;
    data['pin'] = this.pin;
    data['role'] = this.role;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}