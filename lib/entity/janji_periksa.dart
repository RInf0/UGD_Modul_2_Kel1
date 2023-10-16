class JanjiPeriksa {
  final int? id;
  int? idPasien;
  String namaDokter, tglPeriksa, keluhan;

  JanjiPeriksa({
    this.id,
    this.idPasien,
    required this.namaDokter,
    required this.tglPeriksa,
    required this.keluhan,
  });
}
