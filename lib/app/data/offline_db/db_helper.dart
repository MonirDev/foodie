import 'dart:async';
import 'dart:io';
import 'package:foodie/app/utils/strings.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  final String tableName = 'favorites';
  final String columnId = Strings.idKey;
  final String columnTitle = Strings.titleKey;
  final String columnUrl = Strings.imgUrlKey;
  final String columnDescription = Strings.descriptionKey;
  final String columnPrice = Strings.priceKey;
  final String columnCategory = Strings.categoryKey;
  final String columnRatings = Strings.ratingsKey;
  final String columnFavorite = Strings.favoriteKey;

  DatabaseHelper.internal();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "favorites.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      '''CREATE TABLE $tableName(
        $columnId TEXT PRIMARY KEY, 
        $columnTitle TEXT, 
        $columnUrl TEXT, 
        $columnDescription TEXT,
        $columnPrice REAL,
        $columnCategory TEXT,
        $columnRatings REAL,
        $columnFavorite INTEGER
        )''',
    );
  }

//add product to DB
  Future<int> addFood(Map<String, dynamic> food) async {
    var dbClient = await db;
    int res = await dbClient!.insert(tableName, food);
    return res;
  }

//get all DB product
  Future<List<Map<String, dynamic>>> getFavorites() async {
    var dbClient = await db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnTitle,
      columnUrl,
      columnDescription,
      columnPrice,
      columnCategory,
      columnRatings,
      columnFavorite,
    ]);
    return result;
  }

  //remove product fromDB
  Future<int> deleteProduct(String id) async {
    var dbClient = await db;
    int res = await dbClient!.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return res;
  }
}
