class OrderItemResponseModel {
  String? idOrder;
  IdProduct? idProduct;
  String? quantity;
  String? price;
  String? createdAt;
  String? updatedAt;
  String? id;

  OrderItemResponseModel({
    this.idOrder,
    this.idProduct,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory OrderItemResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderItemResponseModel(
        idOrder: json['idOrder'] as String?,
        idProduct: json['idProduct'] == null
            ? null
            : IdProduct.fromJson(json['idProduct'] as Map<String, dynamic>),
        quantity: json['quantity'].toString(),
        price: json['price'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'idOrder': idOrder,
        'idProduct': idProduct?.toJson(),
        'quantity': quantity,
        'price': price,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'id': id,
      };
}

class IdProduct {
  String? idCategory;
  String? name;
  String? resource;
  String? type;
  String? madeIn;
  String? description;
  String? thumbnail;
  String? images;
  String? prices;
  String? prriceOrigin;
  String? createdAt;
  String? updatedAt;
  String? id;

  IdProduct({
    this.idCategory,
    this.name,
    this.resource,
    this.type,
    this.madeIn,
    this.description,
    this.thumbnail,
    this.images,
    this.prices,
    this.prriceOrigin,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory IdProduct.fromJson(Map<String, dynamic> json) => IdProduct(
        idCategory: json['idCategory'] as String?,
        name: json['name'] as String?,
        resource: json['resource'] as String?,
        type: json['type'] as String?,
        madeIn: json['madeIn'] as String?,
        description: json['description'] as String?,
        thumbnail: json['thumbnail'] as String?,
        images: json['images'] as String?,
        prices: json['prices'] as String?,
        prriceOrigin: json['prriceOrigin'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'idCategory': idCategory,
        'name': name,
        'resource': resource,
        'type': type,
        'madeIn': madeIn,
        'description': description,
        'thumbnail': thumbnail,
        'images': images,
        'prices': prices,
        'prriceOrigin': prriceOrigin,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'id': id,
      };
}
