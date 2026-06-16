import 'package:flutter/cupertino.dart';

import '../../domain/repositoriesinterface/databasefetch.dart';
import '../../domain/repositoriesinterface/fetchprefrence.dart';

class ReportHelper extends ChangeNotifier {
  final DatabaseFetch _repoDB;
  final Fetchprefrencedata _repoPref;
  ReportHelper(this._repoPref , this._repoDB);
  late List<String> _listofMonths;
  String? _selectedCategory = null;
  bool _hasData = false;

  void checkMonthList(){
    _listofMonths = _repoPref.getReportMonths();
    if(_listofMonths.isEmpty){
      _hasData = false;
    }else{
      _hasData = true;
      _selectedCategory = _listofMonths[0];
    }
  }

  void setCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  bool get hasData => _hasData;
  List<String> get monthList => _listofMonths;
  String? get selectedCategory => _selectedCategory;
}