import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/ReportsController/ReportsController.dart';

class DataTableWidget extends StatefulWidget {
  DataTableWidget({Key? key, required this.tablerColumn}) : super(key: key);

  List<Map<String, dynamic>> tablerColumn;

  @override
  State<DataTableWidget> createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    List<DataColumn> _generateColumns(List<Map<String, dynamic>> data) {
      List<DataColumn> columns = [];
      data.first.keys.forEach((key) {
        columns.add(DataColumn(
          label: Text(key),
        ));
      });
      return columns;
    }

    List<DataRow> _generateRows(List<Map<String, dynamic>> data) {
      List<DataRow> rows = [];
      data.forEach((item) {
        List<DataCell> cells = [];
        item.keys.forEach((key) {
          cells.add(DataCell(Text(item[key].toString())));
        });
        rows.add(DataRow(cells: cells));
      });
      return rows;
    }

    return context.watch<ReportsController>().tableColumLoad == true
        ? Container(
            child: Center(
              child: CircularProgressIndicator(
                color: theme.primaryColor,
              ),
            ),
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: Screens.width(context) * 0.95,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        Screens.bodyheight(context) * 0.01),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[400]!,
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                          offset: const Offset(2, 0))
                    ]),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: Screens.padingHeight(context) * 0.02,
                              left: Screens.width(context) * 0.35),
                          child: Text(
                            context
                                .watch<ReportsController>()
                                .tableChartTitle
                                .toString(),
                            style: theme.textTheme.bodyMedium!.copyWith(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        DataTable(
                          columnSpacing: 3.0,
                          border: TableBorder.symmetric(
                              inside: BorderSide(
                                  color: theme.primaryColor.withOpacity(0.1))),
                          // sortColumnIndex: 1,
                          columns: _generateColumns(widget.tablerColumn),
                          rows: _generateRows(widget.tablerColumn),

                          headingTextStyle: theme.textTheme.bodyMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(height: Screens.bodyheight(context) * 0.1)
                      ],
                    )),
              ),
            ],
          );
  }
}
  //   List<Map<String, dynamic>> data = [
    //     {
    //       "Name": "John",
    //       "Age": 25,
    //       "City": "New York",
    //       "City2": "New York",
    //       "City3": "New York"
    //     },
    //     {
    //       "Name": "John",
    //       "Age": 25,
    //       "City": "New York",
    //       "City2": "New York",
    //       "City3": "New York"
    //     },
    //     {
    //       "Name": "John",
    //       "Age": 25,
    //       "City": "New York",
    //       "City2": "New York",
    //       "City3": "New York"
    //     },
    //     {
    //       "Name": "John",
    //       "Age": 25,
    //       "City": "New York",
    //       "City2": "New York",
    //       "City3": "New York"
    //     },
    //     {
    //       "Name": "John",
    //       "Age": 25,
    //       "City": "New York",
    //       "City2": "New York",
    //       "City3": "New York"
    //     },
    //     {
    //       "Name": "John",
    //       "Age": 25,
    //       "City": "New York",
    //       "City2": "New York",
    //       "City3": "New York"
    //     },
    //     {
    //       "Name": "John",
    //       "Age": 25,
    //       "City": "New York",
    //       "City2": "New York",
    //       "City3": "New York"
    //     },
    //     {
    //       "Name": "John",
    //       "Age": 25,
    //       "City": "New York",
    //       "City2": "New York",
    //       "City3": "New York"
    //     },
    //     {
    //       "Name": "John",
    //       "Age": 25,
    //       "City": "New York",
    //       "City2": "New York",
    //       "City3": "New York"
    //     },

    //     // Add more data as needed
    //   ];