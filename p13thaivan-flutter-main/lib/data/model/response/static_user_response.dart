class StaticUserResponse {
  double? doanhSoDoiNhom;
  double? doanSoCaNhan;
  String? soLuongId;
  String? soLuongDonHang;

  StaticUserResponse(
      {this.doanhSoDoiNhom,
      this.doanSoCaNhan,
      this.soLuongId,
      this.soLuongDonHang});

  StaticUserResponse.fromJson(Map<String, dynamic> json) {
    doanhSoDoiNhom = double.parse(json['doanhSoDoiNhom'].toString());
    doanSoCaNhan = double.parse(json['doanSoCaNhan'].toString());
    soLuongId = json['soLuongId'].toString();
    soLuongDonHang = json['soLuongDonHang'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doanhSoDoiNhom'] = doanhSoDoiNhom;
    data['doanSoCaNhan'] = doanSoCaNhan;
    data['soLuongId'] = soLuongId;
    data['soLuongDonHang'] = soLuongDonHang;
    return data;
  }
}
