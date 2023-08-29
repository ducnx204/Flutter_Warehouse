class OrderItemModel {
  String? id;
  String? idOrder;
  String? idProduct;
  String? quantity;
  String? price;
  String? createdAt;
  String? updatedAt;

  OrderItemModel(
      {this.id,
      this.idOrder,
      this.idProduct,
      this.quantity,
      this.price,
      this.createdAt,
      this.updatedAt});

  OrderItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idOrder = json['idOrder'].toString();
    idProduct = json['idProduct'].toString();
    quantity = json['quantity'].toString();
    price = json['price'].toString();
    createdAt = json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['idOrder'] = idOrder;
    data['idProduct'] = idProduct;
    data['quantity'] = quantity;
    data['price'] = price;
    // data['createdAt'] = createdAt;
    // data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonPut() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idOrder'] = idOrder;
    // data['idProduct'] = idProduct;
    data['quantity'] = quantity;
    data['price'] = price;
    // data['createdAt'] = createdAt;
    // data['updatedAt'] = updatedAt;
    return data;
  }
}
