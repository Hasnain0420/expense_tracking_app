// lib/data/repositories/fetchDatabaseImp.dart
import '../../domain/repositoriesinterface/databasefetch.dart';
import '../local/database/sqfliteDatabase.dart';

class FetchDatabaseImp implements DatabaseFetch {
  final myDB = DatabaseHelper.instance;

  @override
  Future<bool> addTransaction(
      double amount,
      String type,
      String category,
      String date,
      String? note,
      ) async {
    return await myDB.addTransaction(
      amount: amount,
      type: type,
      category: category,
      date: date,
      note: note,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> dashBoardFetch() async {
    return await myDB.getDashBoardTransactionData();
  }

  @override
  Future<List<Map<String, dynamic>>> getTransaction(int value) async{
    return await myDB.getTransaction(value);
  }
}