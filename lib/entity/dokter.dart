import 'dart:convert';

class Dokter {
  final int? id;
  String? nama, noTelp, job;

  Dokter({
    this.id,
    this.nama,
    this.noTelp,
    this.job,
  });

  factory Dokter.fromRawJson(String str) => Dokter.fromJson(json.decode(str));
  factory Dokter.fromJson(Map<String, dynamic> json) => Dokter(
        id: json["id"],
        nama: json["nama"],
        noTelp: json["no_telp"],
        job: json["job"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "no_telp": noTelp,
        "job": job,
      };
}
