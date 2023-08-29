class SubTeamResponse {
  String? fullname;
  String? username;
  String? revenue;

  SubTeamResponse({
    this.fullname,
    this.username,
    this.revenue,
  });

  SubTeamResponse.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'].toString();
    username = json['username'].toString();
    revenue = json['revenue'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = fullname;
    data['username'] = username;
    data['revenue'] = revenue;
    return data;
  }
}
