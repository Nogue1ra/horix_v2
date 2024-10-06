import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  // Inicialização do banco de dados
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Criação do banco de dados e da tabela "users" e "points"
  Future<Database> _initDatabase() async {
  final path = await getDatabasesPath();
  return openDatabase(
    join(path, 'points.db'),
    onCreate: (db, version) async {
      await db.execute(
        '''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          full_name TEXT,
          cpf NUMBER UNIQUE,
          password TEXT,
          email TEXT
        )
        ''',
      );
      await db.execute(
        '''
        CREATE TABLE points(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          timestamp TEXT,
          latitude REAL,
          longitude REAL
        )
        ''',
      );
    },
    version: 1,
  );
}


  // Método para registrar um novo usuário
  Future<void> registerUser(String fullName, String cpf, String password, String email) async {
    final db = await database;
    await db.insert(
      'users',
      {
        'full_name': fullName,
        'cpf': cpf,
        'password': password,
        'email': email,
      },
    );
  }

  // Método para obter um usuário com CPF e senha
  Future<Map<String, dynamic>?> getUser(String cpf, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'cpf = ? AND password = ?',
      whereArgs: [cpf, password],
    );

    if (result.isNotEmpty) {
      return result.first; // Retorna o primeiro usuário encontrado
    }
    return null; // Retorna null se não encontrar
  }

  // Inserir novo ponto
  Future<void> insertPoint(String timestamp, double latitude, double longitude) async {
    final db = await database;
    await db.insert(
      'points',
      {
        'timestamp': timestamp,
        'latitude': latitude,
        'longitude': longitude,
      },
    );
  }

  // Obter todos os pontos
  Future<List<Map<String, dynamic>>> getPoints() async {
    final db = await database;
    return await db.query('points');
  }

  // Atualizar um ponto existente
  Future<void> updatePoint(int id, String newTimestamp, double newLatitude, double newLongitude) async {
    final db = await database;
    await db.update(
      'points',
      {
        'timestamp': newTimestamp,
        'latitude': newLatitude,
        'longitude': newLongitude,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Excluir um ponto
  Future<void> deletePoint(int id) async {
    final db = await database;
    await db.delete(
      'points',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
