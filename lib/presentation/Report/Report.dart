import 'package:expense_tracker/data/local/prefrenceData/Prefrence.dart';
import 'package:expense_tracker/presentation/Report/reportHelper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Report extends StatefulWidget {
  const Report({super.key});
  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  late ReportHelper provider;
  @override
  void initState() {
    super.initState();
    provider = context.read<ReportHelper>();
    provider.checkMonthList();
  }

  final List<Color> colors = [
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.amber,
    Colors.teal,
    Colors.grey,
  ];

  final List<String> items = [
    "Food",
    "Transport",
    "Shopping",
    "Bills",
    "Others",
  ];

  @override
  Widget build(BuildContext context) {
    return provider.hasData ?
        Center(
          child: Text("No Data To Show"),
        )
        : Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.width * 0.07,

        ///bottom: MediaQuery.of(context).size.width * 0.03,
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Selector<ReportHelper, String?>(
          selector: (_, p) => p.selectedCategory,
        builder: (_, category, __) {
          return
            Card(
              child: Container(
                padding: EdgeInsets.only(
                  left: MediaQuery
                      .of(context)
                      .size
                      .width * 0.02,
                  right: MediaQuery
                      .of(context)
                      .size
                      .width * 0.02,
                ),
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

                    value: null,
                    hint: Text("Select Month"),
                    isExpanded: true,
                    items: provider.monthList
                        .map((item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (String? value) {

                    },
                  ),
                ),
              ),
            );
        }),

          SizedBox(height: MediaQuery.of(context).size.width * 0.09),

          Text(
            "Summary",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.w400,
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.width * 0.05),

          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.3,
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    //elevation: 6,
                    //shadowColor: Colors.green.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      color: Colors.green[100],
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Income",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              "${Prefrence.getCurrency()} ${00000000}",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.w700,
                                color: Colors.green[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                Expanded(
                  child: Card(
                    //elevation: 6,
                    //shadowColor: Colors.red.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      color: Colors.red[100],
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Expenses",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.bold,
                                color: Colors.red[600],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              "${Prefrence.getCurrency()} ${1111111}",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.w700,
                                color: Colors.red[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.width * 0.09),

          Text(
            "Expense OverView",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.03),
          Center(
            child: Container(
              color: Colors.green,
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              child: Center(child: Text("No Expense Data")),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),

          Expanded(
            child: Card(
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
                  right: MediaQuery.of(context).size.width * 0.03,
                  top: MediaQuery.of(context).size.width * 0.03,
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.025,
                              height: MediaQuery.of(context).size.width * 0.025,
                              decoration: BoxDecoration(
                                color: colors[index],
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                            Text(
                              items[index],
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "${/*helper.getCategoryAmount(items[index])*/100}",
                              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                            Text(
                              "${/*double.parse((provider.getCategoryAmount(items[index]) * 100 / helper.expense).toStringAsFixed(1))*/100}%",
                              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.033, fontWeight: FontWeight.w500, color: colors[index]),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
