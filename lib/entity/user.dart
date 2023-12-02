import 'dart:convert';

class LoginModel {
  final int status;
  final String message;
  final User data;

  const LoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromRawJson(String str) =>
      LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        data: User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class User {
  final int? id;
  String? username, email, password, tglLahir, noTelp;
  String? profilePhoto;

  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.tglLahir,
    this.noTelp,
    this.profilePhoto,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["name"],
        email: json["email"],
        password: json["password"],
        tglLahir: json["tgl_lahir"],
        noTelp: json["no_telp"],
        profilePhoto: json["profile_photo"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": username,
        "email": email,
        "password": password,
        "tgl_lahir": tglLahir,
        "no_telp": noTelp,
        "profile_photo": profilePhoto,
      };
}
