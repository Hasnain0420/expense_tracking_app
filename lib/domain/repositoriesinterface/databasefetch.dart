// lib/domain/repositoriesinterface/databasefetch.dart
abstract class DatabaseFetch {
  Future<bool> addTransaction(
      double amount,
      String type,
      String category,
      String date,
      String? note,
      );
  Future<List<Map<String, dynamic>>> dashBoardFetch();

  Future<List<Map<String, dynamic>>> getTransaction(int value);
}