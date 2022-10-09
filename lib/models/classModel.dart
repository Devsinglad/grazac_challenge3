class ClassModel {
  GetUser? getUser;

  ClassModel({this.getUser});

  ClassModel.fromJson(Map<String, dynamic> json) {
    getUser =
        json['getUser'] != null ? new GetUser.fromJson(json['getUser']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getUser != null) {
      data['getUser'] = this.getUser!.toJson();
    }
    return data;
  }
}

class GetUser {
  String? sId;
  int? accountNumber;

  GetUser({this.sId, this.accountNumber});

  GetUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    accountNumber = json['accountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['accountNumber'] = this.accountNumber;
    return data;
  }
}
