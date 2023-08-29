class ProductModel {
  String? idCategory;
  String? name;
  String? resource;
  String? madeIn;
  String? description;
  String? thumbnail;
  String? images;
  String? prices;
  String? prriceOrigin;
  String? type;
  String? id;

  ProductModel(
      {this.idCategory,
      this.name,
      this.resource,
      this.madeIn,
      this.description,
      this.thumbnail,
      this.images,
      this.prices,
      this.prriceOrigin,
      this.type,
      this.id});

  ProductModel.fromJson(Map<String, dynamic> json) {
    idCategory = json['idCategory'].toString();
    name = json['name'].toString();
    resource = json['resource'].toString();
    madeIn = json['madeIn'].toString();
    description = json['description'].toString();
    thumbnail = json['thumbnail'].toString();
    images = json['images'].toString();
    prices = json['prices'].toString();
    prriceOrigin = json['prriceOrigin'].toString();
    type = json['type'].toString();
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idCategory'] = idCategory;
    data['name'] = name;
    data['resource'] = resource;
    data['madeIn'] = madeIn;
    data['description'] = description;
    data['thumbnail'] = thumbnail;
    data['images'] = images;
    data['prices'] = prices;
    data['prriceOrigin'] = prriceOrigin;
    data['type'] = type;
    data['id'] = id;
    return data;
  }
}
