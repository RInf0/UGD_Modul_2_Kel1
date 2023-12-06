import 'dart:convert';

class PesanKamar {
  final int? id;
  int? idUser;
  String kelas, spesialisasi, usia, tglPesan;

  PesanKamar({
    this.id,
    this.idUser,
    required this.kelas,
    required this.spesialisasi,
    required this.usia,
    required this.tglPesan,
  });

  factory PesanKamar.fromRawJson(String str) => PesanKamar.fromJson(json.decode(str));
  factory PesanKamar.fromJson(Map<String, dynamic> json) => PesanKamar(
    id: json["id"],
    idUser: json["id_user"],
    kelas: json["kelas"], 
    spesialisasi: json["spesialisasi"], 
    usia: json["usia"], 
    tglPesan: json["tgl_pesan"],
    );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    "id": id,
    "id_user": idUser,
    "kelas": kelas,
    "spesialisasi": spesialisasi,
    "usia": usia,
    "tgl_pesan": tglPesan,
  };
}