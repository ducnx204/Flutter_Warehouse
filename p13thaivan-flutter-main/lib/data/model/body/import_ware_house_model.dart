class ImportWareHouseModel {
  String? idWarehouse;
  String? idProduct;
  String? dateImport;
  String? quantity;
  String? priceImport;

  ImportWareHouseModel({
      this.idWarehouse,
      this.idProduct,
      this.dateImport,
      this.quantity,
      this.priceImport
      });

  ImportWareHouseModel.fromJson(Map<String, dynamic> json) {
    idWarehouse = json['idWarehouse'].toString();
    idProduct = json['idProduct'].toString();
    dateImport = json['dateImport'].toString();
    quantity = json['quantity'].toString();
    priceImport = json['priceImport'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idWarehouse'] = idWarehouse;
    data['idProduct'] = idProduct;
    data['dateImport'] = dateImport;
    data['quantity'] = quantity;
    data['priceImport'] = priceImport;
    return data;
  }
}
