import 'package:expense_tracker/data/local/prefrenceData/Prefrence.dart';
import 'package:expense_tracker/presentation/dashboard/dashboardHelper.dart';
import 'package:expense_tracker/presentation/splash/Splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'data/repositories/FetchPrefImp.dart';
import 'data/repositories/fetch_Database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  await Prefrence.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => DashboardHelper(
        Fetchprefimp(),
        FetchDatabaseImp(),
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}