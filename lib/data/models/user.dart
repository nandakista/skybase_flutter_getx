class User {
  int? id;
  String? token;
  String? refreshToken;
  String? email;
  String? phone;
  bool? isLogin;
  bool? isActiveEmail;

  // Biodata
  String? name;
  String? birthPlace;
  String? birthDate;
  String? gender;
  String? address;

  User({
    this.id,
    this.token,
    this.refreshToken,
    this.email,
    this.phone,
    this.isLogin,
    this.isActiveEmail,

    // Biodata
    this.name,
    this.birthPlace,
    this.birthDate,
    this.gender,
    this.address,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      id: json['id'],
      token: json['token'],
      refreshToken: json['refresh_token'],
      email: json['email'],
      phone: json['phone'],
      isLogin: json['active'],
      isActiveEmail: json['active_email'],

      // Biodata
      name: json['nama'],
      birthPlace: json['tempat_lahir'],
      birthDate: json['tanggal_lahir'],
      gender: json['gender'],
      address: json['alamat'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
    "refresh_token": refreshToken,
    "email": email,
    "phone": phone,
    "active": isLogin,
    "active_email": isActiveEmail,

    // Biodata
    "nama": name,
    "tempat_lahir": birthPlace,
    "tanggal_lahir": birthDate,
    "gender": gender,
    "alamat": address,
  };
}
