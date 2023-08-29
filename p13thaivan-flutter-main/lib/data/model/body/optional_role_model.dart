class OptionalRoleModel {
  String? idRole;
  String? name;
  String? salary;
  String? condition;
  String? description;
  String? bonus;
  String? conditionBonus;
  String? descriptionBonus;

  OptionalRoleModel({
      this.idRole,
      this.name,
      this.salary,
      this.condition,
      this.description,
      this.bonus,
      this.conditionBonus,
      this.descriptionBonus
      });

  OptionalRoleModel.fromJson(Map<String, dynamic> json) {
    idRole = json['idRole'].toString();
    name = json['name'].toString();
    salary = json['salary'].toString();
    condition = json['condition'].toString();
    description = json['description'].toString();
    bonus = json['bonus'].toString();
    conditionBonus = json['conditionBonus'].toString();
    descriptionBonus = json['descriptionBonus'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idRole'] = idRole;
    data['name'] = name;
    data['salary'] = salary;
    data['condition'] = condition;
    data['description'] = description;
    data['bonus'] = bonus;
    data['conditionBonus'] = conditionBonus;
    data['descriptionBonus'] = descriptionBonus;
    return data;
  }
}
