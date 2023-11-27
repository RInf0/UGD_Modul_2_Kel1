import 'dart:convert';

class JanjiPeriksa {
  final int? id;
  int? idPasien;
  String namaDokter, tglPeriksa, keluhan;
  String? dokumen;

  JanjiPeriksa({
    this.id,
    this.idPasien,
    required this.namaDokter,
    required this.tglPeriksa,
    required this.keluhan,
    this.dokumen,
  });

  factory JanjiPeriksa.fromRawJson(String str) =>
      JanjiPeriksa.fromJson(json.decode(str));
  factory JanjiPeriksa.fromJson(Map<String, dynamic> json) => JanjiPeriksa(
        id: json["id"],
        idPasien: json["id_user"],
        namaDokter: json["dokter"],
        tglPeriksa: json["tgl_periksa"],
        keluhan: json["keluhan"],
        dokumen: json["image"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idPasien,
        "dokter": namaDokter,
        "tgl_periksa": tglPeriksa,
        "keluhan": keluhan,
        "image": dokumen,
      };
}
