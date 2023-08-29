class CategoryNewsModel {
  String? name;
  String? slug;
  String? id;

  CategoryNewsModel({this.name, this.slug, this.id});

  CategoryNewsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    slug = json['slug'].toString();
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['slug'] = slug;
    data['id'] = id;
    return data;
  }
}
