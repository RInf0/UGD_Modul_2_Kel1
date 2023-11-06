import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperJanjiPeriksa {
  // create db
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
    CREATE TABLE janji_periksa(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      id_pasien INTEGER,
      nama_dokter TEXT,
      tgl_periksa TEXT,
      keluhan TEXT,
      dokumen TEXT
    )
    """);
  }

  // call db
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'janji_periksa.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // insert janji_periksa
  static Future<int> addJanjiPeriksa(
      int idPasien, String namaDokter, String tglPeriksa, String keluhan,
      {String dokumen = ''}) async {
    final db = await SQLHelperJanjiPeriksa.db();
    final data = {
      'id_pasien': idPasien,
      'nama_dokter': namaDokter,
      'tgl_periksa': tglPeriksa,
      'keluhan': keluhan,
      'dokumen': dokumen,
    };
    return await db.insert(
      'janji_periksa',
      data,
    );
  }

  // read janji_periksa (ALL)
  static Future<List<Map<String, dynamic>>> getJanjiPeriksa() async {
    final db = await SQLHelperJanjiPeriksa.db();
    return db.query(
      'janji_periksa',
    );
  }

  // read janji_periksa by id user
  static Future<List<Map<String, dynamic>>> getJanjiPeriksaById(int id) async {
    final db = await SQLHelperJanjiPeriksa.db();
    return db.query(
      'janji_periksa',
      where: "id_pasien = $id",
    );
  }

  // update janji_periksa
  static Future<int> editJanjiPeriksa(int id, int idPasien, String namaDokter,
      String tglPeriksa, String keluhan,
      {String dokumen = ''}) async {
    final db = await SQLHelperJanjiPeriksa.db();

    var data = {
      'id_pasien': idPasien,
      'nama_dokter': namaDokter,
      'tgl_periksa': tglPeriksa,
      'keluhan': keluhan,
    };

    // jika ada request edit image dokumen
    if (dokumen != '') {
      data = {
        'id_pasien': idPasien,
        'nama_dokter': namaDokter,
        'tgl_periksa': tglPeriksa,
        'keluhan': keluhan,
        'dokumen': dokumen,
      };
    }

    return await db.update(
      'janji_periksa',
      data,
      where: "id = $id",
    );
  }

  // delete janji_periksa
  static Future<int> deleteJanjiPeriksa(int id) async {
    final db = await SQLHelperJanjiPeriksa.db();
    return await db.delete(
      'janji_periksa',
      where: "id = $id",
    );
  }
}
