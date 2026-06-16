import 'package:shared_preferences/shared_preferences.dart';

class Prefrence {
  static late final SharedPreferences _prefs;

  // initialize SharedPreferences (MUST be called before use)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // -------------------------
  // USER STATE
  // -------------------------

  static bool isFirstUser() {
    return _prefs.getBool("isNewUser") ?? true;
  }

  static Future<void> setFirstUser() async {
    await _prefs.setBool("isNewUser", false);
  }

  // -------------------------
  // SHOULD LOAD DATA
  // -------------------------

  static Future<void> setShouldLoad(bool value) async{
    await _prefs.setBool("load", value);
  }

  static bool getShouldLoad(){
    return _prefs.getBool("load") ?? true;
  }

  // -------------------------
  // GETTERS (SAFE NON-NULL)
  // -------------------------

  static String getName() {
    return _prefs.getString("userName") ?? "";
  }

  static String getCurrency() {
    return _prefs.getString("currency") ?? "USD";
  }

  static double getBalance() {
    return _prefs.getDouble("balance") ?? 0.0;
  }

  static double getIncome() {
    return _prefs.getDouble("income") ?? 0.0;
  }

  static double getExpense() {
    return _prefs.getDouble("expense") ?? 0.0;
  }

  static String getCurrentMonth(){
    return _prefs.getString("month") ?? "";
  }

  static List<String> getReportMonths(){
    return _prefs.getStringList("report") ?? [];
  }

  // -------------------------
  // SETTERS
  // -------------------------

  static Future<void> setName(String name) async {
    await _prefs.setString("userName", name);
  }

  static Future<void> setCurrency(String currency) async {
    await _prefs.setString("currency", currency);
  }

  static Future<void> setBalance(double balance) async {
    await _prefs.setDouble("balance", balance);
  }

  static Future<void> setIncome(double income) async {
    await _prefs.setDouble("income", income);
  }

  static Future<void> setExpense(double expense) async {
    await _prefs.setDouble("expense", expense);
  }

  static Future<void> setCurrentMonth(String month) async {
    await _prefs.setString("month", month);
  }

  static Future<void> setReportMonths(List<String> list) async{
    await _prefs.setStringList("report", list);
  }
}