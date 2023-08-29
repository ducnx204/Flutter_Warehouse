import 'id_context.dart';
import 'id_user.dart';

class PersonalHonorsResponseModel {
  IdContext? idContext;
  IdUser? idUser;
  String? position;
  String? title;
  String? content;
  String? createdAt;
  String? updatedAt;
  String? id;

  PersonalHonorsResponseModel({
    this.idContext,
    this.idUser,
    this.position,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory PersonalHonorsResponseModel.fromJson(Map<String, dynamic> json) =>
      PersonalHonorsResponseModel(
        idContext: json['idContext'] == null
            ? null
            : IdContext.fromJson(json['idContext'] as Map<String, dynamic>),
        idUser: json['idUser'] == null
            ? null
            : IdUser.fromJson(json['idUser'] as Map<String, dynamic>),
        position: json['position'] as String?,
        title: json['title'] as String?,
        content: json['content'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'idContext': idContext?.toJson(),
        'idUser': idUser?.toJson(),
        'position': position,
        'title': title,
        'content': content,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'id': id,
      };
}
