import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/ReportsController/ReportsController.dart';
import '../../../../Constant/Screen.dart';

class ViewDetailsAlertBox extends StatefulWidget {
  ViewDetailsAlertBox({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewDetailsAlertBox> createState() => ShowSearchDialogState();
}

class ShowSearchDialogState extends State<ViewDetailsAlertBox> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: Screens.width(context),
      height: Screens.bodyheight(context) * 0.3,
      padding: EdgeInsets.only(
          top: Screens.bodyheight(context) * 0.02,
          bottom: Screens.bodyheight(context) * 0.02,
          left: Screens.width(context) * 0.02,
          right: Screens.width(context) * 0.02),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     SizedBox(
          //         width: Screens.width(context) * 0.55,
          //         // color: Colors.amber,
          //         child: Text(
          //           "Location Services is mandatory to verify that device is within the Location designated by your Organisation.",
          //           style: theme.textTheme.bodySmall,
          //         )),

          //   ],
          // ),
          SizedBox(height: Screens.bodyheight(context) * 0.001),
          // Container(
          //   height: Screens.bodyheight(context) * 0.06,
          //   child: Form(
          //     key: context.watch<ReportsController>().formkey,
          //     child: TextFormField(
          //       readOnly: true,
          //       controller: context.watch<ReportsController>().searchcontroller,
          //       textDirection: TextDirection.ltr,
          //       validator: (val) {
          //         if (val!.isEmpty) {
          //           return '*Required';
          //         }
          //         return null;
          //       },
          //       onTap: () {
          //         context.read<ReportsController>().searchcontroller =
          //             context.read<ReportsController>().searchcontroller;
          //         context.read<ReportsController>().searchcontroller.selection =
          //             TextSelection(
          //           baseOffset: 0,
          //           extentOffset: context
          //               .read<ReportsController>()
          //               .searchcontroller
          //               .text
          //               .length,
          //         );
          //       },
          //       onChanged: ((value) {
          //         //context.watch<ReportsController>().filterSearchBoxList(value);
          //       }),
          //       decoration: InputDecoration(
          //           enabledBorder: OutlineInputBorder(
          //             borderSide: BorderSide(color: Colors.grey),
          //             //  when the TextFormField in unfocused
          //           ),
          //           focusedBorder: OutlineInputBorder(
          //             borderSide: BorderSide(color: Colors.grey),
          //             //  when the TextFormField in focused
          //           ),
          //           errorBorder: OutlineInputBorder(
          //             borderSide: BorderSide(color: Colors.red),
          //           ),
          //           focusedErrorBorder: OutlineInputBorder(
          //             borderSide: BorderSide(color: Colors.red),
          //           ),
          //           hintText: 'Select',
          //           suffixIcon: Icon(Icons.arrow_drop_down, size: 25)),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: Screens.padingHeight(context) * 0.02,
          // ),
          Expanded(
              child: ListView.builder(
                  itemCount: context
                      .watch<ReportsController>()
                      .leadTablViewData
                      .length,
                  itemBuilder: (BuildContext context, int i) {
                    return InkWell(
                        onTap: (() {
                          setState(() {
                            context.read<ReportsController>().selectViewDet(i);
                            Navigator.pop(context);
                          });
                        }),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(
                                    Screens.padingHeight(context) * 0.005,
                                  ),
                                  child: Text(context
                                      .watch<ReportsController>()
                                      .leadTablViewData[i]
                                      .viewCode),
                                ),
                                Container(child: Text(' - ')),
                                Container(
                                  child: Text(context
                                      .watch<ReportsController>()
                                      .leadTablViewData[i]
                                      .viewName),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ));
                  })),
          SizedBox(
            height: Screens.padingHeight(context) * 0.01,
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     SizedBox(
          //       width: Screens.width(context) * 0.3,
          //       child: ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //               backgroundColor: theme.primaryColor),
          //           onPressed: () async {
          //             Navigator.pop(context); // exit(0);
          //           },
          //           child: const Text('  OK  ')),
          //     ),

          //   ],
          // )
        ],
      ),
    );
  }
}
