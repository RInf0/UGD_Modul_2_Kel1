import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  // create db
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
    CREATE TABLE user(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      username TEXT,
      email TEXT,
      password TEXT,
      no_telp TEXT,
      tgl_lahir TEXT
      profilePicture TEXT
    )
    """);
  }

  // call db
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'user.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // insert user
  static Future<int> addUser(String username, String email, String password,
      String tglLahir, String noTelp) async {
    final db = await SQLHelper.db();
    final data = {
      'username': username,
      'email': email,
      'password': password,
      'tgl_lahir': tglLahir,
      'no_telp': noTelp,
    };
    return await db.insert(
      'user',
      data,
    );
  }

  // read user
  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await SQLHelper.db();
    return db.query(
      'user',
    );
  }

  // update user
  static Future<int> editUser(int id, String username, String email,
      String password, String tglLahir, String noTelp, String photo) async {
    final db = await SQLHelper.db();
    final data = {
      'username': username,
      'email': email,
      'password': password,
      'tgl_lahir': tglLahir,
      'no_telp': noTelp,
      'photoProfile': photo
    };
    return await db.update(
      'user',
      data,
      where: "id = $id",
    );
  }

  // delete user
  static Future<int> deleteUser(int id) async {
    final db = await SQLHelper.db();
    return await db.delete(
      'user',
      where: "id = $id",
    );
  }

  // cek unique email
  static Future<List<Map<String, dynamic>>> checkEmail(String email) async {
    final db = await SQLHelper.db();
    return await db.rawQuery("SELECT * FROM User WHERE email = '$email'");
  }

  //Edit Data
  static Future<void> editData(int? id, Map<String, dynamic> users) async {
    final db = await SQLHelper.db();
    await db
        .update('users', users, where: 'id = ?', whereArgs: [id.toString()]);
  }
}