class OrderModel {
  String? idUser;
  String? userAccept;
  String? idWarehouse;
  String? description;
  String? imagePayment;
  String? statusOrder;
  String? statusPayment;
  String? totalPrice;
  String? discountPrice;
  String? idProvince;
  String? idDistrict;
  String? address;
  // String? isChangeStatus;
  String? id;
  String? updatedAt;

  OrderModel(
      {this.idUser,
      this.userAccept,
      this.idWarehouse,
      this.description,
      this.imagePayment,
      this.statusOrder,
      this.statusPayment,
      this.totalPrice,
      this.discountPrice,
      this.idProvince,
      this.idDistrict,
      this.address,
      // this.isChangeStatus,
      this.id,
      this.updatedAt});

  OrderModel.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'].toString();
    userAccept = json['userAccept'].toString();
    idWarehouse = json['idWarehouse'].toString();
    description = json['description'].toString();
    imagePayment = json['imagePayment'].toString();
    statusOrder = json['statusOrder'].toString();
    statusPayment = json['statusPayment'].toString();
    totalPrice = json['totalPrice'].toString();
    discountPrice = json['discountPrice'].toString();
    idProvince = json['idProvince'].toString();
    idDistrict = json['idDistrict'].toString();
    address = json['address'].toString();
    // isChangeStatus = json['isChangeStatus'].toString();
    id = json['id'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUser'] = idUser;
    data['userAccept'] = userAccept;
    data['idWarehouse'] = idWarehouse;
    data['description'] = description;
    data['imagePayment'] = imagePayment;
    data['statusOrder'] = statusOrder;
    data['statusPayment'] = statusPayment;
    data['totalPrice'] = totalPrice;
    data['discountPrice'] = discountPrice;
    data['idProvince'] = idProvince;
    data['idDistrict'] = idDistrict;
    data['address'] = address;
    // data['isChangeStatus'] = isChangeStatus;
    // data['id'] = id;
    return data;
  }

  Map<String, dynamic> toJsonPut() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUser'] = idUser;
    data['userAccept'] = userAccept;
    data['idWarehouse'] = idWarehouse;
    data['description'] = description;
    data['imagePayment'] = imagePayment;
    data['statusOrder'] = statusOrder;
    data['statusPayment'] = statusPayment;
    data['totalPrice'] = totalPrice;
    data['discountPrice'] = discountPrice;
    data['idProvince'] = idProvince;
    data['idDistrict'] = idDistrict;
    data['address'] = address;
    // data['isChangeStatus'] = isChangeStatus;
    data['id'] = id;
    return data;
  }

  Map<String, dynamic> haveIDtoJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUser'] = idUser;
    data['userAccept'] = userAccept;
    data['idWarehouse'] = idWarehouse;
    data['description'] = description;
    data['imagePayment'] = imagePayment;
    data['statusOrder'] = statusOrder;
    data['statusPayment'] = statusPayment;
    data['totalPrice'] = totalPrice;
    data['discountPrice'] = discountPrice;
    data['idProvince'] = idProvince;
    data['idDistrict'] = idDistrict;
    data['address'] = address;
    // data['isChangeStatus'] = isChangeStatus;
    data['id'] = id;
    return data;
  }
}
