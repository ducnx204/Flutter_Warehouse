class RoleModel {
  String? name;

  RoleModel({
      this.name
      });

  RoleModel.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
