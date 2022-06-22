class User {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;
  bool? isActiveEmail;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.isActiveEmail,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
      isActiveEmail: json['active_email'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'first_name': firstName,
    'last_name': lastName,
    'avatar': avatar,
    'active_email': isActiveEmail,
  };
}
