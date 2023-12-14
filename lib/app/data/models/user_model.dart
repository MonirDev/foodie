class UserModel {
  final String? uId;
  final String? name;
  final String? email;
  final String? password;

  UserModel({
    this.uId,
    this.name,
    this.email,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uId: json["uId"] ?? '',
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "uId": uId,
        "name": name,
        "email": email,
        "password": password,
      };
}
