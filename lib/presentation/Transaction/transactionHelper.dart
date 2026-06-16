// lib/presentation/Transaction/transactionHelper.dart
import 'package:flutter/foundation.dart';
import '../../data/local/database/sqfliteDatabase.dart';
import '../../domain/repositoriesinterface/databasefetch.dart';
import '../../domain/repositoriesinterface/fetchprefrence.dart';

class TransactionHelper extends ChangeNotifier {
  final DatabaseFetch _repoDb;
  final Fetchprefrencedata _repoPref;
  int _transactionType = 0;

  List<Map<String, dynamic>> _data = [];
  Map<String, List<Map<String, dynamic>>> _groupData = {};
  String? _currency;

  TransactionHelper(this._repoDb, this._repoPref);

  void getCurrency() {
    _currency = _repoPref.getCurrency();
  }

  Future<void> setTransactioType(int type) async{
    _transactionType = type;
    ///notifyListeners(); // bro if getData() has notifyListeners() already why it not updating it why adding here works
    await getData();
  }

  String? get currency => _currency;

  int get type => _transactionType;

  Future<void> getData() async {
    final newData = await _repoDb.getTransaction(_transactionType);
    _data = newData; // ✅ REPLACE, don't add
    _groupData = {}; // ✅ clear before regrouping
    groupingData(_data);
    notifyListeners(); // this one
  }

  void groupingData(List<Map<String, dynamic>> transactions) {
    for (var transaction in transactions) {
      // ✅ FIX: use correct column name "Date" (capital D)
      String date = transaction[DatabaseHelper.DATE] ?? "No Date";
      if (_groupData.containsKey(date)) {
        _groupData[date]!.add(transaction);
      } else {
        _groupData[date] = [transaction];
      }
    }
  }

  Map<String, List<Map<String, dynamic>>> get groupData => _groupData;
}