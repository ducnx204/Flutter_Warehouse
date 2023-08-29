class WarehouseModel {
  String? idProvince;
  String? idDistrict;
  String? idUser;
  String? idWarehouse;
  String? name;
  String? address;
  String? area;
  String? oda;

  WarehouseModel({
      this.idProvince,
      this.idDistrict,
      this.idUser,
      this.idWarehouse,
      this.name,
      this.address,
      this.area,
      this.oda
      });

  WarehouseModel.fromJson(Map<String, dynamic> json) {
    idProvince = json['idProvince'].toString();
    idDistrict = json['idDistrict'].toString();
    idUser = json['idUser'].toString();
    idWarehouse = json['idWarehouse'].toString();
    name = json['name'].toString();
    address = json['address'].toString();
    area = json['area'].toString();
    oda = json['oda'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idProvince'] = idProvince;
    data['idDistrict'] = idDistrict;
    data['idUser'] = idUser;
    data['idWarehouse'] = idWarehouse;
    data['name'] = name;
    data['address'] = address;
    data['area'] = area;
    data['oda'] = oda;
    return data;
  }
}
