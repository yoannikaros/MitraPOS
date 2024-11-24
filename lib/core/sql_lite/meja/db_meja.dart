import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'meja.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE meja(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nomor TEXT NOT NULL,
            posisiX REAL NOT NULL,
            posisiY REAL NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertMeja(Map<String, dynamic> data) async {
    final db = await database;

    // Hapus kolom 'id' sebelum memasukkan data
    final dataWithoutId = Map<String, dynamic>.from(data)..remove('id');

    return await db.insert('meja', dataWithoutId);
  }


  Future<List<Map<String, dynamic>>> getAllMeja() async {
    final db = await database;
    return await db.query('meja');
  }

  Future<int> updateMeja(int id, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update('meja', data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllMeja() async {
    final db = await database;
    return await db.delete('meja');
  }
}
