class GetUserTotalModel {
  int? usercount;

  GetUserTotalModel({this.usercount});

  GetUserTotalModel.fromJson(Map<String, dynamic> json) {
    usercount = json['usercount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usercount'] = this.usercount;
    return data;
  }
}
