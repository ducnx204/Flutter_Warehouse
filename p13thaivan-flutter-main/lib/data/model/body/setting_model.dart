class SettingModel {
  String? referenceUrl;
  String? contactUrl;
  String? androidUrl;
  String? iosUrl;

  SettingModel({
      this.referenceUrl,
      this.contactUrl,
      this.androidUrl,
      this.iosUrl
      });

  SettingModel.fromJson(Map<String, dynamic> json) {
    referenceUrl = json['referenceUrl'].toString();
    contactUrl = json['contactUrl'].toString();
    androidUrl = json['androidUrl'].toString();
    iosUrl = json['iosUrl'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['referenceUrl'] = referenceUrl;
    data['contactUrl'] = contactUrl;
    data['androidUrl'] = androidUrl;
    data['iosUrl'] = iosUrl;
    return data;
  }
}
