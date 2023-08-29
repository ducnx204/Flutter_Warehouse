class ProvinceModel {
  String? id;
  String? name;
  String? type;

  ProvinceModel({this.id, this.name, this.type});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    type = json['type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}
