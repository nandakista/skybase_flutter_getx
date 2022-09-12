class User {
  int? id;
  String? token;
  String? refreshToken;

  User({
    this.id,
    this.token,
    this.refreshToken,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      id: json['id'],
      token: json['token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'refresh_token': refreshToken,
  };
}
