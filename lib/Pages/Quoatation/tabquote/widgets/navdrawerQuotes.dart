// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';

import '../../../../Controller/QuotationController/tabquotescontroller.dart';

class navDrawerQuotes extends StatefulWidget {
  const navDrawerQuotes({Key? key}) : super(key: key);

  @override
  State<navDrawerQuotes> createState() => _navDrawerQuotesState();
}

class _navDrawerQuotesState extends State<navDrawerQuotes> {
//  List<String> assigncolumn=['684',"1053","622"];
//  List<String> customercolumn=['Kayal','pavi','Nirmala'];
//  List<String> Enquirystatuscolumn=['Open','Closed','Lost'];
//   List<String> lookingforcolumn=['AF','sellerkit','SAP'];
//     List<String> interestcolumn=['AF','sellerkit','SAP'];
//      List<String> ordertypecolumn=['type1','type2','type3'];

  // String? dropdownValue2;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      // backgroundColor: Colors.grey[300],
      child: ListView(
        children: [
          InkWell(
             onTap: (){
              setState(() {
                  FocusScope.of(context).unfocus();
                });
            },
            child: Container(
              // color: Colors.grey[300],
              // width: 50,
              // height: Screens.bodyheight(context)*0.1,
              // padding: EdgeInsets.symmetric(
              //     horizontal: Screens.width(context) * 0.02,
              //     vertical: Screens.padingHeight(context) * 0.004),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: Screens.padingHeight(context) * 0.1,
                      width: Screens.width(context),
                      padding: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                                Screens.padingHeight(context) * 0.05),
                            bottomRight: Radius.circular(
                                Screens.padingHeight(context) * 0.05),
                          )),
                      child: Text(
                        "Quotation",
                        style: theme.textTheme.bodyText2!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Container(
                      width: Screens.width(context),
                      height: Screens.bodyheight(context) * 0.85,
                      // color: Colors.amber,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: Screens.width(context),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Screens.width(context) * 0.02,
                                    right: Screens.width(context) * 0.02,
                                    top: Screens.padingHeight(context) * 0.01),
                                child: Column(
                                  children: [
                                    Container(
                                      // color:Colors.amber,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                      child: Column(
                                        children: [
                                          TextField(
                                            onTap: () {
                                              setState(() {
                                                context
                                                    .read<QuotestabController>()
                                                    .ontapassignto();
                                              });
                                            },
                                            readOnly: true,
                                            decoration: InputDecoration(
                                                hintText: "Assigned To",
                                                hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                                contentPadding:
                                                    EdgeInsets.all(8.0),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none),
                                                // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none),
                                                // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none),
                                                // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none),
                                                // // UnderlineInputBorder(
                                                //   borderSide: BorderSide(color: Colors.grey)
                                                // ),
                                                suffixIcon: Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          context
                                                          .watch<
                                                              QuotestabController>()
                                                          .isassignto ==
                                                      true &&
                                                  context
                                                      .watch<
                                                          QuotestabController>()
                                                      .assigncolumn
                                                      .isNotEmpty
                                              ? Container(
                                                  height: Screens.padingHeight(
                                                          context) *
                                                      0.15,
                                                  // color:Colors.amber,
                                                  child: SingleChildScrollView(
                                                    child: ListBody(
                                                        children: context
                                                            .watch<
                                                                QuotestabController>()
                                                            .assigncolumn
                                                            .map((item) =>
                                                                CheckboxListTile(
                                                                  value: context
                                                                      .watch<
                                                                          QuotestabController>()
                                                                      .selectedassignto
                                                                      .contains(item
                                                                          .name),
                                                                  title: Text(
                                                                      item.name),
                                                                  controlAffinity:
                                                                      ListTileControlAffinity
                                                                          .leading,
                                                                  onChanged: (ischecked) => context
                                                                      .read<
                                                                          QuotestabController>()
                                                                      .itemselectassignto(
                                                                          item.name,
                                                                          ischecked!),
                                                                ))
                                                            .toList()),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
          
                            // Container(
                            //   width: Screens.width(context),
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Container(
                            //             child: Text(
                            //           "Assigned to",
                            //           style: theme.textTheme.bodyMedium!.copyWith(
                            //               color: theme.primaryColor, fontSize: 15),
                            //         )),
                            //         SizedBox(
                            //           height: Screens.padingHeight(context) * 0.01,
                            //         ),
                            //         Container(
                            //           // color: Colors.amber,
                            //           width: Screens.width(context),
                            //           padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                            //           height: Screens.padingHeight(context) * 0.06,
                            //           decoration: BoxDecoration(
                            //               borderRadius: BorderRadius.circular(8),
                            //               border: Border.all(color: Colors.black26)),
                            //           child: DropdownButton(
                            //             isExpanded: true,
                            //             underline: SizedBox.shrink(),
                            //             value: context.read<QuotestabController>(). assignvalue,
                            //             icon: Icon(Icons.arrow_drop_down),
                            //             iconSize: 30,
                            //             onChanged: ( val) {
                            //               setState(() {
                            //              context.read<QuotestabController>(). selectassign(val.toString());
                            //               //  context.read<Outstandingcontroller>(). assignvalue  = val!;
                            //               });
                            //             },
                            //             items: context.read<QuotestabController>(). assigncolumn.map((e) {
                            //               return DropdownMenuItem(
                            //                   value:e.name ,
                            //                   child: Text(e.name));
                            //             }).toList(),
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            //  Customer
          
                            // Container(
                            //   width: Screens.width(context),
                            //   child: Padding(
                            //     padding: EdgeInsets.only(
                            //         left: Screens.width(context) * 0.02,
                            //         right: Screens.width(context) * 0.02,
                            //         top: Screens.padingHeight(context) * 0.01),
                            //     child: Column(
                            //       children: [
                            //         Container(
                            //           // color:Colors.amber,
                            //           decoration: BoxDecoration(
                            //               border: Border(
                            //                   bottom: BorderSide(
                            //                       color: Colors.grey))),
                            //           child: Column(
                            //             children: [
                            //               TextField(
                            //                 onTap: () {
                            //                   setState(() {
                            //                     context
                            //                         .read<QuotestabController>()
                            //                         .ontapcusgroup();
                            //                   });
                            //                 },
                            //                 readOnly: true,
                            //                 decoration: InputDecoration(
                            //                     hintText: "Customer Name",
                            //                     hintStyle: TextStyle(
                            //                         color: Colors.black,
                            //                         fontSize: 15),
                            //                     contentPadding:
                            //                         EdgeInsets.all(8.0),
                            //                     border: OutlineInputBorder(
                            //                         borderSide: BorderSide.none),
                            //                     // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            //                     disabledBorder:
                            //                         OutlineInputBorder(
                            //                             borderSide:
                            //                                 BorderSide.none),
                            //                     // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            //                     enabledBorder: OutlineInputBorder(
                            //                         borderSide: BorderSide.none),
                            //                     // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            //                     focusedBorder: OutlineInputBorder(
                            //                         borderSide: BorderSide.none),
                            //                     // // UnderlineInputBorder(
                            //                     //   borderSide: BorderSide(color: Colors.grey)
                            //                     // ),
                            //                     suffixIcon: Icon(
                            //                       Icons.arrow_drop_down,
                            //                       color: Colors.black,
                            //                     )),
                            //               ),
                            //               context
                            //                               .watch<
                            //                                   QuotestabController>()
                            //                               .iscusgroup ==
                            //                           true &&
                            //                       context
                            //                           .watch<
                            //                               QuotestabController>()
                            //                           .cusgroupcolumn
                            //                           .isNotEmpty
                            //                   ? Container(
                            //                       height: Screens.padingHeight(
                            //                               context) *
                            //                           0.2,
                            //                       // color:Colors.amber,
                            //                       child: SingleChildScrollView(
                            //                         child: ListBody(
                            //                             children: context
                            //                                 .watch<
                            //                                     QuotestabController>()
                            //                                 .cusgroupcolumn
                            //                                 .map((item) =>
                            //                                     CheckboxListTile(
                            //                                       value: context
                            //                                           .watch<
                            //                                               QuotestabController>()
                            //                                           .selectedcusgoup
                            //                                           .contains(item
                            //                                               .name),
                            //                                       title: Text(
                            //                                           item.name),
                            //                                       controlAffinity:
                            //                                           ListTileControlAffinity
                            //                                               .leading,
                            //                                       onChanged: (ischecked) => context
                            //                                           .read<
                            //                                               QuotestabController>()
                            //                                           .itemselectCusgroup(
                            //                                               item.name,
                            //                                               ischecked!),
                            //                                     ))
                            //                                 .toList()),
                            //                       ),
                            //                     )
                            //                   : Container()
                            //             ],
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
          
                            //         Container(
                            // width: Screens.width(context),
                            // child: Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Container(
                            //           child: Text(
                            //         "Customer Group",
                            //         style: theme.textTheme.bodyMedium!.copyWith(
                            //             color: theme.primaryColor, fontSize: 15),
                            //       )),
                            //       SizedBox(
                            //         height: Screens.padingHeight(context) * 0.01,
                            //       ),
                            //       Container(
                            //         // color: Colors.amber,
                            //         width: Screens.width(context),
                            //         padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                            //         height: Screens.padingHeight(context) * 0.06,
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(8),
                            //             border: Border.all(color: Colors.black26)),
                            //         child: DropdownButton(
                            //           isExpanded: true,
                            //           underline: SizedBox.shrink(),
                            //           value:context.read<QuotestabController>(). cusnamevalue,
                            //           icon: Icon(Icons.arrow_drop_down),
                            //           iconSize: 30,
                            //           onChanged: ( val) {
                            //             setState(() {
                            //          context.read<QuotestabController>().  selectcusname(val.toString());
          
                            //             });
                            //           },
                            //           items:context.read<QuotestabController>().cusgroupcolumn . map((e) {
                            //             return DropdownMenuItem<String>(
                            //                 value: "${e.name}",
                            //                 child: Container(child: Text("${e.name.toString()}")));
                            //           }).toList(),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            //         ),
                            //Trans Number
                            Container(
                              width: Screens.width(context),
                              // color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Screens.width(context) * 0.02,
                                    right: Screens.width(context) * 0.02,
                                    top: Screens.padingHeight(context) * 0.01),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //     child: Text(
                                    //   "From Date",
                                    //   style: theme.textTheme.bodyMedium!.copyWith(
                                    //       color: theme.primaryColor, fontSize: 15),
                                    // )),
                                    // SizedBox(
                                    //   height: Screens.padingHeight(context) * 0.01,
                                    // ),
                                    Container(
                                      // color: Colors.amber,
                                      width: Screens.width(context),
          
                                      // height: Screens.padingHeight(context) * 0.06,
                                      decoration: BoxDecoration(
                                          // color: Colors.amber,
                                          // borderRadius: BorderRadius.circular(8),
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                      child: TextField(
                                        readOnly: true,
                                        onTap: () {
                                          context
                                              .read<QuotestabController>()
                                              .showfromDate(context);
                                        },
                                        controller: context
                                            .read<QuotestabController>()
                                            .mycontroller[21],
                                        decoration: InputDecoration(
                                          hintText: "From Date",
                                          hintStyle: TextStyle(
                                              color: Colors.black, fontSize: 15),
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              context
                                                  .read<QuotestabController>()
                                                  .showfromDate(context);
                                            },
                                            icon: Icon(
                                              Icons.calendar_month,
                                              color: theme.primaryColor,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //Loan number
                            Container(
                              width: Screens.width(context),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Screens.width(context) * 0.02,
                                    right: Screens.width(context) * 0.02,
                                    top: Screens.padingHeight(context) * 0.01),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //     child: Text(
                                    //   "To Date",
                                    //   style: theme.textTheme.bodyMedium!.copyWith(
                                    //       color: theme.primaryColor, fontSize: 15),
                                    // )),
                                    // SizedBox(
                                    //   height: Screens.padingHeight(context) * 0.01,
                                    // ),
                                    Container(
                                      // color: Colors.amber,
                                      width: Screens.width(context),
          
                                      height:
                                          Screens.padingHeight(context) * 0.06,
                                      decoration: BoxDecoration(
                                          // borderRadius: BorderRadius.circular(8),
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                      child: TextField(
                                        readOnly: true,
                                        onTap: () {
                                          context
                                              .read<QuotestabController>()
                                              .showToDate(context);
                                        },
                                        controller: context
                                            .read<QuotestabController>()
                                            .mycontroller[22],
                                        decoration: InputDecoration(
                                          hintText: "To Date",
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: Colors.black, fontSize: 15),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              context
                                                  .read<QuotestabController>()
                                                  .showToDate(context);
                                            },
                                            icon: Icon(
                                              Icons.calendar_month,
                                              color: theme.primaryColor,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //age Above
                            //status
          
                            //new
                            Container(
                              width: Screens.width(context),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Screens.width(context) * 0.02,
                                    right: Screens.width(context) * 0.02,
                                    top: Screens.padingHeight(context) * 0.01),
                                child: Column(
                                  children: [
                                    Container(
                                      // color:Colors.amber,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                      child: Column(
                                        children: [
                                          TextField(
                                            onTap: () {
                                              setState(() {
                                                context
                                                    .read<QuotestabController>()
                                                    .onenqstatus();
                                              });
                                            },
                                            readOnly: true,
                                            decoration: InputDecoration(
                                                hintText: "Quotation Status",
                                                contentPadding:
                                                    EdgeInsets.all(8.0),
                                                hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none),
                                                // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none),
                                                // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none),
                                                // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none),
                                                // // UnderlineInputBorder(
                                                //   borderSide: BorderSide(color: Colors.grey)
                                                // ),
                                                suffixIcon: Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          context
                                                          .watch<
                                                              QuotestabController>()
                                                          .isenqstatus ==
                                                      true &&
                                                  context
                                                      .watch<
                                                          QuotestabController>()
                                                      .enqstatuscolumn
                                                      .isNotEmpty
                                              ? Container(
                                                  height: Screens.padingHeight(
                                                          context) *
                                                      0.2,
                                                  // color:Colors.amber,
                                                  child: SingleChildScrollView(
                                                    child: ListBody(
                                                        children: context
                                                            .watch<
                                                                QuotestabController>()
                                                            .enqstatuscolumn
                                                            .map((item) =>
                                                                CheckboxListTile(
                                                                  value: context
                                                                      .watch<
                                                                          QuotestabController>()
                                                                      .selectedenqstatus
                                                                      .contains(item
                                                                          .name),
                                                                  title: Text(
                                                                      item.name),
                                                                  controlAffinity:
                                                                      ListTileControlAffinity
                                                                          .leading,
                                                                  onChanged: (ischecked) => context
                                                                      .read<
                                                                          QuotestabController>()
                                                                      .itemselectenqstatus(
                                                                          item.name,
                                                                          ischecked!),
                                                                ))
                                                            .toList()),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //           Container(
                            // width: Screens.width(context),
                            // child: Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Container(
                            //           child: Text(
                            //         "Enquiry Status",
                            //         style: theme.textTheme.bodyMedium!.copyWith(
                            //             color: theme.primaryColor, fontSize: 15),
                            //       )),
                            //       SizedBox(
                            //         height: Screens.padingHeight(context) * 0.01,
                            //       ),
                            //       Container(
                            //         // color: Colors.amber,
                            //         width: Screens.width(context),
                            //         padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                            //         height: Screens.padingHeight(context) * 0.06,
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(8),
                            //             border: Border.all(color: Colors.black26)),
                            //         child: DropdownButton(
                            //           isExpanded: true,
                            //           underline: SizedBox.shrink(),
                            //           value: context.read<QuotestabController>().Enquirystatusvalue,
                            //           icon: Icon(Icons.arrow_drop_down),
                            //           iconSize: 30,
                            //           onChanged: ( val) {
                            //             setState(() {
                            //          context.read<QuotestabController>().  selectEnqstatus(val.toString());
          
                            //             });
                            //           },
                            //           items:context.read<QuotestabController>(). enqstatuscolumn . map((e) {
                            //             return DropdownMenuItem<String>(
                            //                 value: "${e.name}",
                            //                 child: Container(child: Text("${e.name.toString()}")));
                            //           }).toList(),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            //         ),
                            //looking for
                            // context
                            //         .watch<QuotestabController>()
                            //         .stserror
                            //         .isNotEmpty
                            //     ? Container(
                            //         padding: EdgeInsets.only(
                            //             left: Screens.width(context) * 0.01),
                            //         alignment: Alignment.centerLeft,
                            //         child: Text(
                            //             context
                            //                 .watch<QuotestabController>()
                            //                 .stserror,
                            //             style:
                            //                 theme.textTheme.bodyMedium!.copyWith(
                            //               color: Colors.red,
                            //             )),
                            //       )
                            //     : Container(),
                            // Container(
                            //   width: Screens.width(context),
                            //   child: Padding(
                            //     padding: EdgeInsets.only(
                            //         left: Screens.width(context) * 0.02,
                            //         right: Screens.width(context) * 0.02,
                            //         top: Screens.padingHeight(context) * 0.01),
                            //     child: Column(
                            //       children: [
                            //         Container(
                            //           // color:Colors.amber,
                            //           decoration: BoxDecoration(
                            //               border: Border(
                            //                   bottom: BorderSide(
                            //                       color: Colors.grey))),
                            //           child: Column(
                            //             children: [
                            //               TextField(
                            //                 onTap: () {
                            //                   setState(() {
                            //                     context
                            //                         .read<QuotestabController>()
                            //                         .ontaplooking();
                            //                   });
                            //                 },
                            //                 readOnly: true,
                            //                 decoration: InputDecoration(
                            //                     hintText: "Looking For",
                            //                     contentPadding:
                            //                         EdgeInsets.all(8.0),
                            //                     hintStyle: TextStyle(
                            //                         color: Colors.black,
                            //                         fontSize: 15),
                            //                     border: OutlineInputBorder(
                            //                         borderSide: BorderSide.none),
                            //                     // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            //                     disabledBorder:
                            //                         OutlineInputBorder(
                            //                             borderSide:
                            //                                 BorderSide.none),
                            //                     // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            //                     enabledBorder: OutlineInputBorder(
                            //                         borderSide: BorderSide.none),
                            //                     // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            //                     focusedBorder: OutlineInputBorder(
                            //                         borderSide: BorderSide.none),
                            //                     // // UnderlineInputBorder(
                            //                     //   borderSide: BorderSide(color: Colors.grey)
                            //                     // ),
                            //                     suffixIcon: Icon(
                            //                       Icons.arrow_drop_down,
                            //                       color: Colors.black,
                            //                     )),
                            //               ),
                            //               context
                            //                               .watch<
                            //                                   QuotestabController>()
                            //                               .islookingfor ==
                            //                           true &&
                            //                       context
                            //                           .watch<
                            //                               QuotestabController>()
                            //                           .filterlookingforcolumn
                            //                           .isNotEmpty
                            //                   ? Container(
                            //                       height: Screens.padingHeight(
                            //                               context) *
                            //                           0.2,
                            //                       // color:Colors.amber,
                            //                       child: SingleChildScrollView(
                            //                         child: ListBody(
                            //                             children: context
                            //                                 .watch<
                            //                                     QuotestabController>()
                            //                                 .filterlookingforcolumn
                            //                                 .map((item) =>
                            //                                     CheckboxListTile(
                            //                                       value: context
                            //                                           .watch<
                            //                                               QuotestabController>()
                            //                                           .selectedlookingfor
                            //                                           .contains(item
                            //                                               .name),
                            //                                       title: Text(
                            //                                           item.name),
                            //                                       controlAffinity:
                            //                                           ListTileControlAffinity
                            //                                               .leading,
                            //                                       onChanged: (ischecked) => context
                            //                                           .read<
                            //                                               QuotestabController>()
                            //                                           .itemselect(
                            //                                               item.name,
                            //                                               ischecked!),
                            //                                     ))
                            //                                 .toList()),
                            //                       ),
                            //                     )
                            //                   : Container()
                            //             ],
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            //                 Container(
                            //       width: Screens.width(context),
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: Column(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             Container(
                            //                 child: Text(
                            //               "Lookingfor",
                            //               style: theme.textTheme.bodyMedium!.copyWith(
                            //                   color: theme.primaryColor, fontSize: 15),
                            //             )),
                            //             SizedBox(
                            //               height: Screens.padingHeight(context) * 0.01,
                            //             ),
                            //             Container(
                            //               // color: Colors.amber,
                            //               width: Screens.width(context),
                            //               // padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                            //               height:
                            //               context.watch<QuotestabController>().lookingforcolumnforshow.isEmpty?
                            //                Screens.padingHeight(context) * 0.065
                            //               :Screens.padingHeight(context) * 0.2
                            //               ,
                            //               decoration: BoxDecoration(
                            //                   borderRadius: BorderRadius.circular(8),
                            //                   border: Border.all(color: Colors.black26)),
                            //                   child: Column(
                            //                     children: [
                            //                       TextField(
                            //                       //   onTap: (){
                            //                       // context.watch<QuotestabController>().islookloading = !context.watch<QuotestabController>().islookloading!;
                            //                       //   },
                            //                         onTap: (){
                            //                         setState(() {
                            //                           showDialog(context: context, builder: (_)
                            //                                             {
                            //                                               return StatefulBuilder(
                            //                                                 builder: (context,st) {
                            //                                                   return AlertDialog(
                            //                           insetPadding: EdgeInsets.all(10),
                            //                            contentPadding: EdgeInsets.all(0),
                            //                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            //                           content:Container(
                            //                           width: Screens.width(context)*0.7,
                            //                           child: Column(
                            //                             mainAxisSize: MainAxisSize.min,
                            //                             children: [
                            //                             Container(
                            //                                 width: Screens.width(context),
                            //                                 height: Screens.bodyheight(context) * 0.06,
                            //                                 child: ElevatedButton(
                            //                                     onPressed: () {},
                            //                                     style: ElevatedButton.styleFrom(
                            //                                       textStyle: TextStyle(
                            //                                           // fontSize: 12,
                            //                                           ),
                            //                                       shape: RoundedRectangleBorder(
                            //                                           borderRadius: BorderRadius.only(
                            //                                         topRight: Radius.circular(10),
                            //                                         topLeft: Radius.circular(10),
                            //                                       )), //Radius.circular(6)
                            //                                     ),
                            //                                     child: Text(
                            //                                       "Looking For",
                            //                                     )),
                            //                               ),
                            //                                 SizedBox(
                            //                                       height: Screens.padingHeight(context)*0.01,
                            //                                     ),
                            //                               Padding(
                            //                                 padding: const EdgeInsets.all(8.0),
                            //                                 child: Container(
                            //                                         height: Screens.bodyheight(context) * 0.05,
                            //                                         decoration: BoxDecoration(
                            //                                           color: Colors.grey[200],
                            //                                           borderRadius:
                            //                                             BorderRadius.circular(Screens.width(context) * 0.01),
          
                            //                                         ),
                            //                                         child: TextField(
                            //                                           // controller:
                            //                                             // context.read<QuotestabController>().mycontroller[1],
                            //                                           onTap: () {
                            //                                             // Get.toNamed(ConstantRoutes.screenshot);
                            //                                           },
                            //                                           autocorrect: false,
                            //                                           onChanged: (v) {
                            //                                             st(() {
                            //                                                   context
                            //                           .read<QuotestabController>()
                            //                           .lookingfilter(v);
                            //                                             });
          
                            //                                           },
                            //                                           decoration: InputDecoration(
                            //                                             filled: false,
                            //                                             hintText: 'Search',
                            //                                             enabledBorder: InputBorder.none,
                            //                                             focusedBorder: InputBorder.none,
                            //                                             suffixIcon: Icon(
                            //                                             Icons.search,
                            //                                             color: theme.primaryColor,
                            //                                             ),
                            //                                             contentPadding: const EdgeInsets.symmetric(
                            //                                             vertical: 10,
                            //                                             horizontal: 5,
                            //                                             ),
                            //                                           ),
                            //                                         ),
                            //                                       ),
                            //                               ),
          
                            //                                     SizedBox(
                            //                                       height: Screens.padingHeight(context)*0.01,
                            //                                     ),
                            //                                       Container(
                            //                                           height: Screens.padingHeight(context) * 0.30,
                            //                                           child: SingleChildScrollView(
                            //                                           child: Wrap(
                            //                                                   spacing: 5.0, // gap between adjacent chips
                            //                                                   runSpacing: 5.0, // gap between lines
                            //                                                   children:
                            //                        List.generate(
                            //                         context.watch<QuotestabController>().filterlookingforcolumn.length,
                            //                           (ind)=>
                            //                           // StatefulBuilder(
                            //                           //   builder: (context,st) {
                            //                                GestureDetector(
                            //                                 onTap: () {
                            //                                   // context.read<QuotestabController>().selectedIdxFUser = ind;
                            //                                   st(() {
                            //                                      context.read<QuotestabController>().selectlookingfor(ind);
                            //                                     // context.read<QuotestabController>().filterlookingforcolumn[ind].ischecck= !context.read<QuotestabController>().filterlookingforcolumn[ind].ischecck;
                            //                                   });
          
                            //                                 },
                            //                                 child: Container(
                            //                                   // alignment: Alignment.center,
                            //                                   // width: Screens.width(context) * 0.2,
                            //                                   // height: Screens.bodyheight(context) * 0.06,
                            //                                   padding: EdgeInsets.all(5),
                            //                                   decoration: BoxDecoration(
                            //                                       color: context
                            //                         .watch<QuotestabController>()
                            //                         .filterlookingforcolumn[ind]
                            //                         .ischecck ==
                            //                                                   true
                            //                                           ? theme.primaryColor
                            //                                           : Colors.white,
                            //                                       border: Border.all(color: theme.primaryColor, width: 1),
                            //                                       borderRadius: BorderRadius.circular(5)),
                            //                                   child: Text(
                            //                                       context
                            //                                           .watch<QuotestabController>()
                            //                                           .filterlookingforcolumn[ind]
                            //                                           .name!,
                            //                                       // maxLines: 1,
                            //                                       //overflow: TextOverflow.ellipsis,
                            //                                       style: theme.textTheme.bodyText2?.copyWith(
                            //                                         fontWeight: FontWeight.normal,
                            //                                         fontSize: 12,
                            //                                         color: context
                            //                           .watch<QuotestabController>()
                            //                           .filterlookingforcolumn[ind]
                            //                           .ischecck ==
                            //                       true
                            //                                             //content[index].isselected == 1
                            //                                             ? Colors.white
                            //                                             : theme.primaryColor,
                            //                                       )),
                            //                                 ),
                            //                               )
                            //                           //   }
                            //                           // ),
                            //                       )
          
                            //                                                   // listContainersProduct(
                            //                                                   //       theme,
                            //                                                   // )
                            //                                                   ),
                            //                                           ),
                            //                                         ),
          
                            //                                                   Container(
                            //                                 width: Screens.width(context),
                            //                                 height: Screens.bodyheight(context) * 0.06,
                            //                                 child: ElevatedButton(
                            //                                     onPressed: () {
                            //                                       Navigator.pop(context);
                            //                                      context.read<QuotestabController>(). addlookingfor();
                            //                                     },
                            //                                     style: ElevatedButton.styleFrom(
                            //                                       textStyle: TextStyle(
                            //                                           // fontSize: 12,
                            //                                           ),
                            //                                       shape: RoundedRectangleBorder(
                            //                                           borderRadius: BorderRadius.only(
                            //                                         bottomLeft: Radius.circular(10),
                            //                                         bottomRight: Radius.circular(10),
                            //                                       )), //Radius.circular(6)
                            //                                     ),
                            //                                     child: Text(
                            //                                       "Ok",
                            //                                     )),
                            //                               ),
                            //                           ],),
                            //                           )
                            //                                                   );
                            //                                                 }
                            //                                               );
          
                            //                                             });
                            //                         });
                            //                       },
                            //                         readOnly: true,
                            //                       decoration: InputDecoration(
                            //                         contentPadding: EdgeInsets.all(8.0),
                            //                         border:InputBorder.none,
                            //                         disabledBorder :OutlineInputBorder(
                            //                           borderSide: BorderSide.none
                            //                         ),
                            //                         enabledBorder:OutlineInputBorder(
                            //                           borderSide: BorderSide.none
                            //                         ),
                            //                         focusedBorder:OutlineInputBorder(
                            //                           borderSide: BorderSide.none
                            //                         ),
                            //                         suffixIcon: Icon(Icons.arrow_drop_down)
                            //                       ),
          
                            //                       ),
                            //                 context.watch<QuotestabController>().lookingforcolumnforshow.isEmpty
                            //  ?Container():
                            //           Container(
                            //                 width: Screens.width(context),
                            //                 height: Screens.padingHeight(context)*0.1,
                            //                 padding: EdgeInsets.only(
                            //                   top:  Screens.padingHeight(context)*0.002,
                            //                 left: Screens.width(context)*0.002,
                            //                 ),
                            //                 // decoration: BoxDecoration(
                            //                 //   borderRadius: BorderRadius.only(
                            //                 //     bottomLeft: Radius.circular(8),
                            //                 //     bottomRight: Radius.circular(8)
          
                            //                 //   ),
                            //                 //   border: Border.all(
          
                            //                 //     color: Colors.black26
                            //                 //   )
                            //                 // ),
                            //                 // color: Colors.amber,
                            //                 child: SingleChildScrollView(
                            //             child: Wrap(
                            //                 spacing: 5.0, // gap between adjacent chips
                            //                 runSpacing: 5.0, // gap between lines
                            //                 children: listContainersProducttoshow(
                            //                   theme,
                            //                 )),
                            //             ),
                            //               ),
                            //                     ],
                            //                   ),
          
                            //             ),
          
                            //           ],
                            //         ),
                            //       ),
                            //               ),
                            //new interest
          
                            Container(
                              width: Screens.width(context),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Screens.width(context) * 0.02,
                                    right: Screens.width(context) * 0.02,
                                    top: Screens.padingHeight(context) * 0.01),
                                child: Column(
                                  children: [
                                    Container(
                                      // color:Colors.amber,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                      child: Column(
                                        children: [
                                          TextField(
                                            onTap: () {
                                              setState(() {
                                                context
                                                    .read<QuotestabController>()
                                                    .ontaporder();
                                              });
                                            },
                                            readOnly: true,
                                            decoration: InputDecoration(
                                                hintText: "Order Type",
                                                contentPadding:
                                                    EdgeInsets.all(8.0),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none),
                                                // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none),
                                                // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none),
                                                // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none),
                                                hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                                // // UnderlineInputBorder(
                                                //   borderSide: BorderSide(color: Colors.grey)
                                                // ),
                                                suffixIcon: Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          context
                                                          .watch<
                                                              QuotestabController>()
                                                          .isorder ==
                                                      true &&
                                                  context
                                                      .watch<
                                                          QuotestabController>()
                                                      .ordercolumn
                                                      .isNotEmpty
                                              ? Container(
                                                  height: Screens.padingHeight(
                                                          context) *
                                                      0.2,
                                                  // color:Colors.amber,
                                                  child: SingleChildScrollView(
                                                    child: ListBody(
                                                        children: context
                                                            .watch<
                                                                QuotestabController>()
                                                            .ordercolumn
                                                            .map((item) =>
                                                                CheckboxListTile(
                                                                  value: context
                                                                      .watch<
                                                                          QuotestabController>()
                                                                      .selectedorder
                                                                      .contains(item
                                                                          .name),
                                                                  title: Text(
                                                                      item.name),
                                                                  controlAffinity:
                                                                      ListTileControlAffinity
                                                                          .leading,
                                                                  onChanged: (ischecked) => context
                                                                      .read<
                                                                          QuotestabController>()
                                                                      .itemselectorder(
                                                                          item.name,
                                                                          ischecked!),
                                                                ))
                                                            .toList()),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //          Container(
                            // width: Screens.width(context),
                            // child: Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Container(
                            //           child: Text(
                            //         "Order Type",
                            //         style: theme.textTheme.bodyMedium!.copyWith(
                            //             color: theme.primaryColor, fontSize: 15),
                            //       )),
                            //       SizedBox(
                            //         height: Screens.padingHeight(context) * 0.01,
                            //       ),
                            //       Container(
                            //         // color: Colors.amber,
                            //         width: Screens.width(context),
                            //         padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                            //         height: Screens.padingHeight(context) * 0.06,
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(8),
                            //             border: Border.all(color: Colors.black26)),
                            //         child: DropdownButton(
                            //           isExpanded: true,
                            //           underline: SizedBox.shrink(),
                            //           value:context.read<QuotestabController>(). ordertypevalue,
                            //           icon: Icon(Icons.arrow_drop_down),
                            //           iconSize: 30,
                            //           onChanged: ( val) {
                            //             setState(() {
                            //           context.read<QuotestabController>(). selectordertype(val.toString());
          
                            //             });
                            //           },
                            //           items: context.read<QuotestabController>().ordercolumn . map((e) {
                            //             return DropdownMenuItem<String>(
                            //                 value: "${e.name}",
                            //                 child: Container(child: Text("${e.name.toString()}")));
                            //           }).toList(),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            //         ),
                            //         Container(
                            // width: Screens.width(context),
                            // child: Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Container(
                            //           child: Text(
                            //         "Age Above",
                            //         style: theme.textTheme.bodyMedium!.copyWith(
                            //             color: theme.primaryColor, fontSize: 15),
                            //       )),
                            //       SizedBox(
                            //         height: Screens.padingHeight(context) * 0.01,
                            //       ),
                            //       Container(
                            //         // color: Colors.amber,
                            //         width: Screens.width(context),
          
                            //         height: Screens.padingHeight(context) * 0.06,
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(8),
                            //             border: Border.all(color: Colors.black26)),
                            //         child: TextField(
                            //           // controller: context.read<Outstandingcontroller>().mycontroller[4],
                            //           keyboardType: TextInputType.number,
                            //           decoration: InputDecoration(
                            //             hintText: "Age",
                            //             enabledBorder: InputBorder.none,
                            //             focusedBorder: InputBorder.none,
                            //             // suffixIcon: Icon(
                            //             //   Icons.search,
                            //             //   color: theme.primaryColor,
                            //             // ),
                            //             contentPadding: const EdgeInsets.symmetric(
                            //               vertical: 10,
                            //               horizontal: 5,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            //         ),
                            //Balance Above
                            Container(
                              // color:Colors.red,
                              width: Screens.width(context),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Screens.width(context) * 0.02,
                                    right: Screens.width(context) * 0.02,
                                    top: Screens.padingHeight(context) * 0.01),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //     child: Text(
                                    //   "Value Above",
                                    //   style: theme.textTheme.bodyMedium!.copyWith(
                                    //       color: theme.primaryColor, fontSize: 15),
                                    // )),
                                    // SizedBox(
                                    //   height: Screens.padingHeight(context) * 0.01,
                                    // ),
                                    Container(
                                      // color: Colors.amber,
                                      width: Screens.width(context),
          
                                      // height: Screens.padingHeight(context) * 0.06,
                                      decoration: BoxDecoration(
                                          // borderRadius: BorderRadius.circular(8),
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                      child: TextField(
                                        controller: context
                                            .read<QuotestabController>()
                                            .mycontroller[23],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: "Value Above",
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          // suffixIcon: Icon(
                                          //   Icons.search,
                                          //   color: theme.primaryColor,
                                          // ),
                                          hintStyle: TextStyle(
                                              color: Colors.black, fontSize: 15),
                                          // theme.textTheme.bodyMedium!.copyWith(
                                          // color: theme.primaryColor, fontSize: 15),
          
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.001,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            width: Screens.width(context) * 0.3,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  context
                                      .read<QuotestabController>()
                                      .clearfilterval();
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)))),
                                child: Text("Cancel"))),
                        Container(
                            width: Screens.width(context) * 0.3,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.pop(context);
          
                                    context
                                        .read<QuotestabController>()
                                        .applyBtnMethod(context);
                                  });
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)))),
                                child: Text("Apply")))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> listContainersProduct(
    ThemeData theme,
  ) {
    return List.generate(
        context.watch<QuotestabController>().filterlookingforcolumn.length,
        (ind) =>
            // StatefulBuilder(
            //   builder: (context,st) {
            GestureDetector(
              onTap: () {
                // context.read<QuotestabController>().selectedIdxFUser = ind;
                // st(() {
                //  context.read<QuotestabController>().selectlookingfor(ind);
                context
                        .read<QuotestabController>()
                        .filterlookingforcolumn[ind]
                        .ischecck =
                    !context
                        .read<QuotestabController>()
                        .filterlookingforcolumn[ind]
                        .ischecck;
                // });
              },
              child: Container(
                // alignment: Alignment.center,
                // width: Screens.width(context) * 0.2,
                // height: Screens.bodyheight(context) * 0.06,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: context
                                .watch<QuotestabController>()
                                .filterlookingforcolumn[ind]
                                .ischecck ==
                            true
                        ? theme.primaryColor
                        : Colors.white,
                    border: Border.all(color: theme.primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                    context
                        .watch<QuotestabController>()
                        .filterlookingforcolumn[ind]
                        .name!,
                    // maxLines: 1,
                    //overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: context
                                  .watch<QuotestabController>()
                                  .filterlookingforcolumn[ind]
                                  .ischecck ==
                              true
                          //content[index].isselected == 1
                          ? Colors.white
                          : theme.primaryColor,
                    )),
              ),
            )
        //   }
        // ),
        );
  }

  List<Widget> listContainersProducttoshow(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<QuotestabController>().lookingforcolumnforshow.length,
      (ind) => StatefulBuilder(builder: (context, st) {
        return GestureDetector(
          onTap: () {
            // context.read<QuotestabController>().selectedIdxFUser = ind;
            // st(() {
            //    context.read<QuotestabController>().selectlookingfor(ind);
            //   // context.read<QuotestabController>().lookingforcolumn[ind].ischecck= !context.read<QuotestabController>().lookingforcolumn[ind].ischecck;
            // });
          },
          child: Container(
            // alignment: Alignment.center,
            // width: Screens.width(context) * 0.2,
            // height: Screens.bodyheight(context) * 0.06,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context
                            .watch<QuotestabController>()
                            .lookingforcolumnforshow[ind]
                            .ischecck ==
                        true
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
                context
                    .watch<QuotestabController>()
                    .lookingforcolumnforshow[ind]
                    .name!,
                // maxLines: 1,
                //overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: context
                              .watch<QuotestabController>()
                              .lookingforcolumnforshow[ind]
                              .ischecck ==
                          true
                      //content[index].isselected == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        );
      }),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sellerkit/Constant/Screen.dart';
// import 'package:sellerkit/Controller/QuotationController/tabquotescontroller.dart';

// class navDrawerQuotes extends StatefulWidget {
//   const navDrawerQuotes({Key? key}) : super(key: key);

//   @override
//   State<navDrawerQuotes> createState() => _navDrawerQuotesState();
// }

// class _navDrawerQuotesState extends State<navDrawerQuotes> {
//   selectcusname(String val) {
//     setState(() {
//       context.read<QuotestabController>().cusnamevalue = val;
//     });
//   }

//   selectlookingfor(String val) {
//     setState(() {
//       context.read<QuotestabController>().lookingforvalue = val;
//     });
//   }

//   selectordertype(String val) {
//     setState(() {
//       context.read<QuotestabController>().ordertypevalue = val;
//     });
//   }

//   selectEnqstatus(String val) {
//     setState(() {
//       context.read<QuotestabController>().enquirystatusvalue = val;
//     });
//   }

//   selectInterestLevel(String val) {
//     setState(() {
//       context.read<QuotestabController>().levelofInterest = val;
//     });
//   }

//   void selectassign(String val) {
//     setState(() {
//       context.read<QuotestabController>().assignvalue = val;
//     });
//   }

//   // String? dropdownValue2;
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Drawer(
//       child: ListView(
//         children: [
//           Container(
//             child: SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.only(
//                     // left: Screens.width(context) * 0.01
//                     // right: Screens.width(context) * 0.02,
//                     bottom: Screens.padingHeight(context) * 0.03),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       alignment: Alignment.bottomCenter,
//                       height: Screens.padingHeight(context) * 0.06,
//                       width: Screens.width(context),
//                       padding: EdgeInsets.only(bottom: 10),
//                       decoration: BoxDecoration(
//                           color: theme.primaryColor,
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(
//                                 Screens.padingHeight(context) * 0.05),
//                             bottomRight: Radius.circular(
//                                 Screens.padingHeight(context) * 0.05),
//                           )),
//                       child: Text(
//                         "Quotation",
//                         style: theme.textTheme.bodyText2!
//                             .copyWith(color: Colors.white),
//                       ),
//                     ),
//                     SizedBox(
//                       height: Screens.padingHeight(context) * 0.02,
//                     ),
//                     // Container(
//                     //   width: Screens.width(context),
//                     //   child:
//                     Container(
//                       padding: EdgeInsets.only(
//                         left: Screens.width(context) * 0.02,
//                         right: Screens.width(context) * 0.03,
//                       ),
//                       child: SingleChildScrollView(
//                         child: Form(
//                           key: context.read<QuotestabController>().formkey[0],
//                           child: Column(
//                             children: [
//                                   Container(
//                             width: Screens.width(context),
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                   left: Screens.width(context) * 0.02,
//                                   right: Screens.width(context) * 0.02,
//                                   top: Screens.padingHeight(context) * 0.01),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     // color:Colors.amber,
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                             bottom: BorderSide(
//                                                 color: Colors.grey))),
//                                     child: Column(
//                                       children: [
//                                         TextField(
//                                           onTap: () {
//                                             setState(() {
//                                               context
//                                                   .read<QuotestabController>()
//                                                   .ontapassignto();
//                                             });
//                                           },
//                                           readOnly: true,
//                                           decoration: InputDecoration(
//                                               hintText: "Assigned to",
//                                               hintStyle: TextStyle(
//                                                   color: Colors.black,
//                                                   fontSize: 15),
//                                               contentPadding:
//                                                   EdgeInsets.all(8.0),
//                                               border: OutlineInputBorder(
//                                                   borderSide: BorderSide.none),
//                                               // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//                                               disabledBorder:
//                                                   OutlineInputBorder(
//                                                       borderSide:
//                                                           BorderSide.none),
//                                               // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//                                               enabledBorder: OutlineInputBorder(
//                                                   borderSide: BorderSide.none),
//                                               // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//                                               focusedBorder: OutlineInputBorder(
//                                                   borderSide: BorderSide.none),
//                                               // // UnderlineInputBorder(
//                                               //   borderSide: BorderSide(color: Colors.grey)
//                                               // ),
//                                               suffixIcon: Icon(
//                                                 Icons.arrow_drop_down,
//                                                 color: Colors.black,
//                                               )),
//                                         ),
//                                         context
//                                                         .watch<
//                                                             QuotestabController>()
//                                                         .isassignto ==
//                                                     true &&
//                                                 context
//                                                     .watch<
//                                                         QuotestabController>()
//                                                     .assigncolumn
//                                                     .isNotEmpty
//                                             ? Container(
//                                                 height: Screens.padingHeight(
//                                                         context) *
//                                                     0.2,
//                                                 // color:Colors.amber,
//                                                 child: SingleChildScrollView(
//                                                   child: ListBody(
//                                                       children: context
//                                                           .watch<
//                                                               QuotestabController>()
//                                                           .assigncolumn
//                                                           .map((item) =>
//                                                               CheckboxListTile(
//                                                                 value: context
//                                                                     .watch<
//                                                                         QuotestabController>()
//                                                                     .selectedassignto
//                                                                     .contains(item
//                                                                         .name),
//                                                                 title: Text(
//                                                                     item.name),
//                                                                 controlAffinity:
//                                                                     ListTileControlAffinity
//                                                                         .leading,
//                                                                 onChanged: (ischecked) => context
//                                                                     .read<
//                                                                         QuotestabController>()
//                                                                     .itemselectassignto(
//                                                                         item.name,
//                                                                         ischecked!),
//                                                               ))
//                                                           .toList()),
//                                                 ),
//                                               )
//                                             : Container()
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),

//                               // Container(
//                               //     padding: EdgeInsets.only(
//                               //         left: Screens.width(context) * 0.01),
//                               //     alignment: Alignment.centerLeft,
//                               //     child: Text(
//                               //       "Assigned to",
//                               //       style: theme.textTheme.bodyMedium!.copyWith(
//                               //           color: theme.primaryColor,
//                               //           fontSize: 15),
//                               //     )),
//                               // SizedBox(
//                               //   height: Screens.padingHeight(context) * 0.005,
//                               // ),
//                               // Container(
//                               //   // color: Colors.amber,
//                               //   width: Screens.width(context),
//                               //   padding: EdgeInsets.only(
//                               //     left: Screens.padingHeight(context) * 0.02,
//                               //   ),

//                               //   height: Screens.padingHeight(context) * 0.05,
//                               //   decoration: BoxDecoration(
//                               //       borderRadius: BorderRadius.circular(8),
//                               //       border: Border.all(color: Colors.black26)),
//                               //   child: DropdownButton(
//                               //     isExpanded: true,
//                               //     underline: SizedBox.shrink(),
//                               //     value: context
//                               //         .read<QuotestabController>()
//                               //         .assignvalue,
//                               //     icon: Icon(Icons.arrow_drop_down),
//                               //     iconSize: 30,
//                               //     onChanged: (val) {
//                               //       setState(() {
//                               //         selectassign(val.toString());
//                               //         //  context.read<Outstandingcontroller>(). assignvalue  = val!;
//                               //       });
//                               //     },
//                               //     items: context
//                               //         .read<QuotestabController>()
//                               //         .quotFilterList2
//                               //         .map((e) {
//                               //       return DropdownMenuItem(
//                               //           value: e.assignTo,
//                               //           child: Text(e.assignTo.toString()));
//                               //     }).toList(),
//                               //   ),
//                               // ),

//                               SizedBox(
//                                 height: Screens.padingHeight(context) * 0.01,
//                               ),
//                               //  Customer
//                               Container(
//                                   padding: EdgeInsets.only(
//                                       left: Screens.width(context) * 0.01),
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "Customer Name",
//                                     style: theme.textTheme.bodyMedium!.copyWith(
//                                         color: theme.primaryColor,
//                                         fontSize: 15),
//                                   )),
//                               SizedBox(
//                                 height: Screens.padingHeight(context) * 0.005,
//                               ),
//                               Container(
//                                 // color: Colors.amber,
//                                 width: Screens.width(context),
//                                 padding: EdgeInsets.only(
//                                     top: 1, left: 10, right: 10),
//                                 height: Screens.padingHeight(context) * 0.05,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8),
//                                     border: Border.all(color: Colors.black26)),
//                                 child: DropdownButton(
//                                   isExpanded: true,
//                                   underline: SizedBox.shrink(),
//                                   value: context
//                                       .read<QuotestabController>()
//                                       .cusnamevalue,
//                                   icon: Icon(Icons.arrow_drop_down),
//                                   iconSize: 30,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       selectcusname(val.toString());
//                                     });
//                                   },
//                                   items: context
//                                       .read<QuotestabController>()
//                                       .quotFilterList3
//                                       .map((e) {
//                                     return DropdownMenuItem<String>(
//                                         value: "${e.custName}",
//                                         child: Container(
//                                             child:
//                                                 Text(e.custName.toString())));
//                                   }).toList(),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: Screens.padingHeight(context) * 0.01,
//                               ),
//                               //Trans Number
//                               Container(
//                                   padding: EdgeInsets.only(
//                                       left: Screens.width(context) * 0.01),
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "From Date",
//                                     style: theme.textTheme.bodyMedium!.copyWith(
//                                         color: theme.primaryColor,
//                                         fontSize: 15),
//                                   )),
//                               SizedBox(
//                                 height: Screens.padingHeight(context) * 0.005,
//                               ),
//                               Container(
//                                 // color: Colors.amber,
//                                 width: Screens.width(context),
//                                 height: Screens.padingHeight(context) * 0.05,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8),
//                                     border: Border.all(color: Colors.black26)),
//                                 child: TextFormField(
//                                   onTap: () {
//                                     context
//                                         .read<QuotestabController>()
//                                         .showfromDate(context);
//                                   },
//                                   controller: context
//                                       .read<QuotestabController>()
//                                       .mycontroller[21],
//                                   decoration: InputDecoration(
//                                     hintText: "",
//                                     enabledBorder: InputBorder.none,
//                                     focusedBorder: InputBorder.none,
//                                     suffixIcon: IconButton(
//                                       onPressed: () {
//                                         context
//                                             .read<QuotestabController>()
//                                             .showfromDate(context);
//                                       },
//                                       icon: Icon(
//                                         Icons.calendar_month,
//                                         color: theme.primaryColor,
//                                       ),
//                                     ),
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       vertical: 10,
//                                       horizontal: 5,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: Screens.padingHeight(context) * 0.01,
//                               ),
//                               //Loan number
//                               Container(
//                                   padding: EdgeInsets.only(
//                                       left: Screens.width(context) * 0.01),
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "To Date",
//                                     style: theme.textTheme.bodyMedium!.copyWith(
//                                         color: theme.primaryColor,
//                                         fontSize: 15),
//                                   )),
//                               SizedBox(
//                                 height: Screens.padingHeight(context) * 0.005,
//                               ),
//                               Container(
//                                 // color: Colors.amber,
//                                 width: Screens.width(context),

//                                 height: Screens.padingHeight(context) * 0.05,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8),
//                                     border: Border.all(color: Colors.black26)),
//                                 child: TextFormField(
//                                   // validator: (value) {
//                                   //   if (value!.isEmpty) {
//                                   //     return "Enter the to date";
//                                   //   }
//                                   //   return null;
//                                   // },
//                                   onTap: () {
//                                     context
//                                         .read<QuotestabController>()
//                                         .showToDate(context);
//                                   },
//                                   controller: context
//                                       .read<QuotestabController>()
//                                       .mycontroller[22],
//                                   decoration: InputDecoration(
//                                     hintText: "",
//                                     enabledBorder: InputBorder.none,
//                                     focusedBorder: InputBorder.none,
//                                     suffixIcon: IconButton(
//                                       onPressed: () {
//                                         context
//                                             .read<QuotestabController>()
//                                             .showToDate(context);
//                                       },
//                                       icon: Icon(
//                                         Icons.calendar_month,
//                                         color: theme.primaryColor,
//                                       ),
//                                     ),
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       vertical: 10,
//                                       horizontal: 5,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               //age Above
//                               //status
//                               SizedBox(
//                                 height: Screens.padingHeight(context) * 0.01,
//                               ),
//                               Container(
//                                   padding: EdgeInsets.only(
//                                       left: Screens.width(context) * 0.01),
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "*Quotation Status",
//                                     style: theme.textTheme.bodyMedium!.copyWith(
//                                         color: theme.primaryColor,
//                                         fontSize: 15),
//                                   )),
//                               SizedBox(
//                                 height: Screens.padingHeight(context) * 0.005,
//                               ),
//                               Container(
//                                 // color: Colors.amber,
//                                 width: Screens.width(context),
//                                 padding: EdgeInsets.only(
//                                     top: 1, left: 10, right: 10),
//                                 height: Screens.padingHeight(context) * 0.05,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8),
//                                     border: Border.all(color: Colors.black26)),
//                                 child: DropdownButton(
//                                   isExpanded: true,
//                                   underline: SizedBox.shrink(),
//                                   value: context
//                                       .read<QuotestabController>()
//                                       .enquirystatusvalue,
//                                   icon: Icon(Icons.arrow_drop_down),
//                                   iconSize: 30,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       selectEnqstatus(val.toString());
//                                     });
//                                   },
//                                   items: context
//                                       .read<QuotestabController>()
//                                       .quotFilterList4
//                                       .map((e) {
//                                     return DropdownMenuItem<String>(
//                                         value: "${e.OrderStatus}",
//                                         child: Container(
//                                             child: Text(
//                                                 e.OrderStatus.toString())));
//                                   }).toList(),
//                                 ),
//                               ),
                              // context
                              //         .read<QuotestabController>()
                              //         .stserror
                              //         .isNotEmpty
                              //     ? Container(
                              //         padding: EdgeInsets.only(
                              //             left: Screens.width(context) * 0.01),
                              //         alignment: Alignment.centerLeft,
                              //         child: Text(
                              //             context
                              //                 .read<QuotestabController>()
                              //                 .stserror,
                              //             style: theme.textTheme.bodyMedium!
                              //                 .copyWith(
                              //               color: Colors.red,
                              //             )),
                              //       )
                              //     : Container(),
//                               //looking for
//                               SizedBox(
//                                 height: Screens.padingHeight(context) * 0.01,
//                               ),
//                               Container(
//                                   padding: EdgeInsets.only(
//                                       left: Screens.width(context) * 0.01),
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "Level of Interest",
//                                     style: theme.textTheme.bodyMedium!.copyWith(
//                                         color: theme.primaryColor,
//                                         fontSize: 15),
//                                   )),
//                               SizedBox(
//                                 height: Screens.padingHeight(context) * 0.005,
//                               ),
//                               Container(
//                                   // color: Colors.amber,
//                                   width: Screens.width(context),
//                                   padding: EdgeInsets.only(
//                                       top: 1, left: 10, right: 10),
//                                   height: Screens.padingHeight(context) * 0.05,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(8),
//                                       border:
//                                           Border.all(color: Colors.black26)),
//                                   child: DropdownButton(
//                                     isExpanded: true,
//                                     underline: SizedBox.shrink(),
//                                     value: context
//                                         .read<QuotestabController>()
//                                         .levelofInterest,
//                                     // icon: Icon(Icons.arrow_drop_down),
//                                     iconSize: 30,
//                                     onChanged: (val) {
//                                       setState(() {
//                                         selectInterestLevel(val.toString());
//                                       });
//                                     },
//                                     items: context
//                                         .read<QuotestabController>()
//                                         .leveofdata
//                                         .map((e) {
//                                       return DropdownMenuItem<String>(
//                                           value: e.Name,
//                                           child: Text("${e.Name}"));
//                                     }).toList(),
//                                   )),
//                               //           Container(
//                               // width: Screens.width(context),
//                               // child: Padding(
//                               //   padding: const EdgeInsets.all(8.0),
//                               //   child: Column(
//                               //     crossAxisAlignment: CrossAxisAlignment.start,
//                               //     children: [
//                               //       Container(
//                               //           child: Text(
//                               //         "Lookingfor",
//                               //         style: theme.textTheme.bodyMedium!.copyWith(
//                               //             color: theme.primaryColor, fontSize: 15),
//                               //       )),
//                               //       SizedBox(
//                               //         height:Screens.padingHeight(context) * 0.005,
//                               //       ),
//                               //       Container(
//                               //         // color: Colors.amber,
//                               //         width: Screens.width(context),
//                               //         padding: EdgeInsets.only(top: 1, left: 10, right: 10),
//                               //         height: Screens.padingHeight(context) * 0.05,
//                               //         decoration: BoxDecoration(
//                               //             borderRadius: BorderRadius.circular(8),
//                               //             border: Border.all(color: Colors.black26)),
//                               //         child: DropdownButton(
//                               //           isExpanded: true,
//                               //           underline: SizedBox.shrink(),
//                               //           value: lookingforvalue,
//                               //           icon: Icon(Icons.arrow_drop_down),
//                               //           iconSize: 30,
//                               //           onChanged: ( val) {
//                               //             setState(() {
//                               //            selectlookingfor(val.toString());

//                               //             });
//                               //           },
//                               //           items:lookingforcolumn. map((e) {
//                               //             return DropdownMenuItem<String>(
//                               //                 value: "${e}",
//                               //                 child: Container(child: Text("${e.toString()}")));
//                               //           }).toList(),
//                               //         ),
//                               //       )
//                               //     ],
//                               //   ),
//                               // ),
//                               //         ),
//                               //         Container(
//                               // width: Screens.width(context),
//                               // child: Padding(
//                               //   padding: const EdgeInsets.all(8.0),
//                               //   child: Column(
//                               //     crossAxisAlignment: CrossAxisAlignment.start,
//                               //     children: [
//                               //       Container(
//                               //           child: Text(
//                               //         "Age Above",
//                               //         style: theme.textTheme.bodyMedium!.copyWith(
//                               //             color: theme.primaryColor, fontSize: 15),
//                               //       )),
//                               //       SizedBox(
//                               //         height:Screens.padingHeight(context) * 0.005,
//                               //       ),
//                               //       Container(
//                               //         // color: Colors.amber,
//                               //         width: Screens.width(context),

//                               //         height: Screens.padingHeight(context) * 0.05,
//                               //         decoration: BoxDecoration(
//                               //             borderRadius: BorderRadius.circular(8),
//                               //             border: Border.all(color: Colors.black26)),
//                               //         child: TextField(
//                               //           // controller: context.read<Outstandingcontroller>().mycontroller[4],
//                               //           keyboardType: TextInputType.number,
//                               //           decoration: InputDecoration(
//                               //             hintText: "Age",
//                               //             enabledBorder: InputBorder.none,
//                               //             focusedBorder: InputBorder.none,
//                               //             // suffixIcon: Icon(
//                               //             //   Icons.search,
//                               //             //   color: theme.primaryColor,
//                               //             // ),
//                               //             contentPadding: const EdgeInsets.symmetric(
//                               //               vertical: 10,
//                               //               horizontal: 5,
//                               //             ),
//                               //           ),
//                               //         ),
//                               //       ),
//                               //     ],
//                               //   ),
//                               // ),
//                               //         ),
//                               SizedBox(
//                                 height: Screens.padingHeight(context) * 0.01,
//                               ),
//                               Container(
//                                   padding: EdgeInsets.only(
//                                       left: Screens.width(context) * 0.01),
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "Order Type",
//                                     style: theme.textTheme.bodyMedium!.copyWith(
//                                         color: theme.primaryColor,
//                                         fontSize: 15),
//                                   )),
//                               SizedBox(
//                                 height: Screens.padingHeight(context) * 0.005,
//                               ),
//                               Container(
//                                   // color: Colors.amber,
//                                   width: Screens.width(context),
//                                   padding: EdgeInsets.only(
//                                       top: 1, left: 10, right: 10),
//                                   height: Screens.padingHeight(context) * 0.05,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(8),
//                                       border:
//                                           Border.all(color: Colors.black26)),
//                                   child: DropdownButton(
//                                     isExpanded: true,
//                                     underline: SizedBox.shrink(),
//                                     value: context
//                                         .read<QuotestabController>()
//                                         .ordertypevalue,
//                                     // icon: Icon(Icons.arrow_drop_down),
//                                     iconSize: 30,
//                                     onChanged: (val) {
//                                       setState(() {
//                                         selectordertype(val.toString());
//                                       });
//                                     },
//                                     items: context
//                                         .read<QuotestabController>()
//                                         .ordertypedata
//                                         .map((e) {
//                                       return DropdownMenuItem<String>(
//                                           value: e.Name,
//                                           child: Text("${e.Name}"));
//                                     }).toList(),
//                                   )),
//                               SizedBox(
//                                 height: Screens.padingHeight(context) * 0.01,
//                               ),
//                               //Balance Above
//                               Container(
//                                   padding: EdgeInsets.only(
//                                       left: Screens.width(context) * 0.01),
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "Value Above",
//                                     style: theme.textTheme.bodyMedium!.copyWith(
//                                         color: theme.primaryColor,
//                                         fontSize: 15),
//                                   )),
//                               SizedBox(
//                                 height: Screens.padingHeight(context) * 0.005,
//                               ),
//                               Container(
//                                 // color: Colors.amber,
//                                 width: Screens.width(context),
//                                 height: Screens.padingHeight(context) * 0.055,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8),
//                                     border: Border.all(color: Colors.black26)),
//                                 child: TextFormField(
//                                   controller: context
//                                       .read<QuotestabController>()
//                                       .mycontroller[23],
//                                   decoration: InputDecoration(
//                                     hintText: "",
//                                     enabledBorder: InputBorder.none,
//                                     focusedBorder: InputBorder.none,
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       vertical: 10,
//                                       horizontal: 5,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     // SizedBox(height: Screens.padingHeight(context)*0.001,),
//                     SizedBox(
//                       height: Screens.padingHeight(context) * 0.03,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                             width: Screens.width(context) * 0.3,
//                             child: ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 style: ButtonStyle(
//                                     shape: MaterialStateProperty.all<
//                                             RoundedRectangleBorder>(
//                                         RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(5)))),
//                                 child: Text("Cancel"))),
//                         Container(
//                             width: Screens.width(context) * 0.3,
//                             child: ElevatedButton(
//                                 onPressed: () async {
//                                   setState(() {
//                                     context
//                                         .read<QuotestabController>()
//                                         .applyBtnMethod(context);
//                                   });
//                                 },
//                                 style: ButtonStyle(
//                                     shape: MaterialStateProperty.all<
//                                             RoundedRectangleBorder>(
//                                         RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(5)))),
//                                 child: Text("Apply")))
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sellerkit/Constant/Screen.dart';
// import 'package:sellerkit/Controller/OrderController/TabOrderController.dart';
// import 'package:sellerkit/Controller/QuotationController/tabquotescontroller.dart';

// class navDrawerQuotes extends StatefulWidget {
//   const navDrawerQuotes({Key? key}) : super(key: key);

//   @override
//   State<navDrawerQuotes> createState() => _navDrawerQuotesState();
// }

// class _navDrawerQuotesState extends State<navDrawerQuotes> {
//   String? dropdownValue;
//   String? assignvalue;
//    String? cusnamevalue;
//    String? Enquirystatusvalue;
//    String? lookingforvalue;
//      String? ordertypevalue;
//   selectcusname(String val) {
//     setState(() {
//        cusnamevalue = val;
//     });
   
    
//   }
//   selectlookingfor(String val) {
//     setState(() {
//        lookingforvalue = val;
//     });
   
    
//   }
//   selectordertype(String val) {
//     setState(() {
//        ordertypevalue = val;
//     });
   
    
//   }
//   selectEnqstatus(String val) {
//     setState(() {
//        Enquirystatusvalue = val;
//     });
   
    
//   }
//  List<String> assigncolumn=['684',"1053","622"];
//  List<String> customercolumn=['Kayal','pavi','Nirmala'];
//  List<String> Enquirystatuscolumn=['Open','Closed','Lost'];
//   List<String> lookingforcolumn=['AF','sellerkit','SAP'];
//    List<String> ordertypecolumn=['type1','type2','type3'];
//  void  selectassign(String val) {
//    setState(() {
//       assignvalue = val;
//    });
   
   
//   }
//   // String? dropdownValue2;
//   @override

//   Widget build(BuildContext context) {
//     final theme=Theme.of(context);
//     return Drawer(
//       // backgroundColor: Colors.grey[300],
//       child: ListView(
//         children: [
//            Container(
//       // color: Colors.amber,
//       // width: 50,
//       // height: Screens.bodyheight(context)*0.1,
//       // padding: EdgeInsets.symmetric(
//       //     horizontal: Screens.width(context) * 0.02,
//       //     vertical: Screens.padingHeight(context) * 0.004),
//       child: SingleChildScrollView(
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//                       alignment: Alignment.bottomCenter,
//                       height: Screens.padingHeight(context)*0.1,
//                      width: Screens.width(context),
//                      padding: EdgeInsets.only(bottom: 10),
//                      decoration: BoxDecoration(
//                       color: theme.primaryColor,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft:Radius.circular(Screens.padingHeight(context)*0.05),
//                      bottomRight: Radius.circular(Screens.padingHeight(context)*0.05),
//                       )

//                      ),
//                      child: Text("Quotation",style: theme.textTheme.bodyText2!.copyWith(color: Colors.white),),
//                     ),
//             Container(
//               width: Screens.width(context),
//                height: Screens.bodyheight(context)*0.85,
//                 // height: Screens.bodyheight(context)*0.86,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
                    
//                     Container(
//                       width: Screens.width(context),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                                 child: Text(
//                               "Assigned to",
//                               style: theme.textTheme.bodyMedium!.copyWith(
//                                   color: theme.primaryColor, fontSize: 15),
//                             )),
//                             SizedBox(
//                               height: Screens.padingHeight(context) * 0.01,
//                             ),
//                             Container(
//                               // color: Colors.amber,
//                               width: Screens.width(context),
//                               padding: EdgeInsets.only(top: 1, left: 10, right: 10),
//                               height: Screens.padingHeight(context) * 0.06,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8),
//                                   border: Border.all(color: Colors.black26)),
//                               child: DropdownButton(
//                                 isExpanded: true,
//                                 underline: SizedBox.shrink(),
//                                 value:  assignvalue,
//                                 icon: Icon(Icons.arrow_drop_down),
//                                 iconSize: 30,
//                                 onChanged: ( val) {
//                                   setState(() {
//                                   selectassign(val.toString()); 
//                                   //  context.read<Outstandingcontroller>(). assignvalue  = val!;
//                                   });
//                                 },
//                                 items:  assigncolumn.map((e) {
//                                   return DropdownMenuItem(
//                                       value:e ,
//                                       child: Text(e));
//                                 }).toList(),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                 //  Customer
//                         Container(
//                 width: Screens.width(context),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                           child: Text(
//                         "Customer Name",
//                         style: theme.textTheme.bodyMedium!.copyWith(
//                             color: theme.primaryColor, fontSize: 15),
//                       )),
//                       SizedBox(
//                         height: Screens.padingHeight(context) * 0.01,
//                       ),
//                       Container(
//                         // color: Colors.amber,
//                         width: Screens.width(context),
//                         padding: EdgeInsets.only(top: 1, left: 10, right: 10),
//                         height: Screens.padingHeight(context) * 0.06,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.black26)),
//                         child: DropdownButton(
//                           isExpanded: true,
//                           underline: SizedBox.shrink(),
//                           value: cusnamevalue,
//                           icon: Icon(Icons.arrow_drop_down),
//                           iconSize: 30,
//                           onChanged: ( val) {
//                             setState(() {
//                            selectcusname(val.toString()); 
                                  
//                             });
//                           },
//                           items:customercolumn. map((e) {
//                             return DropdownMenuItem<String>(
//                                 value: "${e}",
//                                 child: Container(child: Text("${e.toString()}")));
//                           }).toList(),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                         ),
//                         //Trans Number
//                         Container(
//                 width: Screens.width(context),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                           child: Text(
//                         "From Date",
//                         style: theme.textTheme.bodyMedium!.copyWith(
//                             color: theme.primaryColor, fontSize: 15),
//                       )),
//                       SizedBox(
//                         height: Screens.padingHeight(context) * 0.01,
//                       ),
//                       Container(
//                         // color: Colors.amber,
//                         width: Screens.width(context),
                  
//                         height: Screens.padingHeight(context) * 0.06,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.black26)),
//                         child: TextField(
//                           onTap: (){
//                             context.read<QuotestabController>().showfromDate(context);
                           
//                           },
//                           controller: context.read<QuotestabController>().mycontroller[21],
//                           decoration: InputDecoration(
//                             hintText: "",
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             suffixIcon: IconButton(
//                               onPressed: (){
//                                 context.read<QuotestabController>().showfromDate(context);
                           
//                               },
//                               icon: Icon(
//                                 Icons.calendar_month,
//                                 color: theme.primaryColor,
//                               ),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               vertical: 10,
//                               horizontal: 5,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                         ),
//                         //Loan number
//                         Container(
//                 width: Screens.width(context),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                           child: Text(
//                         "To Date",
//                         style: theme.textTheme.bodyMedium!.copyWith(
//                             color: theme.primaryColor, fontSize: 15),
//                       )),
//                       SizedBox(
//                         height: Screens.padingHeight(context) * 0.01,
//                       ),
//                       Container(
//                         // color: Colors.amber,
//                         width: Screens.width(context),
                  
//                         height: Screens.padingHeight(context) * 0.06,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.black26)),
//                         child: TextField(
//                           onTap: (){
//                             context.read<QuotestabController>().showToDate(context); 
//                           },
//                           controller: context.read<QuotestabController>().mycontroller[22],
//                           decoration: InputDecoration(
//                             hintText: "",
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             suffixIcon: IconButton(
//                               onPressed: (){
//                                 context.read<QuotestabController>().showToDate(context);
//                               },
//                               icon: Icon(
//                                 Icons.calendar_month,
//                                 color: theme.primaryColor,
//                               ),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               vertical: 10,
//                               horizontal: 5,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                         ),
//                         //age Above
//                         //status
//                           Container(
//                 width: Screens.width(context),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                           child: Text(
//                         "Quotation Status",
//                         style: theme.textTheme.bodyMedium!.copyWith(
//                             color: theme.primaryColor, fontSize: 15),
//                       )),
//                       SizedBox(
//                         height: Screens.padingHeight(context) * 0.01,
//                       ),
//                       Container(
//                         // color: Colors.amber,
//                         width: Screens.width(context),
//                         padding: EdgeInsets.only(top: 1, left: 10, right: 10),
//                         height: Screens.padingHeight(context) * 0.06,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.black26)),
//                         child: DropdownButton(
//                           isExpanded: true,
//                           underline: SizedBox.shrink(),
//                           value: Enquirystatusvalue,
//                           icon: Icon(Icons.arrow_drop_down),
//                           iconSize: 30,
//                           onChanged: ( val) {
//                             setState(() {
//                            selectEnqstatus(val.toString()); 
                                  
//                             });
//                           },
//                           items:Enquirystatuscolumn. map((e) {
//                             return DropdownMenuItem<String>(
//                                 value: "${e}",
//                                 child: Container(child: Text("${e.toString()}")));
//                           }).toList(),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                         ),
//                         //looking for 
//                          Container(
//                 width: Screens.width(context),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                           child: Text(
//                         "Order Type",
//                         style: theme.textTheme.bodyMedium!.copyWith(
//                             color: theme.primaryColor, fontSize: 15),
//                       )),
//                       SizedBox(
//                         height: Screens.padingHeight(context) * 0.01,
//                       ),
//                       Container(
//                         // color: Colors.amber,
//                         width: Screens.width(context),
//                         padding: EdgeInsets.only(top: 1, left: 10, right: 10),
//                         height: Screens.padingHeight(context) * 0.06,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.black26)),
//                         child: DropdownButton(
//                           isExpanded: true,
//                           underline: SizedBox.shrink(),
//                           value: ordertypevalue,
//                           icon: Icon(Icons.arrow_drop_down),
//                           iconSize: 30,
//                           onChanged: ( val) {
//                             setState(() {
//                            selectordertype(val.toString()); 
                                  
//                             });
//                           },
//                           items:ordertypecolumn. map((e) {
//                             return DropdownMenuItem<String>(
//                                 value: "${e}",
//                                 child: Container(child: Text("${e.toString()}")));
//                           }).toList(),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                         ),
//                 //           Container(
//                 // width: Screens.width(context),
//                 // child: Padding(
//                 //   padding: const EdgeInsets.all(8.0),
//                 //   child: Column(
//                 //     crossAxisAlignment: CrossAxisAlignment.start,
//                 //     children: [
//                 //       Container(
//                 //           child: Text(
//                 //         "Lookingfor",
//                 //         style: theme.textTheme.bodyMedium!.copyWith(
//                 //             color: theme.primaryColor, fontSize: 15),
//                 //       )),
//                 //       SizedBox(
//                 //         height: Screens.padingHeight(context) * 0.01,
//                 //       ),
//                 //       Container(
//                 //         // color: Colors.amber,
//                 //         width: Screens.width(context),
//                 //         padding: EdgeInsets.only(top: 1, left: 10, right: 10),
//                 //         height: Screens.padingHeight(context) * 0.06,
//                 //         decoration: BoxDecoration(
//                 //             borderRadius: BorderRadius.circular(8),
//                 //             border: Border.all(color: Colors.black26)),
//                 //         child: DropdownButton(
//                 //           isExpanded: true,
//                 //           underline: SizedBox.shrink(),
//                 //           value: lookingforvalue,
//                 //           icon: Icon(Icons.arrow_drop_down),
//                 //           iconSize: 30,
//                 //           onChanged: ( val) {
//                 //             setState(() {
//                 //            selectlookingfor(val.toString()); 
                                  
//                 //             });
//                 //           },
//                 //           items:lookingforcolumn. map((e) {
//                 //             return DropdownMenuItem<String>(
//                 //                 value: "${e}",
//                 //                 child: Container(child: Text("${e.toString()}")));
//                 //           }).toList(),
//                 //         ),
//                 //       )
//                 //     ],
//                 //   ),
//                 // ),
//                 //         ),
//                 //         Container(
//                 // width: Screens.width(context),
//                 // child: Padding(
//                 //   padding: const EdgeInsets.all(8.0),
//                 //   child: Column(
//                 //     crossAxisAlignment: CrossAxisAlignment.start,
//                 //     children: [
//                 //       Container(
//                 //           child: Text(
//                 //         "Age Above",
//                 //         style: theme.textTheme.bodyMedium!.copyWith(
//                 //             color: theme.primaryColor, fontSize: 15),
//                 //       )),
//                 //       SizedBox(
//                 //         height: Screens.padingHeight(context) * 0.01,
//                 //       ),
//                 //       Container(
//                 //         // color: Colors.amber,
//                 //         width: Screens.width(context),
                  
//                 //         height: Screens.padingHeight(context) * 0.06,
//                 //         decoration: BoxDecoration(
//                 //             borderRadius: BorderRadius.circular(8),
//                 //             border: Border.all(color: Colors.black26)),
//                 //         child: TextField(
//                 //           // controller: context.read<Outstandingcontroller>().mycontroller[4],
//                 //           keyboardType: TextInputType.number,
//                 //           decoration: InputDecoration(
//                 //             hintText: "Age",
//                 //             enabledBorder: InputBorder.none,
//                 //             focusedBorder: InputBorder.none,
//                 //             // suffixIcon: Icon(
//                 //             //   Icons.search,
//                 //             //   color: theme.primaryColor,
//                 //             // ),
//                 //             contentPadding: const EdgeInsets.symmetric(
//                 //               vertical: 10,
//                 //               horizontal: 5,
//                 //             ),
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 //         ),
//                         //Balance Above
//                         Container(
//                 width: Screens.width(context),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                           child: Text(
//                         "Value Above",
//                         style: theme.textTheme.bodyMedium!.copyWith(
//                             color: theme.primaryColor, fontSize: 15),
//                       )),
//                       SizedBox(
//                         height: Screens.padingHeight(context) * 0.01,
//                       ),
//                       Container(
//                         // color: Colors.amber,
//                         width: Screens.width(context),
                  
//                         height: Screens.padingHeight(context) * 0.06,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.black26)),
//                         child: TextField(
//                           controller: context.read<QuotestabController>().mycontroller[23],
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             hintText: "value",
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             // suffixIcon: Icon(
//                             //   Icons.search,
//                             //   color: theme.primaryColor,
//                             // ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               vertical: 10,
//                               horizontal: 5,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                         ),
                
//                   ],
//                 ),
//               ),
//             ),
//             // SizedBox(height: Screens.padingHeight(context)*0.001,),
            
         
//          Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//           Container
          
//           (
//             width: Screens.width(context)*0.3,
//             child: ElevatedButton(onPressed: (){
//               Navigator.pop(context);
//             },
            
//               style: ButtonStyle(
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5)
//                 )
//                 )
//               ),
//              child: Text("Cancel"))),
//             Container(
//               width: Screens.width(context)*0.3,
              
//               child: ElevatedButton(onPressed: (){
//                setState(() {
//                   Navigator.pop(context);

//                 // context.read<Outstandingcontroller>().  onfilterapply();
//                });
               
//               },
          
//               style: ButtonStyle(
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5)
//                 )
//                 )
//               ),
//                child: Text("Apply")))
//          ],)
//           ],
//         ),
//       ),
//     )
    
//           ],
//       ),

//     );
//   }
// }