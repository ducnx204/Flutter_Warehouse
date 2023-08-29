class GenUserModel {
  String? username;

  GenUserModel({this.username});

  GenUserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    return data;
  }
}
