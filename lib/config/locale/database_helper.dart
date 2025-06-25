
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../features/random_quote/domain/entities/quote.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quotes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE quotes (
            id INTEGER PRIMARY KEY,
            author TEXT NOT NULL,
            content TEXT NOT NULL,
            permalink TEXT NOT NULL
          )
        ''');

        await _insertInitialQuotes(db);
      },
    );
  }

  Future<void> _insertInitialQuotes(Database db) async {
    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM quotes')
    ) ?? 0;

    if (count == 0) {
      final initialQuotes = [
        Quote(
          id: 1,
          author: 'Albert Einstein',
          content: 'La vie, c\'est comme une bicyclette, il faut avancer pour ne pas perdre l\'équilibre.',
          permalink: '/einstein-1',
        ),
        // ... (toutes vos autres citations)
      ];

      for (final quote in initialQuotes) {
        await db.insert('quotes', quoteToMap(quote));
      }
    }
  }

  // Changement: retirez le _ pour rendre publique
  Quote mapToQuote(Map<String, dynamic> map) {
    return Quote(
      id: map['id'] as int,
      author: map['author'] as String,
      content: map['content'] as String,
      permalink: map['permalink'] as String,
    );
  }

  Map<String, Object?> quoteToMap(Quote quote) {
    return {
      'id': quote.id,
      'author': quote.author,
      'content': quote.content,
      'permalink': quote.permalink,
    };
  }
}