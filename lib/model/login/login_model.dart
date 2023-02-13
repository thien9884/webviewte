class LoginModel {
  bool guest = true;
  String? username;
  String? password;
  bool rememberMe = true;

  LoginModel({
    this.guest = true,
    this.username,
    this.password,
    this.rememberMe = true,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    guest = json['guest'];
    username = json['username'];
    password = json['password'];
    rememberMe = json['remember_me'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['guest'] = guest;
    data['username'] = username;
    data['password'] = password;
    data['remember_me'] = rememberMe;
    return data;
  }
}
