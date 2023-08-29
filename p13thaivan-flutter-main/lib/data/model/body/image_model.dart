class ImageUpdateModel {
  String? id;
  String? data;

  ImageUpdateModel({this.id, this.data});

  ImageUpdateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    data = json['data'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['data'] = data;
    return data;
  }
}
