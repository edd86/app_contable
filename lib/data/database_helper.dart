import 'package:app_contable/data/sqlite_code.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._instance;

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase('contable.db');
    return _database!;
  }

  Future<Database> _initDatabase(String dbName) async {
    final path = await getDatabasesPath();

    ///Cambiar el path
    final dbPath = '$path/$dbName';
    return await openDatabase(dbPath, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute(createUserTable);
    await db.execute(createTransactionTable);
    await db.execute(createIncomesTable);
    await db.execute(createExpensesTable);
    await db.execute(createDebtsTable);
    await db.execute(createBudgetsTable);
  }
}
