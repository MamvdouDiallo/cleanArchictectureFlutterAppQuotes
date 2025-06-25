
import 'package:clean_architecture_flutter/config/locale/database_helper.dart';

import '../../features/random_quote/domain/entities/quote.dart';


class QuoteLocalDataSource {
  final DatabaseHelper dbHelper;
  QuoteLocalDataSource(this.dbHelper);
  Future<Quote> getRandomQuote() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM quotes ORDER BY RANDOM() LIMIT 1'
    );
    if (maps.isNotEmpty) {
      return dbHelper.mapToQuote(maps.first);
    } else {
      throw Exception('Aucune citation disponible');
    }
  }

  Future<List<Quote>> getAllQuotes() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('quotes');
    return maps.map(dbHelper.mapToQuote).toList();
  }

  Future<int> insertQuote(Quote quote) async {
    final db = await dbHelper.database;
    return await db.insert('quotes', dbHelper.quoteToMap(quote));
  }
}