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
  String? nik;
  String? gender;
  String? address;
  String? province;
  String? city;
  String? district;
  String? kodePos;
  String? marriageStatus;

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
    this.nik,
    this.gender,
    this.address,
    this.province,
    this.city,
    this.district,
    this.kodePos,
    this.marriageStatus,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    dynamic selfieValue;
    if(json['selfie_value'] == "<nil>") {
      selfieValue = "";
    } else {
      selfieValue = json['selfie_value'];
    }
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
      marriageStatus: json['status_nikah'],
      nik: json['no_nik'],
      address: json['alamat'],
      province: json['prov'],
      city: json['kotkab'],
      district: json['kecamatan'],
      kodePos: json['kodepos'],
    );
  }

  Map<String, dynamic> toJson() => {
    "ID": id,
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
    "status_nikah": marriageStatus,
    "no_nik": nik,
    "alamat": address,
    "prov": province,
    "kotkab": city,
    "kecamatan": district,
    "kodepos": kodePos,
  };
}
