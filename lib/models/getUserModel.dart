class GetUserModel {
  List<GetUsers>? getUsers;

  GetUserModel({this.getUsers});

  GetUserModel.fromJson(Map<String, dynamic> json) {
    if (json['getUsers'] != null) {
      getUsers = <GetUsers>[];
      json['getUsers'].forEach((v) {
        getUsers!.add(new GetUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getUsers != null) {
      data['getUsers'] = this.getUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetUsers {
  String? sId;
  String? firstName;
  String? lastName;
  int? phoneNumber;
  String? email;
  String? password;
  String? role;
  bool? blocked;
  int? accountNumber;
  String? createdAt;
  String? updatedAt;
  int? iV;

  GetUsers(
      {this.sId,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.password,
      this.role,
      this.blocked,
      this.accountNumber,
      this.createdAt,
      this.updatedAt,
      this.iV});

  GetUsers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    blocked = json['blocked'];
    accountNumber = json['accountNumber'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role'] = this.role;
    data['blocked'] = this.blocked;
    data['accountNumber'] = this.accountNumber;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
