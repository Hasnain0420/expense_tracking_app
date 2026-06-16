// lib/presentation/initpage.dart
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'OnBoardHelper.dart';
import '../mainScreen.dart';

class Initpage extends StatelessWidget {
  const Initpage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OnboardProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                Center(
                  child: Text(
                    "WELCOME",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.09,
                      fontWeight: FontWeight.w700,
                      color: Colors.purple[500],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.25),
                Text("Name", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 0.13,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        onChanged: provider.setName,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Name",
                        ),
                      ),
                    ),
                  ),
                ),
                Selector<OnboardProvider, bool>(
                  selector: (_, p) => p.nameError,
                  builder: (_, hasError, __) => hasError
                      ? const Text("Please Enter Name", style: TextStyle(color: Colors.red))
                      : const SizedBox.shrink(),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.15),
                Text("Currency", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
                Selector<OnboardProvider, String>(
                  selector: (_, p) => p.selectedCurrency,
                  builder: (_, currency, __) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          showCurrencyPicker(
                            context: context,
                            showFlag: true,
                            showCurrencyName: true,
                            showCurrencyCode: true,
                            onSelect: (Currency c) => provider.setCurrency(c.symbol),
                          );
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width * 0.13,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                currency.isEmpty ? "Select Currency" : currency,
                                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Selector<OnboardProvider, bool>(
                  selector: (_, p) => p.currencyError,
                  builder: (_, hasError, __) => hasError
                      ? const Text("Please Select Currency", style: TextStyle(color: Colors.red))
                      : const SizedBox.shrink(),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.15),
                Text("Current Balance", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 0.13,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        onChanged: provider.setBalance,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Current Available Balance",
                        ),
                      ),
                    ),
                  ),
                ),
                Selector<OnboardProvider, bool>(
                  selector: (_, p) => p.balanceError,
                  builder: (_, hasError, __) => hasError
                      ? const Text("Please Enter Balance", style: TextStyle(color: Colors.red))
                      : const SizedBox.shrink(),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.15),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.15,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[500],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () async {
                        bool ok = await provider.validate();
                        if (!context.mounted) return;
                        if (ok) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => MainScreen()),
                          );
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}