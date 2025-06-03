import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Kullanıcı veritabanı işlemlerini yöneten sınıf
class UserDbHelper {
  // Veritabanı instance'ı ve tablo adı
  static Database? _database;
  static const String tableName = 'users';

  // Veritabanı instance'ını döndüren getter
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  // Veritabanını başlatan fonksiyon
  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'user_data.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $tableName(uid TEXT PRIMARY KEY, name TEXT, surname TEXT, email TEXT, dateOfBirth TEXT, placeOfBirth TEXT, city TEXT)"
        );
      },
    );
  }

  // Kullanıcı bilgilerini veritabanına ekleyen fonksiyon
  Future<void> insertUser(User user, Map<String, dynamic> userData) async {
    final db = await database;
    await db.insert(
      tableName,
      {
        'uid': user.uid,
        'name': userData['name'],
        'surname': userData['surname'],
        'email': user.email,
        'dateOfBirth': userData['dateOfBirth']?.toIso8601String(), // Convert DateTime to String
        'placeOfBirth': userData['placeOfBirth'],
        'city': userData['city'],
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // You can add methods here to retrieve user data from the database
  Future<Map<String, dynamic>?> getUser(String uid) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'uid = ?',
      whereArgs: [uid],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return null;
    }
  }

  // Add a method to close the database when the app is closed
  Future<void> closeDb() async {
    final db = await database;
    db.close();
  }
} 