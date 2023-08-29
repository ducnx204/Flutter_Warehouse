class NewsModel {
  String? name;
  String? image;
  String? body;
  String? tags;
  String? endAt;
  String? idCategoryNews;
  String? id;
  String? createdAt;

  NewsModel({
    this.name,
    this.image,
    this.body,
    this.tags,
    this.endAt,
    this.idCategoryNews,
    this.id,
    this.createdAt,
  });

  NewsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    image = json['image'].toString();
    body = json['body'].toString();
    tags = json['tags'].toString();
    endAt = json['endAt'].toString();
    idCategoryNews = json['idCategoryNews'].toString();
    id = json['id'].toString();
    createdAt = json['created_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['body'] = body;
    data['tags'] = tags;
    data['endAt'] = endAt;
    data['idCategoryNews'] = idCategoryNews;
    return data;
  }
}
