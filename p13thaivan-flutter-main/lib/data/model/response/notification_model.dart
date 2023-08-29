class NotificationModel {
  int? _id;
  String? _title;
  String? _description;
  String? _image;
  int? _status;
  String? _createdAt;
  String? _updatedAt;

  NotificationModel(
      {int? id,
        String? title,
        String? description,
        String? image,
        int? status,
        String? createdAt,
        String? updatedAt}) {
    _id = id;
    _title = title;
    _description = description;
    _image = image;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get image => _image;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    _id = int.parse(json['id'].toString());
    _title = json['title'].toString();
    _description = json['description'].toString();
    _image = json['image'].toString();
    _status = int.parse(json['status'].toString());
    _createdAt = json['created_at'].toString();
    _updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['title'] = _title;
    data['description'] = _description;
    data['image'] = _image;
    data['status'] = _status;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}
