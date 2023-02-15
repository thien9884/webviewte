class LoginModel {
  bool guest = false;
  String? username;
  String? password;
  bool rememberMe = false;

  LoginModel({
    this.guest = false,
    this.username,
    this.password,
    this.rememberMe = false,
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
