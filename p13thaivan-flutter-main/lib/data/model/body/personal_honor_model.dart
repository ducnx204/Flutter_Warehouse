class PersonalHonorModel {
  String? idContext;
  String? idUser;
  String? position;
  String? title;
  String? content;

  PersonalHonorModel({
      this.idContext,
      this.idUser,
      this.position,
      this.title,
      this.content
      });

  PersonalHonorModel.fromJson(Map<String, dynamic> json) {
    idContext = json['idContext'].toString();
    idUser = json['idUser'].toString();
    position = json['position'].toString();
    title = json['title'].toString();
    content = json['content'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idContext'] = idContext;
    data['idUser'] = idUser;
    data['position'] = position;
    data['title'] = title;
    data['content'] = content;
    return data;
  }
}
