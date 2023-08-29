class AuthRequest {
  String? username;
  String? password;

  AuthRequest({
    this.username,
    this.password,
  });

  AuthRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'].toString();
    password = json['password'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
