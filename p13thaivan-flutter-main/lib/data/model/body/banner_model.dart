class BannerModel {
  String? imageUrl;
  String? status;

  BannerModel({
      this.imageUrl,
      this.status
      });

  BannerModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    data['status'] = status;
    return data;
  }
}
