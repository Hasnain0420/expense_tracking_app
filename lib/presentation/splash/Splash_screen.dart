import 'package:expense_tracker/data/local/prefrenceData/Prefrence.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/FetchPrefImp.dart';
import '../InitPage/InitPage.dart';
import '../InitPage/OnBoardHelper.dart';
import '../dashboard/dashboardHelper.dart';
import '../mainScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUser();
    });
  }
  late DashboardHelper provider = context.read<DashboardHelper>();

  void checkUser() async {
    if (!mounted) return;

    final bool isNew = Prefrence.isFirstUser();

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (isNew) {
      DateTime now = DateTime.now();
      await Prefrence.setCurrentMonth(DateFormat('MM-yyyy').format(now));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => OnboardProvider(Fetchprefimp()),
            child: Initpage(),
          ),
        ),
      );
    } else {
      DateTime now = DateTime.now();
      String month = DateFormat('MM-yyyy').format(now);
      if(Prefrence.getCurrentMonth() != month){
        List<String> reportList = Prefrence.getReportMonths();
        reportList.add(Prefrence.getCurrentMonth());
        Prefrence.setReportMonths(reportList);
        await Prefrence.setCurrentMonth(month);

      }
      await provider.getPrefData();
      await provider.getDB_Data();
      provider.setLoading();
      Prefrence.setShouldLoad(false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              child: Image.asset('assets/images/splashicon.jpeg'),
            ),
            const SizedBox(height: 20),
            const Text("Expense Tracker"),
            const SizedBox(height: 30),
            const CircularProgressIndicator(color: Colors.purple),
          ],
        ),
      ),
    );
  }
}