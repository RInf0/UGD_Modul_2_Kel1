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
}
