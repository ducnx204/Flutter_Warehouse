class EducateModel {
  String? fullname;
  String? born;
  String? address;
  String? phone;
  String? position;
  String? addressLearning;
  String? content;
  String? dateStartWorking;
  String? dateRegistration;

  EducateModel(
      {this.fullname,
      this.born,
      this.address,
      this.phone,
      this.position,
      this.addressLearning,
      this.content,
      this.dateStartWorking,
      this.dateRegistration});

  EducateModel.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'].toString();
    born = json['born'].toString();
    address = json['address'].toString();
    phone = json['phone'].toString();
    position = json['position'].toString();
    addressLearning = json['addressLearning'].toString();
    content = json['content'].toString();
    dateStartWorking = json['dateStartWorking'].toString();
    dateRegistration = json['dateRegistration'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = fullname;
    data['born'] = born;
    data['address'] = address;
    data['phone'] = phone;
    data['position'] = position;
    data['addressLearning'] = addressLearning;
    data['content'] = content;
    data['dateStartWorking'] = dateStartWorking;
    data['dateRegistration'] = dateRegistration;
    return data;
  }
}
