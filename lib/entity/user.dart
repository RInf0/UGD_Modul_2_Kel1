import 'dart:convert';

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
