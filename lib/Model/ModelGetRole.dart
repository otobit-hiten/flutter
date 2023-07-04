class ModelGetRoles {
  bool? success;
  List<DataRoles>? data;
  String? message;

  ModelGetRoles({this.success, this.data, this.message});

  ModelGetRoles.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataRoles>[];
      json['data'].forEach((v) {
        data!.add(DataRoles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataRoles {
  int? id;
  String? name;
  String? createdAt;

  DataRoles({this.id, this.name, this.createdAt});

  DataRoles.fromJson(Map<String, dynamic> json) {
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