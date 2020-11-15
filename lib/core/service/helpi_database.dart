import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HelpiDatabase extends GetxService {
  var logger = Logger();
  // HelpiDatabase._internal();
  // factory HelpiDatabase() => _instance;

  // static final HelpiDatabase _instance = HelpiDatabase._internal();
  static const String _DB_NAME = 'helpi';
  static const int _DB_VERSION = 1;
  static const String TABLE_BUTTONS = "buttons";
  static const String TABLE_CONTACTS = "contacts";

  Future<Database> _database;

  Future<Database> get database {
    logger.d('database');
    return _database ??= this.initializeDatabase();
  }

  Future<Database> initializeDatabase() async {
    logger.d('initializeDatabase');
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, "$_DB_NAME.db");

    _onCreate(Database database, int version) async {
      await database.execute('''
          CREATE TABLE IF NOT EXISTS $TABLE_BUTTONS (
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL UNIQUE
          );
          
          CREATE TABLE IF NOT EXISTS $TABLE_CONTACTS (
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL,
          phone_number TEXT NOT NULL,
          button_id INTEGER NOT NULL
          );
          ''');
    }

    this._database = openDatabase(
      path,
      version: _DB_VERSION,
      onCreate: _onCreate,
      onDowngrade: onDatabaseDowngradeDelete,
    );
    return this._database;
  }
}
