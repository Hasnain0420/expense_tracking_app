import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/local/prefrenceData/Prefrence.dart';
import 'add_transaction_helper.dart';

class AddTransaction extends StatefulWidget {
  final VoidCallback onAddTransactoin;
  AddTransaction({required this.onAddTransactoin});
  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {


  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  List<String> expenseCatagories = [
    "Food", "Transport", "Shopping", "Bills", "Others"
  ];
  List<String> incomeCatagories = [
    "Salary", "Freelance", "Investments", "Gift", "Others"
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddTransactionHelper>();

    return Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.15,
          bottom: MediaQuery.of(context).size.width * 0.05,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Container(
      width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.13,

                  decoration: BoxDecoration(
                  ),
                  child: Row(
                    children: [
                      Expanded(child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            provider.setType(0);
                            provider.setCategory(null);
                            provider.resetErrors();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: provider.selectedType == 0 ? Colors.red : null,
                          foregroundColor: provider.selectedType == 0 ? Colors.white : Colors.black,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Matches your cards
                          ),

                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shadowColor: Colors.grey[400],
                        ),
                        child: Text(
                          "Expense",
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035,
                            fontWeight: FontWeight.w400,),
                        ),
                      )),

                      Expanded(child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            provider.setType(1);
                            provider.setCategory(null);
                            provider.resetErrors();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: provider.selectedType == 1 ? Colors.red : null,
                          foregroundColor: provider.selectedType == 1 ? Colors.white : Colors.black,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Matches your cards
                          ),

                          // 3. Size and Padding
                          padding:  EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shadowColor: Colors.grey[400], // Matching shadow color
                        ),
                        child:  Text(
                          "Income",
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035,
                              fontWeight: FontWeight.w400),
                        ),
                      ))
                    ],
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.width * 0.2),

                Text("Amount"),
                Card(
                  child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.13,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: amountController,
                        onChanged: provider.setAmount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none, // removes TextField border
                          hintText: "Enter Amount",
                        ),
                      ),
                ),
                ),
                ),
                Selector<AddTransactionHelper, bool>(
                  selector: (_, p) => p.amountError,
                  builder: (_, hasError, __) {
                    return hasError
                        ? const Text(
                      "Please Enter Amount",
                      style: TextStyle(color: Colors.red),
                    )
                        : const SizedBox.shrink();
                  },
                ),

                SizedBox(height: MediaQuery.of(context).size.width * 0.1),

                Text("Catagory"),
            Selector<AddTransactionHelper, String?>(
                selector: (_, p) => p.selectedCategory,
                builder: (_, category, __) { return
                  Card(
                    child: Container(
                      padding: EdgeInsets.only(left: MediaQuery
                          .of(context)
                          .size
                          .width * 0.02, right: MediaQuery
                          .of(context)
                          .size
                          .width * 0.02),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .width * 0.13,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          icon: Icon(Icons.arrow_drop_down_sharp),

                          value: category,
                          hint: Text("Select Category"),
                          isExpanded: true,
                          items: provider.selectedType == 0 ? expenseCatagories.map((
                              item) {
                            return DropdownMenuItem(
                                value: item,
                                child: Text(item));
                          }).toList() : incomeCatagories.map((item) {
                            return DropdownMenuItem(
                                value: item,
                                child: Text(item));
                          }).toList(),
                          onChanged: (String? value) {
                            if (value != null) {
                              provider.setCategory(value);
                            }
                          },),
                      ),
                    ),
                  );
                }
                ),

                Selector<AddTransactionHelper, bool>(
                  selector: (_, p) => p.categoryError,
                  builder: (_, hasError, __) {
                    return hasError
                        ? const Text(
                      "Please Select Category",
                      style: TextStyle(color: Colors.red),
                    )
                        : const SizedBox.shrink();
                  },
                ),

                SizedBox(height: MediaQuery.of(context).size.width * 0.1),

                Text("Date"),
            Selector<AddTransactionHelper, DateTime>(
                selector: (_, p) => p.selectedDate,
                builder: (_, category, __) {
                  return
                    Card(
                      child: InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: provider.selectedDate,
                            firstDate: DateTime(
                              DateTime
                                  .now()
                                  .year,
                              DateTime
                                  .now()
                                  .month,
                              1,
                            ),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null) {
                            provider.setDate(pickedDate);
                          }
                        },
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .width * 0.13,
                          padding: EdgeInsets.all(MediaQuery
                              .of(context)
                              .size
                              .width * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${provider.selectedDate.day}-${provider
                                    .selectedDate.month}-${provider
                                    .selectedDate.year}",
                                style: TextStyle(fontSize: 16),
                              ),
                              Icon(Icons.calendar_today),
                            ],
                          ),
                        ),
                      ),
                    );
                }),

                SizedBox(height: MediaQuery.of(context).size.width * 0.1),

                Text("Note(Optional)"),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: noteController,
                      onChanged: provider.setNote,
                      maxLength: 30,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hint: Text("Optional, For Reminder")
                      ),
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.width * 0.1),

                Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.15,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple[500],
                            foregroundColor: Colors.white,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // Matches your cards
                            ),

                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            shadowColor: Colors.grey[400],
                          ),
                          onPressed: () async {
                            bool successful = await provider.validate();


                            if (successful) {
                              amountController.clear();
                              noteController.clear();
                              provider.resetValues();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Data stored successfully"),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              Prefrence.setShouldLoad(true);
                              widget.onAddTransactoin();
                            }
                          },
                          child: Text("Submit", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),))),
                )
              ],
            ),
          )
        )
    );

  }
}