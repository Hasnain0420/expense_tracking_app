import 'package:expense_tracker/presentation/Profile/Profile.dart';
import 'package:expense_tracker/presentation/Report/Report.dart';
import 'package:expense_tracker/presentation/Transaction/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../data/repositories/FetchPrefImp.dart';
import '../data/repositories/fetch_Database.dart';
import 'Report/reportHelper.dart';
import 'Transaction/transactionHelper.dart';
import 'addTransaction/Add_transaction.dart';
import 'addTransaction/add_transaction_helper.dart';
import 'dashboard/dashboard.dart';
import 'dashboard/dashboardHelper.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPage = 0;

  final List<String> topBarName = [
    "",
    "Transaction",
    "Add Transactions",
    "Report",
    "Profile",
  ];

  void backToHome(){
    setState(() {
      currentPage = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, _) async {
        bool? exit;
        if(currentPage != 0){
          setState(() {
            currentPage = 0;
          });
        }else {
          exit = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Exit App"),
                content: const Text(
                  "Are you sure you want to exit?",
                ),
                actions: [

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text("No"),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text("Yes"),
                  ),

                ],
              );
            },
          );
        }
        if (exit == true) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        // ---------------- APP BAR ----------------
        appBar: currentPage == 0
            ? null
            : AppBar(
          toolbarHeight: MediaQuery.of(context).size.width * 0.12,
          backgroundColor: Colors.purple[400],
          title: Text(
            topBarName[currentPage],
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: currentPage == 2
              ? IconButton(
            icon: const Icon(Icons.keyboard_arrow_left,
                color: Colors.white),
            onPressed: () {
              setState(() {
                currentPage = 0;
              });
            },
          )
              : null,
        ),
        // ---------------- BODY ----------------
        body: currentPage == 0
            ? Dashboard(key: ValueKey(currentPage))
            : currentPage == 1
            ? ChangeNotifierProvider(
          create: (_) => TransactionHelper(
              FetchDatabaseImp(),
              Fetchprefimp(),),
          child: Transaction(key: ValueKey(currentPage)),
        )
            : currentPage == 2
            ? ChangeNotifierProvider(
          create: (_) => AddTransactionHelper(
              Fetchprefimp(),
              FetchDatabaseImp()),
          child: AddTransaction(
            onAddTransactoin : backToHome
          ),
        )
            : currentPage == 3
            ? ChangeNotifierProvider(
          create: (_) => ReportHelper(
            Fetchprefimp(),
            FetchDatabaseImp(),
          ),
          child: Report(key: ValueKey(currentPage)),
        )
            : Profile(),

        // ---------------- BOTTOM NAV ----------------
        bottomNavigationBar: currentPage == 2
            ? null
            : BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (index) {
            if (index < 0 || index > 4) return; // safety guard
            setState(() {
              currentPage = index;
            });
          },
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.add_card_outlined),
              activeIcon: Icon(Icons.add_card),
              label: 'Logs',
            ),
            BottomNavigationBarItem(
              icon: Icon( Icons.add_circle_outlined,
                color: Colors.purple[500],
                size: 40, ),
              activeIcon: const Icon(Icons.add_circle, size: 45),
              backgroundColor: Colors.purple[500],
              label: 'Add', ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined),
              activeIcon: Icon(Icons.bar_chart),
              label: 'Report',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}